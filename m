Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSFUCuw>; Thu, 20 Jun 2002 22:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315971AbSFUCuv>; Thu, 20 Jun 2002 22:50:51 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:39883 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S315709AbSFUCuv>; Thu, 20 Jun 2002 22:50:51 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: William Thompson <wt@electro-mechanical.com>
Date: Fri, 21 Jun 2002 12:51:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15634.38076.959047.462763@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: partition md raid?
In-Reply-To: message from William Thompson on Wednesday June 19
References: <20020619103611.A7291@coredump.electro-mechanical.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday June 19, wt@electro-mechanical.com wrote:
> Is this possible (w/o using lvm)

Yes, but you need a patch...
http://www.cse.unsw.edu.au/~neilb/patches/linux-stable/
 2.4.19-pre8 section
      patch-Z-MdLocks
            Improve locking of MD related structure, particularly when reconfiguring 
      patch-a-RaidSplit
            Split raid requests that span chunks 
      patch-b-MdPart
            Enable partitioning of MD devices 
      patch-c-MdpMajor
            Define a static major number for mdp - partitioned md 

These patches should make the first 16 devices partitionable.
Without patch-c-MdpMajor, a free major number is allocated (usually
254, but no guarantees) and you have to either:
 - have a script which finds the number from /proc/devices and makes
   all the /dev entries, or
 - use devfs

With patch-c-MdpMajor, Major number "60" (LOCAL/EXPERIMENTAL USE) is
allocated for the partitioned md devices.

I use this in production.  I have two system discs (sda and sdb, or
hda and hdc) which are mirrored together as whole devices, and then
this is partitioned:
   mda1 == root
   mda2 == swap
   mda3 == other...

Getting lilo to cope was interesting, but it works.

NeilBrown
