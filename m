Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262181AbTHTT6N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 15:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262182AbTHTT6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 15:58:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:57216 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262181AbTHTT6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 15:58:10 -0400
Date: Wed, 20 Aug 2003 16:00:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: John Riggs <jriggs@altiris.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 48-bit Drives Incorrectly reporting 255 Heads?
In-Reply-To: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>
Message-ID: <Pine.LNX.4.53.0308201541050.15454@chaos>
References: <88A7BC80FA2797498AF6D865CAD3EA43180E95@iceman.altiris.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Aug 2003, John Riggs wrote:

>   With the 2.4.20 kernel, I have a 40GB disk with 240 heads, with 48-bit
> mode enabled. The Linux ide driver automatically declares that anything
[SNIPPED...]

>   Two more specific questions are:
>     1) Will this break drives > 137 GB?
>     2) Why would the head count be set to 255 in the first place?

In the BIOS, in 'real-mode' the head to read/write is put into
the DH register. This is an 8-bit register. Drives that can boot
(they boot using interrupt 0x13 to read the drive), can't have more
that 256 heads (0->255).

Heads     = 8 bits   = 256
Cylinders = 10 bits  = 1024
Sectors   = 6 bits   = 64

You get large media by translating to a large bytes/sector number.
If the "real" bytes/sector number is 256 this means that the largest
size media one could use (to boot) is 256 * 1024 * 64 * 256 =
4,294,967,296 bytes. A 137 GB needs 137/4 ~= 35  times more than
256 = 8960 bytes per sector or more.

If you tell GRUB or LILO that the media has more than 256 heads,
it won't (can't) write the boot tracks.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


