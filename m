Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261366AbVBNI0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbVBNI0z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 03:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVBNI0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 03:26:55 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:33682 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S261366AbVBNI0w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 03:26:52 -0500
Subject: Re: [RFC][PATCH 2.6.11-rc3-mm2] Relay Fork Module
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Gerrit Huizenga <gh@us.ibm.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Jay Lan <jlan@engr.sgi.com>
In-Reply-To: <20050211191112.GB19139@kroah.com>
References: <1107786245.9582.27.camel@frecb000711.frec.bull.fr>
	 <20050207154623.33333cda.akpm@osdl.org>
	 <1108109504.30559.43.camel@frecb000711.frec.bull.fr>
	 <20050211005446.081aa075.akpm@osdl.org>
	 <1108134520.14068.66.camel@frecb000711.frec.bull.fr>
	 <20050211191112.GB19139@kroah.com>
Date: Mon, 14 Feb 2005 09:26:49 +0100
Message-Id: <1108369609.25606.29.camel@frecb000711.frec.bull.fr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/02/2005 09:35:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/02/2005 09:35:36,
	Serialize complete at 14/02/2005 09:35:36
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-11 at 11:11 -0800, Greg KH wrote:
> > +	char *kobj_path = NULL;
> > +	char *action_string = NULL;
> > +	char **envp = NULL;
> > +	char ppid_string[FORK_BUFFER_SIZE];
> > +	char cpid_string[FORK_BUFFER_SIZE];
> > +
> > +	if (!uevent_sock)
> > +		return;
> > +	
> > +	action_string = action_to_string(KOBJ_FORK);
> > +	if (!action_string)
> > +		return;
> > +	
> > +	kobj_path = kobject_get_path(kobj, GFP_KERNEL);
> > +	if (!kobj_path)
> > +		return;
> 
> How is there a path for a kobject that is never registered with sysfs?

My kobject has a name, kobject_set_name(&fork_kobj, "fork_kobj"), and no
parent so I thought that the path returned by kobject_get_path() was
"/fork_kobj" even if the kobject is not registered with sysfs. As
send_uevent() function needs an object path, I used the
kobject_get_path() routine.

> I agree with Andrew, why are you using a kobject for this?  Have you
> looked at the "connector" code that is in the -mm tree?  That might be a
> better solution for this, and it will be going into the kernel tree
> after 2.6.11 is released.

 I'm using kobject because it allows to notify user space application by
sending an event and as I need to send a kernel event (fork event) to a
user space application I thought about kobject. Do you think that it's
not the good solution because it's a too big mechanism for what I want
to do?
 
 I haven't looked at the "connector" code and I will have a look now.
Thank you very much to point this. 

Thank you for your comments and your help, 
Regards,
Guillaume

