Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSABVcO>; Wed, 2 Jan 2002 16:32:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287070AbSABVcI>; Wed, 2 Jan 2002 16:32:08 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:32777 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287051AbSABVbt>;
	Wed, 2 Jan 2002 16:31:49 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: timothy.covell@ashavan.org, adriankok2000@yahoo.com.hk (adrian kok),
        linux-kernel@vger.kernel.org
Subject: Re: system.map 
In-Reply-To: Your message of "Wed, 02 Jan 2002 16:17:30 CDT."
             <200201022117.g02LHUV425569@saturn.cs.uml.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 03 Jan 2002 08:31:35 +1100
Message-ID: <10236.1010007095@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jan 2002 16:17:30 -0500 (EST), 
"Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:
>That's not a nice place. Besides the fact that System.map is
>neither library nor module, /lib/modules is less likely to
>exist than /boot is. It's a wee bit slower too.

/boot is a hangover from old i386 systems that could not boot past
cylinder 1024 so you needed a special partition to hold the boot
images.  That restriction does not exist on any system less than 5
years old nor on most non-i386 machines, the requirement for a special
/boot is obsolete on most machines.

System.map is not required for booting, it is only used after init
starts, therefore it does not belong in /boot anyway.

IA64 requires boot files to be in /boot/efi which must be a VFAT style
partition.  Trust me, you don't want anything in /boot/efi unless you
have to.

For all those reasons, putting System.map and .config in /boot is the
wrong thing to do.  There is no point in creating yet another directory
to hold these files when /lib/modules/`uname -r` will do the job.  Even
on systems with no modules, /lib/modules can be created to hold the
kernel specific files.  I put my bootable kernels in /lib/modules as
well, then I have exactly one place to remove to get rid of an old
kernel.

If it makes you feel happier, think of /lib/modules as 'kernel specific
data'.  Pity about the name but it is hard coded into too many programs
to change it to /lib/kernel or /kernel.

>It's a wee bit slower too.

????

