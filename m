Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131369AbRDBWKK>; Mon, 2 Apr 2001 18:10:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131376AbRDBWKA>; Mon, 2 Apr 2001 18:10:00 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:35281 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131369AbRDBWJr>;
	Mon, 2 Apr 2001 18:09:47 -0400
Message-ID: <3AC8F881.F20A19A6@mandrakesoft.com>
Date: Mon, 02 Apr 2001 18:09:05 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-20mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Oliver Xymoron <oxymoron@waste.org>, David Lang <dlang@diginsite.com>,
   Manfred Spraul <manfred@colorfullife.com>,
   "Albert D . Cahalan" <acahalan@cs.uml.edu>, lm@bitmover.com,
   linux-kernel@vger.kernel.org
Subject: Re: bug database braindump from the kernel summit
In-Reply-To: <Pine.LNX.3.96.1010401181724.28121i-100000@mandrakesoft.mandrakesoft.com> <Pine.LNX.4.30.0104021436110.24812-100000@waste.org> <20010402234045.C17148@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" wrote:
> Could <installkernel> make part of the kernel scripts, or in one other
> standard software package, like modutils, so its versions are controlled

There is value in putting it into the Linux kernel source tree, in
linux/scripts dir.  But most vendors can and should take this script as
a sample, and customize it for their distro.  The Linux-Mandrake
installkernel script definitely gets touched every so often, and
decisions it makes, like updating lilo.conf or grub/menu.lst, or
autodetecting the boot loader, are definitely not to be applied for all
cases.

FWIW here is our /sbin/installkernel command line usage help text, to
give a glimpse of what it does and can do:

Usage: ${0##*/} -[lngarhcq] KERNEL_VERSION BOOTIMAGE MAPFILE

  -l:  Add a lilo entry
  -i:  Dont generate Initrd files           
  -n:  Don't launch lilo.
  -g:  Add a Grub entry.
  -d:  Don't autodetect boot loader.
  -a:  Autodetect boot loader.
  -r:  Features for RPM post install.
  -c:  Don't copy files.
  -q:  Be quiet.
  -h:  This help.


> I think the best solution would be to make /boot the 'official' place for
> kernels, the -X.Y.Z naming an standard, installkernel should save System.map
> and .config.

There will never be an official place to put this stuff, because that's
a distro policy decision.  A quick search just now reveals no reference
to /boot in the i386 Makefiles, and only a quick reference in the README
file.

> And you can add something like /proc/signature/map, /proc/signature/config,
> etc to md5-check if a certain file fits running kernel.

Additionally, everyone should remember: /proc is not a dumping ground :)

Ad-hoc naming like this has created the procfs namespace ugliness we
have now... let's not add to it unless we have to, and unless we have a
good idea of proper naming.

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
