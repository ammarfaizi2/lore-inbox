Return-Path: <linux-kernel-owner+w=401wt.eu-S1751410AbXAOTVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751410AbXAOTVW (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 14:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXAOTVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 14:21:22 -0500
Received: from imf25aec.mail.bellsouth.net ([205.152.59.73]:58348 "EHLO
	imf25aec.mail.bellsouth.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751363AbXAOTVU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 14:21:20 -0500
Message-ID: <45ABD42D.1060901@bellsouth.net>
Date: Mon, 15 Jan 2007 13:21:17 -0600
From: Jay Cliburn <jacliburn@bellsouth.net>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>,
       Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
       shemminger@osdl.org, csnook@redhat.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, atl1-devel@lists.sourceforge.net
Subject: Re: [PATCH 2/4] atl1: Header files for Attansic L1 driver
References: <20070111004137.GC2624@osprey.hogchain.net> <20070111092704.GB3141@infradead.org>
In-Reply-To: <20070111092704.GB3141@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Jan 10, 2007 at 06:41:37PM -0600, Jay Cliburn wrote:

>> +struct csum_param {
>> +	unsigned buf_len:14;
>> +	unsigned dma_int:1;
>> +	unsigned pkt_int:1;
>> +	u16 valan_tag;
>> +	unsigned eop:1;
>> +	/* command */
>> +	unsigned coalese:1;
>> +	unsigned ins_vlag:1;
>> +	unsigned custom_chksum:1;
>> +	unsigned segment:1;
>> +	unsigned ip_chksum:1;
>> +	unsigned tcp_chksum:1;
>> +	unsigned udp_chksum:1;
>> +	/* packet state */
>> +	unsigned vlan_tagged:1;
>> +	unsigned eth_type:1;
>> +	unsigned iphl:4;
>> +	unsigned:2;
>> +	unsigned payload_offset:8;
>> +	unsigned xsum_offset:8;
>> +} _ATL1_ATTRIB_PACK_;
> 
> Bitfields should not be used for hardware datastructures ever.
> Please convert this to explicit masking and shifting.


>> +/* formerly ATL1_WRITE_REG */
>> +static inline void atl1_write32(const struct atl1_hw *hw, int reg, u32 val)
>> +{
>> +        writel(val, hw->hw_addr + reg);
>> +}
>> +
>> +/* formerly ATL1_READ_REG */
>> +static inline u32 atl1_read32(const struct atl1_hw *hw, int reg)
>> +{
>> +        return readl(hw->hw_addr + reg);
>> +}
> 
> Just kill all these wrappers.  Also you probably want to convert to
> pci_iomap + ioread*/iowrite*.

Christoph et al.,

I've incorporated all your comments except the two shown above.  I 
killed the indicated atl1_write*/atl1_read* wrappers, but I'm not yet 
familiar enough with pci_iomap/iowrite*/ioread* to make that particular 
conversion, and I'm having trouble getting the bitfield struct converted 
to shift/mask semantics (No matter how hard I try, I keep breaking the 
transmit side of the adapter).

I'd like to plead for relief on these two items and submit a new version 
of the driver containing all your other comments.  I need help from a 
more experienced netdev hacker, and in my mind, the best way to do that 
is to get the driver in the kernel so more people can use it and 
contribute changes and make improvements.

I welcome any comments on the rationality of this approach.

Jay
