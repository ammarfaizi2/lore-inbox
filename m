Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932319AbWITTlO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbWITTlO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:41:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWITTlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:41:14 -0400
Received: from w3.zipcon.net ([209.221.136.4]:15840 "HELO w3.zipcon.net")
	by vger.kernel.org with SMTP id S932319AbWITTlN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:41:13 -0400
From: Bill Waddington <william.waddington@beezmo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Flushing writes to PCI devices
Date: Wed, 20 Sep 2006 12:41:05 -0700
Message-ID: <6263h29e4o17ok032m8rv11p4u6547ngk0@4ax.com>
References: <fa.gbsNbubc34pqWPOxWCntrwUyt68@ifi.uio.no> <Pine.LNX.4.44L0.0609201423480.7265-100000@iolanthe.rowland.org> <fa.V4O8HKrhUddxYm5+ixVbyZzPybE@ifi.uio.no>
In-Reply-To: <fa.V4O8HKrhUddxYm5+ixVbyZzPybE@ifi.uio.no>
X-Mailer: Forte Agent 3.3/32.846
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 19:10:55 UTC, in fa.linux.kernel you wrote:

>
>On Wed, 20 Sep 2006, Alan Stern wrote:
>
>> I've heard that to insure proper synchronization it's necessary to flush
>> MMIO writes (writel, writew, writeb) to PCI devices by reading from the
>> same area.  Is this equally true for I/O-space writes (inl, inw, inb)?
>> What about configuration space writes (pci_write_config_dword etc.)?
>>
>> Alan Stern
>
>Writes to I/O space are not queued through a FIFO so there is
>no need to flush the FIFO. Configuration space uses special
>configuration cycles which are handshakes with the devices. They
>cannot be queued, therefore don't need to be flushed either.
>
>Flushing PCI space writes shouldn't be done until you want
>whatever you've been planning to happen __now__. Otherwise
>the advantages of queued writes go away. In other words, one
>should NOT attach a read to every PCI space write! Typically
>use of the flushing read might be in the case of setting up
>hardware for a DMA transfer. You write all the data, source
>address, destination address, byte-count, DMA type, etc., then
>after the last instruction, the one should should start the DMA,
>you issue a read.

Are there ever any issues with out-of-order writes from the posting
buffer on supported architectures?  I can (barely) imagine a device
that has the register with the start bit lower in the register address
space than the count/address registers.  Out-of-order writes from
the cache/non-fifo/posting buffer (maybe to assemble a burst) could
make the occasional mess.

Just wondering,
Bill
-- 
William D Waddington
william.waddington@beezmo.com
"Even bugs...are unexpected signposts on
the long road of creativity..." - Ken Burtch

