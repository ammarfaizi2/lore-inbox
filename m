Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266802AbUHVMnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266802AbUHVMnD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 08:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266813AbUHVMnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 08:43:03 -0400
Received: from the-village.bc.nu ([81.2.110.252]:46478 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266802AbUHVMmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 08:42:47 -0400
Subject: Re: Cursed Checksums
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Josan Kadett <corporate@superonline.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <S268813AbUHUBhN/20040821013713Z+1335@vger.kernel.org>
References: <S268813AbUHUBhN/20040821013713Z+1335@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093174820.24319.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 12:40:21 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-21 at 03:37, Josan Kadett wrote:
> When I manually calcaulate the checksum in the incoming TCP and UDP packets
> and re-inject them back to the socket, everything works fine. That is, the
> data integrity is not damaged or corrupted at all.

At least for the few you looked at. That proves nothing.

> I tried to investigate the code in tcp_input.c and udp.c to see if I can
> disable the checksum control for inbound packets entirely. No use it was
> since I need to do this urgently.

It depends on your hardware. With modern network cards we do the
checksum processing in hardware. For older setups passing a packet
through a Linux box won't directly help as the ttl recomputation is done
without recalculation from scratch.

We also have a pile of paths for checksumming including copy/checksum
rolled into one so it isn't easy to remove there.

I'd take up the issue with the vendor of the broken object. If its
something like an internal prototype you need to test then you'll
probably have to write a user space application using raw sockets to
communicate with it and do the fixups/passthrough in use space. Pretty
horrible either way.

Alan


Alan
