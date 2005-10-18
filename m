Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbVJREOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbVJREOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 00:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751415AbVJREOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 00:14:16 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:57706 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751381AbVJREOP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 00:14:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=TKdtuA0OsGNaFQ2p0d3G9pxDHQaK20U7SWjYapLGmuR6PaPgkZlfwsLND7NhdyD/TqvUmVUK99vYnoyFDh1540oU9ZGQ6lL4yJvgnW+Jr9e10cPhNEo9JblB9TkR9EZbS6Pg8/KSqbiX6B52uv5hMExZDlIZXxluVnYboj/6PXI=
Message-ID: <5bdc1c8b0510172114h38bd62bcsd4cedd275ea50959@mail.gmail.com>
Date: Mon, 17 Oct 2005 21:14:14 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc4-rt7 - mtrr questions
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   I have precious little to compare here, and no experience, but from
a thread on another list where I was looking at a machine that had
some error messages about mtrr I started looking at the 3 machines I
have here. They are all quite different machines and give quite
different results for mtrr setup. None the less it was the
AMD64/2.6.14-rc4-rt7 machine that seemed to have the least going on
which surprised me.

This machine is an AMD64 machine running 2.6.14-rc4-rt7. It has only a
single mtrr and nothing that seems to relate to the VGA controller:
Can this be correct? NOTE: This machien has an ATI VGA and since there
is no ATI driver yet this machine doesn't load a VGA driver outside of
Xorg-X11. Is this why I have no mtrr's?

mark@lightning ~ $ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
mark@lightning ~ $


This machine is a one year old Intel P4HT machine with (I think) a
shared memory  VGA architecture. Again, nothing really related
directly to the graphics controller, although it appears that the
machine has mapped out some of main memory, possibly for the VGA?

mark@dragonfly ~ $ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=983552MB: write-back, count=1
reg01: base=0x1f000000 ( 496MB), size=983056MB: uncachable, count=1
mark@dragonfly ~ $


This is the oldest machine, an Athlon XP 1600+ / KT266 type chipset.
It has an NVidia VGA with 256MB of memory. This machine's mtrr's seems
to make the most sense to me:

gigastudio ~ # cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x20000000 ( 512MB), size= 256MB: write-back, count=1
reg02: base=0xe8000000 (3712MB), size= 128MB: write-combining, count=1
reg07: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1
gigastudio ~ #

So I think the question is does all of this make sense, or is
2.6.14-rc4-rt7 not setting up the NForce4/AMD64/PCI-E system
correctly?

Thanks,
Mark
