Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129517AbQKAMyK>; Wed, 1 Nov 2000 07:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129766AbQKAMyA>; Wed, 1 Nov 2000 07:54:00 -0500
Received: from [62.172.234.2] ([62.172.234.2]:47689 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129517AbQKAMxq>;
	Wed, 1 Nov 2000 07:53:46 -0500
Date: Wed, 1 Nov 2000 12:54:01 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: f5ibh <f5ibh@db0bm.ampr.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: tnt uses obsolete (PF_INET,SOCK_PACKET)
In-Reply-To: <200011011117.MAA28584@db0bm.ampr.org>
Message-ID: <Pine.LNX.4.21.0011011251560.3991-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, f5ibh wrote:

> Hi,
> 
> Nov  1 12:09:12 debian-f5ibh kernel: tnt uses obsolete (PF_INET,SOCK_PACKET)
> 
> I got often this message, it is harmless (seems to be). What does it means ?

it means it uses old support for PACKET sockets in PF_INET protocol
family, i.e. a call like socket(PF_INET,SOCK_PACKET,0) instead of the
special protocol family for this purpose called PF_PACKET. If you truss
tcpdump you will see something like this:

socket(PF_PACKET, SOCK_DGRAM, 0)        = 3

which answers why you no longer get messages like "tcpdump uses
obsolete..." i.e. new tcpdump (as of a few years ago) does the right thing
(while your tnt, whatever that might be, doesn't).

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
