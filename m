Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289880AbSBKRij>; Mon, 11 Feb 2002 12:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289874AbSBKRi1>; Mon, 11 Feb 2002 12:38:27 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:34554 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S289865AbSBKRiR>; Mon, 11 Feb 2002 12:38:17 -0500
Message-ID: <3C680184.9090208@nyc.rr.com>
Date: Mon, 11 Feb 2002 12:38:12 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tom Gall <tom_gall@vnet.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.4, cs46xx snd, and virt_to_bus
In-Reply-To: <fa.fefkfjv.rmid9f@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Gall wrote:
> Hi All,
> 
>   Well forgive me for not being up on the lastest news but from building
> 2.5.4 kernel for my box, which uses the cs46xx.c sound driver, it would
> appear that virt_to_bus and bus_to_virt has gone the way of the do-do. 
> 
>   What's the correct method now? 
> 
>   Be nice to get this cleaned up....
> 
>   Regards,
> 
>   Tom

Use pci_alloc_consistent() to allocate the buffer.  This function
returns the right thing so that virt_to_bus() is no longer needed.

 From what I read, it looks like pci_alloc_consistent returns a pci 
address and a physical address (via dma_addr_t), so it should be simple 
to change the code to use this function.  However, I don't know where 
the hell I'm supposed to find pci_dev -- I'll try rereading the 
driver-model.txt code again :).

