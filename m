Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265153AbTFMFww (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 01:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265157AbTFMFwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 01:52:51 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:65533 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S265153AbTFMFwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 01:52:49 -0400
Subject: Re: [RFC][2.5] list_for_each_safe not so safe (was Re: OOPS
	w83781d during rmmod (2.5.70-bk1[1234]))
From: Martin Schlemmer <azarah@gentoo.org>
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
In-Reply-To: <20030613023651.GA1401@earth.solarsys.private>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
	 <20030610054107.GA22719@earth.solarsys.private>
	 <1055401021.5280.3143.camel@workshop.saharacpt.lan>
	 <20030613023651.GA1401@earth.solarsys.private>
Content-Type: text/plain
Organization: 
Message-Id: <1055484528.5281.4544.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 13 Jun 2003 08:08:48 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-13 at 04:36, Mark M. Hoffman wrote:

> > Nope, this do not fix it.
> > 
> > The problem is actually at the i2c driver side.  From
> > drivers/i2c/i2c-core.c in i2c_del_driver(), we have:
> <cut>
> 
> To recap:  list_for_each_safe() is not safe for deleting other than
> the current "item".  But I disagree with you Martin because I think
> the usage in i2c_del_driver is ok as is; and that w83781d.c should
> change...
> 

Right, I will not argue, as I was not sure on usage (and thus the
mail).  Might be right thing (tm) to send a patch to make it more
clear that its only 'safe' for current item deletion (against
list.h) ?

> My first patch was naive; the patch below solves the problem by
> letting w83781d_detach_client remove the three clients (1 * primary
> + 2 * subclients) independently.  It's a noisy patch because I had
> to change the way the subclients were kmalloc'ed - sorry.  The meat
> is around line 1422.  This patch works for me... comments?
> 

I did try this way, but did it rather brutish =)  It thus still did
not fix it.  Your patch looks good ... I will try it tonight at home.


Regards,

-- 
Martin Schlemmer


