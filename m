Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264013AbTJFSmd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 14:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264015AbTJFSmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 14:42:32 -0400
Received: from gemini.smart.net ([205.197.48.109]:1552 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S264013AbTJFSmW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 14:42:22 -0400
Message-ID: <3F81B790.B8AF7136@smart.net>
Date: Mon, 06 Oct 2003 14:42:24 -0400
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: IDE DMA errors, massive disk corruption:  Why?  Fixed Yet?  Why not 
 re-do failed op?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got bitten _again_ by IDE DMA timeout errors and massive 
filesystem corruption in kernel 2.4.22 (on an Asus A7M266-D dual-Athlon 
XP motherboard (AMD 768 chip / amd7441 IDE controller)).

(I had turned DMA off in my init scripts, but apparently Debian 
unstable's k7-smp configuration enables DMA by default before my init
scripts get control.  Ext3 journal "recovery" trashed my system 
partition.)

What's going on with the IDE DMA bugs?  They have existed since 2.2 
(right?), and even at .22 in the 2.4 series they still exist.  Why
have they been around so long?  Is it that few kernel developers use
the combinations of hardware or configuration options that expose
the bugs (like my dual-CPU box with IDE, not SCSI, disks)?

Are the DMA bugs believed to be fixed (for real) yet?  IF so, in which 
version?

Is there any consolidated documentation of the combinations of factors
that cause corruption, or of how to reliably avoid corruption (like
all the things to check to make sure your kernel never even tries to 
enable DMA)?


Also, why does a DMA timeout cause such corruption?  Doesn't the kernel 
keep track of uncompleted operations, retain the information needed to
try again, and try again if there's a failure?  If not, why not?

If it can't try again, shouldn't the kernel at least abort after one 
disk-write failure instead of performing additional writes, which
frequently depend on the previous writes?  (E.g., if I try to read 
block 1's data and write it to block 2, and then write something new 
to block 1, if the first write fails but continue and do the second
write, data gets destroyed.  If the first write fails and I stop right 
away, less is destroyed.)




Daniel
-- 
Daniel Barclay
dsb@smart.net
