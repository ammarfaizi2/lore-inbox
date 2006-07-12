Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWGLQIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWGLQIc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 12:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWGLQIc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 12:08:32 -0400
Received: from mx1.suse.de ([195.135.220.2]:26307 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751448AbWGLQIb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 12:08:31 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] sysctl: Allow /proc/sys without sys_sysctl
Date: Wed, 12 Jul 2006 18:08:26 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <m1u05pkruk.fsf@ebiederm.dsl.xmission.com> <200607121652.21920.ak@suse.de> <m1lkqyc00d.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1lkqyc00d.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607121808.26555.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 17:32, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> 
> >> So it will correctly handle that sysctl being compiled out, and
> >> the fallback to using /proc.  The code seems to have been
> >> doing that since it was added to glibc in 2000.
> >
> > Using /proc is extremly slow for this.
> 
> How so it is the same code in the kernel.  Is open much slower than
> sys_sysctl?

Yes, the VFS adds quite a lot of overhead with its zillions of
locks and other complicated things.

I have also people complaining about /proc/cpuinfo overhead.
> 
> > You added significant cost to each program startup.
> 
> Not each program only the ones that use pthreads.

In modern glibc it's basically everything

> > I still think it's a good idea to simulate that sysctl and printk
> > the others.
> 
> To reduce the noise something like that makes sense.  I'm going to
> see if I can get glibc to use uname which should have the same effect.

And still printk for all old binaries?  Not a good idea.

You have to check for  this case in the printk stub anyways and 
if you check for it you can as well emulate it
(with a big fat comment that this won't be done for any other sysctl)

-Andi
