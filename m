Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSJWNOf>; Wed, 23 Oct 2002 09:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264973AbSJWNOf>; Wed, 23 Oct 2002 09:14:35 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:262 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S264972AbSJWNOe>;
	Wed, 23 Oct 2002 09:14:34 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: One for the Security Guru's 
In-reply-to: Your message of "Wed, 23 Oct 2002 09:02:51 -0400."
             <20021023130251.GF25422@rdlg.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 23 Oct 2002 23:20:33 +1000
Message-ID: <24321.1035379233@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Oct 2002 09:02:51 -0400, 
"Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:
>  The consultants aparantly told the company admins that kernel modules
>were a massive security hole and extremely easy targets for root kits.

Typical consultant rubbish.  Yes, LKMs can hide rooted systems, but the
system has already been broken into by then.  You must be root to load
a module or copy a module to /lib/modules, depmod ignores modules that
are not owned by root.  IOW, if somebody can load a module then they
already own your system!

Fingerprinting modules is a hardy perennial.  It cannot be done in user
space (how do you fingerprint the loader, libc, insmod etc.?), it can
only be done in kernel.  No kernel code exists to do that, although LSM
may be getting there.  The stumbling block is - who creates the
fingerprint?  Answer - root.  You are trying to identify the difference
between a valid root user and a malicious root user, both of whom have
exactly the same privileges.  It does not work!

LSM with its fine grained security model might help in this area, but
don't hold your breath.  LSM has not been accepted into the kernel yet.

>As a result every machine has a 100% monolithic kernel

There are techniques for getting the same effect as LKMs even when the
kernel is not compiled with modules.  Phrack had a series of articles
on this subject.  Turning off modules increases the effort of hiding
the break in by 5-10%, it does not make the system any more secure.
Remember, if somebody can load a module then they have already broken
in.

