Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSEBVXV>; Thu, 2 May 2002 17:23:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315432AbSEBVXU>; Thu, 2 May 2002 17:23:20 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:29084 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315431AbSEBVWb>; Thu, 2 May 2002 17:22:31 -0400
Date: Thu, 02 May 2002 15:20:39 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: William Lee Irwin III <wli@holomorphy.com>,
        Andrea Arcangeli <andrea@suse.de>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Bug: Discontigmem virt_to_page() [Alpha,ARM,Mips64?]
Message-ID: <148490000.1020378039@flay>
In-Reply-To: <20020502191903.GL32767@holomorphy.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 02, 2002 at 08:41:36PM +0200, Andrea Arcangeli wrote:
>> but can you plugin 32bit pci hardware into your 64bit-pci slots, right?
>> If not, and if you're also sure the linux drivers for your hardware are all
>> 64bit-pci capable then you can do the changes regardless of the 4G
>> limit, in such case you can spread the direct mapping all over the whole
>> 64G physical ram, whereever you want, no 4G constraint anymore.
> 
> I believe 64-bit PCI is pretty much taken to be a requirement; if it
> weren't the 4GB limit would once again apply and we'd be in much
> trouble, or we'd have to implement a different method of accommodating
> limited device addressing capabilities and would be in trouble again.

IIRC, there are some funny games you can play with 32bit PCI DMA.
You're not necessarily restricted to the bottom 4Gb of phys addr space, 
you're restricted to a 4Gb window, which you can shift by programming 
a register on the card. Fixing that register to point to a window for the 
node in question allows you to allocate from a node's pg_data_t and 
assure DMAable RAM is returned.

M.

