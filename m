Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131226AbRC3JGS>; Fri, 30 Mar 2001 04:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131232AbRC3JGJ>; Fri, 30 Mar 2001 04:06:09 -0500
Received: from mail.zmailer.org ([194.252.70.162]:43021 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S131226AbRC3JF6>;
	Fri, 30 Mar 2001 04:05:58 -0500
Date: Fri, 30 Mar 2001 12:05:01 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: George Bonser <george@gator.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: 2.4.3 aic7xxx wont compile
Message-ID: <20010330120501.P23336@mea-ext.zmailer.org>
In-Reply-To: <CHEKKPICCNOGICGMDODJOEHOCJAA.george@gator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CHEKKPICCNOGICGMDODJOEHOCJAA.george@gator.com>; from george@gator.com on Thu, Mar 29, 2001 at 11:19:22PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 11:19:22PM -0800, George Bonser wrote:
> Just tried to build 2.4.3, got:
> 
> make[6]: Entering directory
> `/usr/local/src/linux/drivers/scsi/aic7xxx/aicasm'
> gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c
> aicasm_symbol.c -o aicasm
> aicasm/aicasm_gram.y:45: ../queue.h: No such file or directory
> aicasm/aicasm_gram.y:50: aicasm.h: No such file or directory
...
> `/usr/local/src/linux/drivers/scsi/aic7xxx/aicasm'
> ...
> Looks like something's missing here. Had 2.4.2 patched to 2.4.3-pre7, backed
> out pre7 and applied 2.4.3.

  Yes,  "-I." from gcc flags.

  The sad part is that people have been patching right and left to get
  that monster utility to compile because the dependencies say that it
  must be used to remake the AIC sequencer binary image; which image is
  perfectly ok except of its timestampts due to patching process.

  Sources from a tarball never get to this, because Linus has suffered
  the episode of patching it in, and compiling once -> timestamps are
  such that the resulting binary (ok, hex version of it) is newer than
  the source.

  There are two bugs in those aic7xxx/aicasm makefile(s):
    - Missing that  -I.  parameter for ${CC}
    - Having any sort of dependency from sequencer's images
      hexified binary (which the driver includes) to its source.

  While mr. Gibbs is right that it makes a lot of sense to supply
  the entire tool-chain to generate all generated parts of the aic7xxx
  driver, nobody should be forced to do the compilation, or then
  'make mrproper' should throw away the hexified sequencer code...

  Compiling of the sequencer source should be *some* make target in
  that driver directory, but not any of which normal users will
  encounter at any time.  That is, not a dependency target !

  Very few people need to go poking at the sequencer source, and
  they should manage to take a bit more complicated approach, than
  'make bzImage' or 'make modules' to achieve that.
  (i.e.: cd drivers/scsi/aic7xxx;make XYZ)

/Matti Aarnio  -- presenting own opinnions, obviously
