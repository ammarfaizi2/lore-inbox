Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUIPWVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUIPWVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 18:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUIPWTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 18:19:16 -0400
Received: from 147.32.220.203.comindico.com.au ([203.220.32.147]:51077 "EHLO
	relay01.mail-hub.kbs.net.au") by vger.kernel.org with ESMTP
	id S268004AbUIPWRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 18:17:21 -0400
Subject: Re: [PATCH] Suspend2 Merge: Driver model patches 2/2
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@digeo.com>, Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040916142847.GA32352@kroah.com>
References: <1095332331.3855.161.camel@laptop.cunninghams>
	 <20040916142847.GA32352@kroah.com>
Content-Type: text/plain
Message-Id: <1095373127.5897.23.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 17 Sep 2004 08:18:47 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-09-17 at 00:28, Greg KH wrote:
> On Thu, Sep 16, 2004 at 08:58:51PM +1000, Nigel Cunningham wrote:
> > 
> > This simple helper adds support for finding a class given its name. I
> > use this to locate the frame buffer drivers and move them to the
> > keep-alive tree while suspending other drivers.
> > 
> > +struct class * class_find(char * name)
> > +{
> > +	struct class * this_class;
> > +
> > +	if (!name)
> > +		return NULL;
> > +
> > +	list_for_each_entry(this_class, &class_subsys.kset.list, subsys.kset.kobj.entry) {
> > +		if (!(strcmp(this_class->name, name)))
> > +			return this_class;
> > +	}
> > +
> > +	return NULL;
> > +}
> 
> Ick, no.  I've been over this before with the fb people, and am not going
> to accept this patch (nevermind that it's broken...)  See the lkml
> archives for more info on why I don't like this.

Please excuse my ignorance but I don't see how it's broken (their patch
just fills in a field that was left blank previously), and this patch
just makes use of that change. What's the point to device_class if we
don't use it?

That said, I do agree with using Pavel's new enum that includes
_SNAPSHOT and can see that it's a cleaner way in that it requires less
knowledge on suspend's part of what it wants to stay alive.

Regards,

Nigel

-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

