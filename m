Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbSLEQWo>; Thu, 5 Dec 2002 11:22:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261855AbSLEQWo>; Thu, 5 Dec 2002 11:22:44 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261686AbSLEQWn>;
	Thu, 5 Dec 2002 11:22:43 -0500
Message-ID: <3DEF7EF9.8090306@pobox.com>
Date: Thu, 05 Dec 2002 11:29:45 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] generic device DMA implementation
References: <20021205004744.GB2741@zax.zax> <200212050144.gB51iH105366@localhost.localdomain> <20021205023847.GA1500@zax.zax> <20021205034131.GA26616@gtf.org> <20021205060458.GF1500@zax.zax>
In-Reply-To: <20021205060458.GF1500@zax.zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> On Wed, Dec 04, 2002 at 10:41:31PM -0500, Jeff Garzik wrote:
> 
>>On Thu, Dec 05, 2002 at 01:38:47PM +1100, David Gibson wrote:
>>
>>>It seems the "try to get consistent memory, but otherwise give me
>>>inconsistent" is only useful on machines which:
>>>	(1) Are not fully consisent, BUT
>>>	(2) Can get consistent memory without disabling the cache, BUT
>>>	(3) Not very much of it, so you might run out.
>>>
>>>The point is, there has to be an advantage to using consistent memory
>>>if it is available AND the possibility of it not being available.
>>
>>Agreed here.  Add to this
>>
>>(4) quite silly from an API taste perspective.
>>
>>
>>
>>>Otherwise, drivers which absolutely need consistent memory, no matter
>>>the cost, should use consistent_alloc(), all other drivers just use
>>>kmalloc() (or whatever) then use the DMA flushing functions which
>>>compile to NOPs on platforms with consistent memory.
>>
>>Ug.  This is travelling backwards in time.
>>
>>kmalloc is not intended to allocate memory for DMA'ing.  I (and others)
>>didn't spend all that time converting drivers to the PCI DMA API just to
>>see all that work undone.
> 
> 
> But if there aren't any consistency constraints on the memory, why not
> get it with kmalloc().  There are two approaches to handling DMA on a
> not-fully-consistent machine:
> 	1) Allocate the memory specially so that it is consistent
> 	2) Use any old memory, and make sure we have explicit cache
> frobbing.

For me it's an API issue.  kmalloc does not return DMA'able memory.

If "your way" is acceptable to most, then at the very least I would want

	#define get_any_old_dmaable_memory kmalloc


