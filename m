Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUARVLh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 16:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263637AbUARVLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 16:11:37 -0500
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:22657 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263609AbUARVLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 16:11:36 -0500
Date: Sun, 18 Jan 2004 15:11:27 -0600 (CST)
From: Ryan Reich <ryanr@uchicago.edu>
Reply-To: Ryan Reich <ryanr@uchicago.edu>
To: linux-kernel@vger.kernel.org
Subject: Overlapping MTRRs in 2.6.1
Message-ID: <Pine.LNX.4.58.0401181458080.2194@ryanr.aptchi.homelinux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following message in the kernel log when X starts up:

mtrr: 0xe0000000,0x4000000 overlaps existing 0xe0000000,0x1000000
mtrr: 0xe0000000,0x4000000 overlaps existing 0xe0000000,0x1000000
[drm:radeon_cp_init] *ERROR* radeon_cp_init called without lock held
[drm:radeon_unlock] *ERROR* Process 1807 using kernel context 0

The complaint with radeon_unlock occurred in 2.4 for a while until I realized
that agpgart wasn't loading before radeon; that fixed it, but now it's returned
with 2.6 and I think the mtrr error is the cause.  In XFree86.log, I get the
single-line message

(WW) RADEON(0): Failed to set up write-combining range (0xe0000000,0x4000000)

and then, further down,

(WW) RADEON(0): [agp] AGP not available

and finally,

(II) RADEON(0): Direct rendering disabled

I checked the archives and no one has posted a message on MTRR overlaps since
2002.  At that time, Andrew Rodland wrote something about what appears to be
this exact problem; a link to it is

http://marc.theaimsgroup.com/?l=linux-kernel&m=102133293210888&w=2

It would seem this hasn't gotten fixed entirely, then.  For comparison, 'cat
/proc/mtrr' gives

reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
reg01: base=0xe8000000 (3712MB), size=  64MB: write-combining, count=1
reg02: base=0xe0000000 (3584MB), size=  16MB: write-combining, count=1

My video card is a Radeon 7000, 64M of memory; processor, Athlon 2600+;
motherboard, Shuttle AN35N with NForce2 chipset.

-- 
Ryan Reich
ryanr@uchicago.edu
