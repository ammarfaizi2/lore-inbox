Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVEIRx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVEIRx7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 13:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbVEIRx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 13:53:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:50561 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261450AbVEIRx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 13:53:57 -0400
Date: Mon, 9 May 2005 10:53:46 -0700
From: Chris Wright <chrisw@osdl.org>
To: Kristian =?iso-8859-1?Q?S=F8rensen?= <ks@linnovative.dk>
Cc: James Morris <jmorris@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Any work in implementing Secure IPC for Linux?
Message-ID: <20050509175346.GZ23013@shell0.pdx.osdl.net>
References: <Xine.LNX.4.44.0505091058560.5582-100000@thoron.boston.redhat.com> <200505091940.22260.ks@linnovative.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200505091940.22260.ks@linnovative.dk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Kristian S?rensen (ks@linnovative.dk) wrote:
> On Monday 09 May 2005 17:00, James Morris wrote:
> > On Mon, 9 May 2005, Kristian Sørensen wrote:
> > > Does anyone here know of work being done in order to implement secure IPC
> > > for Linux?
> >
> > What do you mean by secure IPC?
> As I understand it, presently the memory for the message queue is shared based 
> on user and group ownership of the process. By "secure IPC" is meaning a 
> security mechanism that provides a more fine granularity of specifying who 
> are allowed to send (or receive) messages... and maby also a way to resolve 
> the question of "Can I trust the message I received?"

There's hooks to handle this.  See the security blob in struct
kern_ipc_perm (which is embedded in the various SysV ipc structures),
and the associated security hooks to manage the labels and provide
access control to the ipc objects.  Also, AF_UNIX is handled with
security hooks (see the unix_ hooks).  From that point forward, it's up
to you to label and enforce access control.  SELinux has some supoort
for this type of access control.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
