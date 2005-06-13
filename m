Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVFMPOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVFMPOo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 11:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVFMPO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 11:14:26 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50579 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261614AbVFMPMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 11:12:13 -0400
Date: Mon, 13 Jun 2005 11:12:02 -0400
From: Neil Horman <nhorman@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Neil Horman <nhorman@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Matthew Wilcox <matthew@wil.cx>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch][RFC] fcntl: add ability to stop monitored processes
Message-ID: <20050613151202.GE8810@hmsendeavour.rdu.redhat.com>
References: <20050611000548.GA6549@hmsendeavour.rdu.redhat.com> <20050611180715.GK24611@parcelfarce.linux.theplanet.co.uk> <20050611193500.GC1097@devserv.devel.redhat.com> <20050612181006.GC2229@hmsendeavour.rdu.redhat.com> <1118643185.5260.12.camel@laptopd505.fenrus.org> <20050613134826.GB8810@hmsendeavour.rdu.redhat.com> <1118671411.13260.31.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118671411.13260.31.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 03:03:32PM +0100, Alan Cox wrote:
> On Llu, 2005-06-13 at 14:48, Neil Horman wrote:
> > The idea I had was to catch processes which are preforming ostensibly
> > undesireable filesystem operations (as defined by the actions that F_NOTIFY can
> > monitor).  I'm not sure how else to avoid the race condition that can arise
> > between the delivery of the F_NOTIFY signal to the monitoring process, and the
> > exiting of the monitored process. If you have another thought, I'm certainly
> > open to it.
> 
> I'm more worried you will make things worse not better. My first thought
> was what stops me just filling up the file table with admin work
> possibly also involving setuid processes so the end user cannot rescue
> the situation.
> 
I understand the concern here, but can't root always do desructive things to the
system?

> If its trying to do debugging then ptrace makes sense and the parent
> would be notified. Ptrace deals with exit of tracer and security for
> you. If you are trying to implement a security policy then the selinux
> hooks already allow you to block access to those files by selected
> processes anyway just as your F_NOTIFY hook would do, and you could even
> write a new security layer with a daemon that decided for the F_NOTIFY
> equivalents.
> 
I'll certainly try this again using the ptrace interface, rather than fcntl.  Do
you think the whole F_NOTIFY function should move over, or just this particular
feature?

Neil
> Alan
> 

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
