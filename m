Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUHVUD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUHVUD7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 16:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268086AbUHVUD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 16:03:59 -0400
Received: from qfep05.superonline.com ([212.252.122.162]:24517 "EHLO
	qfep05.superonline.com") by vger.kernel.org with ESMTP
	id S268085AbUHVUD4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 16:03:56 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Cursed Checksums
Date: Sun, 22 Aug 2004 23:03:54 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
In-Reply-To: <1093174820.24319.60.camel@localhost.localdomain>
Thread-Index: AcSIRh5CXoA6qujqT3yX0egGDwhtIAARKgxg
Message-Id: <S268085AbUHVUD4/20040822200356Z+207@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perhaps there is a way to recompute IP header checksums before they get into
the interface? As I outlined, I have found a way to manipulate IP source
address before the packet is flushed to system, but a means of recalculating
the IP header checksum after that manipulation should be found. Because even
if I ignore IP header CRC in one system, all other boxes connected to this
machine has to be patched the same. That is impossible anyway.

Only if I could find a way to recalculate the checksum in IP headers by
doing a simple hack to the kernel, everything would be alright. 

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Alan Cox
Sent: Sunday, August 22, 2004 1:40 PM
To: Josan Kadett
Cc: Linux Kernel Mailing List
Subject: Re: Cursed Checksums

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
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



