Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264145AbUANSny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 13:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbUANSny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 13:43:54 -0500
Received: from 195-23-16-24.nr.ip.pt ([195.23.16.24]:163 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S264145AbUANSnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 13:43:45 -0500
Message-ID: <40058DAB.30802@grupopie.com>
Date: Wed, 14 Jan 2004 18:42:51 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: John Lash <jkl@sarvega.com>, s0095670@sms.ed.ac.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Catch 22
References: <400554C3.4060600@sms.ed.ac.uk>	<20040114090137.5586a08c.jkl@sarvega.com> <20040114091456.752ad02d.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> On Wed, 14 Jan 2004 09:01:37 -0600 John Lash <jkl@sarvega.com> wrote:
> 
> | On Wed, 14 Jan 2004 14:40:03 +0000
> | Michael Lothian <s0095670@sms.ed.ac.uk> wrote:
> | 
> | > Just thaought I'd let you know about my experiences with Mandrake using
> | > the 2.4 and 2.6 kernels on my new hardware which is primaraly a Asus
> | > A7V600 (KT600) Motherboard and Radeon 9600XT
> | > 
> | > Under 2.4 my ATA hard drak is mounted under /dev/hda where as under 2.6
> | > is /dev/hde so there is no wasy way to switch between them with lilo and
> | > /etc/fstab needing to be changed
> | > 
> | 
> | At least in this case, you should be able to use volume labels for the
> | filesystems instead of the actual device names. Check out tune2fs -L. You then
> | reference the volume label in your fstab.
> | 
> | With lilo, you can specify that boot disk and root disk on the command line.
> | Also you can point lilo to a different config file using lilo -C. Not seamless
> | but should allow you to bounce back and forth w/o editing files....
> 
> Does anyone know the reason for this (ATA ident/naming change)?
> 
> I do *not* see this and I'm also using Mandrake (v9.0, not later).
> 


I guess the problem is that, by default, Mandrake creates an extended partition 
when installed, where all the other partitions go.

Whenever I install Mandrake, I'm always careful to switch to "Expert" mode and 
configure the partitions to be primary by hand to avoid this kind of problems.

If you are a corageous hacker, you can always:

  - boot from a CD distribution (knoppix, etc.)
  - run fdisk on your hard drive
  - take note on the cylinders being used by the partitions,
  - delete the partitions on the extended partition, and the extended partition 
itself
  - create the partitions again as primary using the *exact* same cylinders
  - write the partition to disk
  - reboot

Probably you'll have to adjust fstab to use the new partitions, but at least 2.4 
and 2.6 should both agree that you have an hda :)

I don't know if you'll need to run lilo again before rebooting, but I would do 
that just to be on the safe side. To do that:

  - mount /dev/hda somewhere (/mnt/disk or something)
  - # cd /mnt/disk
  - edit etc/lilo.conf to always use /dev/hda
  - # chroot . lilo

I hope this helps,

-- 
Paulo Marques - www.grupopie.com

"In a world without walls and fences who needs windows and gates?"

