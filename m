Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132501AbRCaWQK>; Sat, 31 Mar 2001 17:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132507AbRCaWQB>; Sat, 31 Mar 2001 17:16:01 -0500
Received: from maild.telia.com ([194.22.190.3]:60945 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S132501AbRCaWPu>;
	Sat, 31 Mar 2001 17:15:50 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Sandy Harris <sandy@storm.ca>, linux-kernel@vger.kernel.org
Subject: Re: [speculation] Partitioning the kernel
Date: Sun, 1 Apr 2001 00:12:40 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3AC64428.4492ABE7@storm.ca>
In-Reply-To: <3AC64428.4492ABE7@storm.ca>
MIME-Version: 1.0
Message-Id: <01040100124001.00881@jeloin>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 March 2001 22:55, Sandy Harris wrote:
> I'm wondering whether we have or need a formalisation of how work might be
> divided in future kernels.
>
> The question I'm interested in is how the work gets split up among various
> components at different levels within a single box (not SMP with many at
> the same level, or various multi-box techniques), in particular how you
> separate computation and I/O given some intelligence in devices other than
> the main CPU (or SMP set).
>
> There are a bunch of examples to look at:
>
> 	IBM mainframe
> 	  "channel processors" do all the I/O
> 	  main CPU sets up a control block, does an EXCP instruction
> 	  there's an interrupt when operation completes or fails
>
> 	VAX 782: basically two 780s with a big cable between busses
> 	  one has disk controllers, most of the (VMS) kernel
> 	  other has serial I/O, runs all user processes
>
> 	various smart network or disk controllers
> 	and really smart ones that do RAID or Crypto
>
> 	I2O stuff on newer PCs
>
> 	Larry McVoy's suggestion that the right way to run, say, a 32-CPU
> 	  box is with something like 8 separate kernels, each using 4 CPUs
> 	If one of those runs the file system for everyone, this somewhat
> 	  overlaps the techniques listed above.
>
> All of these demonstrably work, but each partitions the work between
> processors in a somewhat different way.
>
> What I'm wondering is whether, given that many drivers have a top-half
> vs. bottom-half split as a fairly basic part of their design, it would
> make sense to make it a design goal to have a clean partition at that
> boundary.
>
> On well-endowed systems, you then have the main CPUs running the top half
> of everything, while I2O processors handle all the bottom halves and the
> I/O interrupts. On lesser boxes, the CPU does both halves.
>
> It seems to me this might give a cleaner design than one where the work
> is partitioned between devices at some other boundary.
>
> If the locks you need between top and bottom halves of the driver are also
> controlling most or all CPU-to-I2O communication, it might go some way
> toward avoiding the "locking cliff" McVoy talks of.

A small cheap processor to do this with would be the ETRAX 100LX (LX = Linux)
Put an ETRAX100LX (integrated IDE, ethernet, and ...) on an IDE controller.
Telnet / SSH to your PCI boards :-)

Cheapest possible system might be one without a main CPU...
It would be possible to rebalance where to create the interface over time.

/RogerL


-- 
Roger Larsson
Skellefteå
Sweden
