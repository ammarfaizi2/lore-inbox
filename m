Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314613AbSD0Uot>; Sat, 27 Apr 2002 16:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314615AbSD0Uos>; Sat, 27 Apr 2002 16:44:48 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:16568 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S314613AbSD0Uoq>;
	Sat, 27 Apr 2002 16:44:46 -0400
Date: Sat, 27 Apr 2002 21:43:06 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: <tigran@einstein.homenet>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
cc: Matthew M <matthew.macleod@btinternet.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Microcode update driver
In-Reply-To: <Pine.LNX.4.44.0204272232290.2833-100000@mustard.heime.net>
Message-ID: <Pine.LNX.4.33.0204272137320.1792-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Apr 2002, Roy Sigurd Karlsbakk wrote:
> ok. so what the kernel is telling me during boottime (IA-32 Microcode
> Update Driver: v1.09 <tigran@veritas.com>), is simply having the driver to
> enable such uploads? It'd be great to have this documented openly
> somewhere.

The message means that the driver has registered a device
/dev/cpu/microcode with your kernel. Looking in /proc/misc you discover
that it is registered on minor 184 as a "misc" driver:

# modprobe microcode
# dmesg | tail -1
IA-32 Microcode Update Driver: v1.11 <tigran@veritas.com>
# cat /proc/misc
184 microcode
135 rtc
  1 psaux
134 apm_bios

There is nothing special about microcode driver in this respect -- it is
just like any other device driver. I.e. userspace application opens the
device node /dev/cpu/microcode and writes the microcode data to it and,
possibly, uses an ioctl to free the memory (if the user isn't interested
in keeping a copy of what has been applied to each cpu).

Regards
Tigran

