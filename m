Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317950AbSIISEY>; Mon, 9 Sep 2002 14:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSIISEY>; Mon, 9 Sep 2002 14:04:24 -0400
Received: from packet.digeo.com ([12.110.80.53]:61640 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S317950AbSIISEX>;
	Mon, 9 Sep 2002 14:04:23 -0400
Message-ID: <3D7CE3A1.6A17D428@digeo.com>
Date: Mon, 09 Sep 2002 11:08:33 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: imran.badr@cavium.com
CC: root@chaos.analogic.com, "'David S. Miller'" <davem@redhat.com>,
       phillips@arcor.de, linux-kernel@vger.kernel.org
Subject: Re: Calculating kernel logical address ..
References: <Pine.LNX.3.95.1020909132344.17307A-100000@chaos.analogic.com> <019f01c25826$c553f310$9e10a8c0@IMRANPC>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Sep 2002 18:08:50.0267 (UTC) FILETIME=[F2F362B0:01C2582B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Imran Badr wrote:
> 
> The virt_to_bus() macro would work only for kernel logical addresses. I am
> trying to find a portable way to figure out the kernel logical address of a
> user buffer so that I could use virt_to_bus() for DMA. The user address is
> mmap'ed from kmalloc'ed buffer in the mmap() entry of my driver. Now when
> the user wants to send this data to the PCI device, it makes an ioctl call
> and give the user address to the driver. Now driver has to figure out the
> kernel logical address for DMA.
> 

You can obtain this info by walking the user's pagetables with
get_user_pages().  That give `struct page' pointers, with which
all things are possible.
