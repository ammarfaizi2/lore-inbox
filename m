Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262977AbUKRVX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbUKRVX3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 16:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbUKRVV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 16:21:29 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:56372 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262980AbUKRVUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 16:20:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=AQad3QahBl3o6pYQK3m4ld3rgjkakYE+/NEMwZbrXqhrlAij73khuKw9M6m/NcNPdRrFAgDAyetNLL40wxYlXbqmfLdFISgNSAKmM/YekcmVsLhPfgZEgB0r7VuSzTmy1PVaUoG/gUa6HKxpkjIAacKz0WtqSNPYLt6FLd/XKtQ=
Message-ID: <aec7e5c304111813202f74a139@mail.gmail.com>
Date: Thu, 18 Nov 2004 22:20:48 +0100
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: e820 and shared VGA memory problem
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heya,

The machine is a Uniwill 223II0 equipped with 2GiB RAM and BIOS
1.03US. The graphics are 855GM, aka "Intel Extreme Graphics 2", ie a
chunk of system RAM is used as graphics memory. The BIOS does not
allow me to setup the amount of VGA RAM.

I am running a vanilla 2.6.9-kernel configured with highmem enabled.

The problem is that the machine is slow as hell if the kernel is
booted without limiting the amount of system ram with the command line
option "ram=xM". And by that I mean that executing user space programs
is _extremely_ slow - I've never taken the time to go through the
rc-scripts.

If I limit down the memory passed to the kernel to 2017M, the
performance is better but still not good. If I limit the amount of RAM
to 2016M everything is fine and dandy.

Funny enough, 2016M is the same as 2048 - 32 MiB. And the log of Xorg say:
..
(==) I810(0): VideoRAM: 32768 kByte
..

The "changelog" for the BIOS between 1.02 and 1.03 say:
..
2-1. VGA default share memory change from 8MB to 16MB
..

And the CMOS setup thinks that the amount of system memory is 2032MB.

This is the e820 output from the kernel when I limit to 2016 MiB.
..
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000007efd0000 (usable)
 BIOS-e820: 000000007efd0000 - 000000007efdf000 (ACPI data)
 BIOS-e820: 000000007efdf000 - 000000007f000000 (ACPI NVS)
user-defined physical RAM map:
 user: 0000000000000000 - 000000000009fc00 (usable)
 user: 000000000009fc00 - 00000000000a0000 (reserved)
 user: 00000000000e0000 - 0000000000100000 (reserved)
 user: 0000000000100000 - 000000007e000000 (usable)
1120MB HIGHMEM available.
896MB LOWMEM available.
...

So, the CMOS setup, the BIOS changelog, the e820 data all seem to
think that 16 MiB are used as VGA RAM. But I suspect that the extreme
slowdowns are because 32 MiB VGA RAM is used.  Any ideas? Is the BIOS
funky, or are we doing something wrong in the kernel?

Thanks!

/ magnus
