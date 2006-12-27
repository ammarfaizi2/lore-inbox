Return-Path: <linux-kernel-owner+w=401wt.eu-S932684AbWL0VPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbWL0VPL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 16:15:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbWL0VPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 16:15:11 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:36283
	"EHLO grelber.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932684AbWL0VPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 16:15:10 -0500
From: Rob Landley <rob@landley.net>
To: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: Feature request: exec self for NOMMU.
Date: Wed, 27 Dec 2006 16:13:51 -0500
User-Agent: KMail/1.9.1
Cc: Vadim Lobanov <vlobanov@speakeasy.net>, ray-gmail@madrabbit.org,
       linux-kernel@vger.kernel.org,
       David McCullough <david_mccullough@au.securecomputing.com>
References: <200612261823.07927.rob@landley.net> <200612270329.16320.rob@landley.net> <4592C038.8010407@madrabbit.org>
In-Reply-To: <4592C038.8010407@madrabbit.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612271613.52464.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 December 2006 1:49 pm, Ray Lee wrote:
> >>> I haven't got a man page for fexecve.  Does libc have it?
> >> It's implemented inside glibc, and uses /proc to execve() the file that
> >> the fd points to.
> 
> Oh, hmm. Then I think it won't work, will it? I'd assumed fexecve was
> implemented in kernel.

It sort of is.  Through the /proc filesystem, the kernel provides a path 
through which to open any arbitrary file descriptor, thus providing 
the "path" argument that the exec syscall requires.

> > Cute, and I can do that.  Assuming /proc is mounted in the chroot 
> > environment...
> 
> Maybe I'm just confused -- wouldn't be the first time -- but if it's
> implemented inside userspace, then once you chroot() you won't be able
> to execute the path you find via /proc, will you?

You need /proc mounted in the new chroot for it to work.  It's not a complete 
solution, but an incremental improvement over the previous hack.

Of course today what you can do is copy busybox into the top directory of the 
new chroot directory, execute that via the standard chroot command, 
run "/busybox mount -n -t procfs /proc /proc", and then let the 
current /proc/self/exe logic handle things from there.  (Or configure busybox 
to use /busybox instead of /proc/self/exe as the re-exec-self path.)

Rob
-- 
"Perfection is reached, not when there is no longer anything to add, but
when there is no longer anything to take away." - Antoine de Saint-Exupery
