Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSDMLuE>; Sat, 13 Apr 2002 07:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313157AbSDMLuD>; Sat, 13 Apr 2002 07:50:03 -0400
Received: from fungus.teststation.com ([212.32.186.211]:49168 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S313304AbSDMLuC>; Sat, 13 Apr 2002 07:50:02 -0400
Date: Sat, 13 Apr 2002 13:49:55 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Shing Chuang <ShingChuang@via.com.tw>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.19-pre6] via-rhine.c to support new VIA's nic chip
 VT6105, V6105M (correct).
In-Reply-To: <369B0912E1F5D511ACA5003048222B75A3C040@exchtp02.via.com.tw>
Message-ID: <Pine.LNX.4.33.0204131246420.5127-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2002, Shing Chuang wrote:

>       This patch applied to linux kernel 2.4.19-per6 to support VIA's new
> NIC chip.
>       However, VIA don't have any nic chip with pci device id 0x6100 so far,
> so this patch also remove the device ID 0x6100.

You are removing the entry for 0x3043, not 0x6100 ... Did you mean to also
change "0x1106, 0x6100" to "0x1106, 0x3043" ?

Older revision D-Link DFE530-TX NICs use a chip that identifies itself as
0x3043. This patch will break those.

0x3043 is listed in the VT86C100A03.pdf doc from ftp.via.com.tw. An older
vt86c100a.pdf from 1997 lists the id as 0x6100. Are you sure there are no
cards using 0x6100?


As you perhaps are aware VIA maintain their own linuxfet.c driver, which
is a modified version of the Donald Becker via-rhine.c driver in the
kernel.

http://www.viaarena.com/?PageID=71#lan
6105v10cVIA.zip seems to be the most recent.

If you look at that driver they use 0x30431106. And also that ReqTxAlign
is only on for the VT86C100A.

The driver itself has become quite ugly from all #ifdef'ing that goes on.
It even has two tables for detecting PCI cards, and the tables are not in
sync ... But whoever wrote it knows more than what you can find in the
public datasheets.

/Urban

