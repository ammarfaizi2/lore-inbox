Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSFFAA5>; Wed, 5 Jun 2002 20:00:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316572AbSFFAA4>; Wed, 5 Jun 2002 20:00:56 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:5387 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316569AbSFFAAz>;
	Wed, 5 Jun 2002 20:00:55 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically 
In-Reply-To: Your message of "Wed, 05 Jun 2002 15:47:16 -0400."
             <20020605194716.4290.qmail@web14906.mail.yahoo.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jun 2002 10:00:45 +1000
Message-ID: <30677.1023321645@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jun 2002 15:47:16 -0400 (EDT), 
Michael Zhu <mylinuxk@yahoo.ca> wrote:
>Hi, I've read the man page of modules.conf. But I
>still couldn't figure out how to solve my problem. I
>mean how to change the modules.conf file. Can I edit
>this file directly? Can anyone give me an example?

/etc/modules.conf does NOT automatically load modules.  It contains
information that is applied to a module during the load process but
something else has to trigger the initial module load.  NB, not
conf.modules, that is an alternative name that is obsolete.

The initial load can be manual (user types 'modprobe foo') or
automatic.  For the automatic case, a module can be requested by kernel
code (CONFIG_KMOD eventually runs 'modprobe foo' from the kernel) or
some startup script can issue modprobe.  Startup scripts vary from one
distribution to another, look in /etc/rc.sysinit, /etc/rc.local and
/etc/rc.d/ for references to modules to find out how your distribution
does automatic loading at startup.

Redhat does most of the work in /etc/rc.sysinit, other distributions
may vary.  That code explicitly loads sound drivers if they are listed
in /etc/modules.conf, then if /etc/rc.modules exists, it tries to
execute that script.  So define /etc/rc.modules, mark it executable and
put your modprobe commands in that file.

