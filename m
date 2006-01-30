Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWA3Ezv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWA3Ezv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 23:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbWA3Ezv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 23:55:51 -0500
Received: from mail.kroah.org ([69.55.234.183]:10910 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751242AbWA3Ezu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 23:55:50 -0500
Date: Sun, 29 Jan 2006 20:51:53 -0800
From: Greg KH <greg@kroah.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Herbert Poetzl <herbert@13thfloor.at>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/5] pid: Implement task references.
Message-ID: <20060130045153.GC13244@kroah.com>
References: <m1psmba4bn.fsf@ebiederm.dsl.xmission.com> <m1lkwza479.fsf@ebiederm.dsl.xmission.com> <20060129190539.GA26794@kroah.com> <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1mzhe7l2c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2006 at 02:58:51PM -0700, Eric W. Biederman wrote:
> Greg KH <greg@kroah.com> writes:
> 
> > On Sun, Jan 29, 2006 at 12:22:34AM -0700, Eric W. Biederman wrote:
> >> +struct task_ref
> >> +{
> >> +	atomic_t count;
> >
> > Please use a struct kref here, instead of your own atomic_t, as that's
> > why it is in the kernel :)
> >
> >> +	enum pid_type type;
> >> +	struct task_struct *task;
> >> +};
> >
> > thanks,
> 
> I would rather not. Whenever I look at struct kref it seems to be an over
> abstraction, and as such I find it confusing to work with.  I know
> whenever I look at the sysfs code I have to actively remind myself
> that the kref in the structure is not a pointer to a kref.
> 
> What does the kref abstraction buy?  How does it simplify things?
> We already have equivalent functions in atomic_t on which it is built.

It ensures that you get the logic of the reference counting correctly.
It forces you to do the logic of the get and put and release properly.

To roughly quote Andrew Morton, "When I see a kref, I know it is used
properly, otherwise I am forced to read through the code to see if the
author got the reference counting logic correct."

It costs _nothing_ to use it, and let's everyone know you got the logic
correct.

So don't feel it is a "abstraction", it's a helper for both the author
(who doesn't have to get the atomic_t calls correct), and for everyone
else who has to read the code.

thanks,

greg k-h
