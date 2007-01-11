Return-Path: <linux-kernel-owner+w=401wt.eu-S965357AbXAKJh1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965357AbXAKJh1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 04:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965353AbXAKJh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 04:37:27 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:35697 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965351AbXAKJh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 04:37:26 -0500
Date: Thu, 11 Jan 2007 09:37:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: jeff@garzik.org, shemminger@osdl.org, csnook@redhat.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       atl1-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/4] atl1: Ancillary C files for Attansic L1 driver
Message-ID: <20070111093720.GD3141@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
	shemminger@osdl.org, csnook@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, atl1-devel@lists.sourceforge.net
References: <20070111004316.GE2624@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111004316.GE2624@osprey.hogchain.net>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define ATL1_STATS_LEN sizeof(atl1_gstrings_stats) / sizeof(struct atl1_stats)

Just use an opencoded ARRAY_SIZE().

> +void atl1_read_pci_cfg(struct atl1_hw *hw, u32 reg, u16 * value)
> +{
> +        struct atl1_adapter *adapter = hw->back;
> +        pci_read_config_word(adapter->pdev, reg, value);
> +}
> +
> +void atl1_write_pci_cfg(struct atl1_hw *hw, u32 reg, u16 * value)
> +{
> +        struct atl1_adapter *adapter = hw->back;
> +        pci_write_config_word(adapter->pdev, reg, *value);
> +}

Please just kill these types of wrappers and use pci_read_config_word/
pci_write_config_word directly.

> +static inline bool atl1_eth_address_valid(u8 * p_addr)
> +{
> +	/* Invalid PermanentAddress ? */
> +	if (((p_addr[0] == 0) &&
> +	     (p_addr[1] == 0) &&
> +	     (p_addr[2] == 0) &&
> +	     (p_addr[3] == 0) && (p_addr[4] == 0) && (p_addr[5] == 0)
> +	    ) || (p_addr[0] & 1)) 
> +		/* Multicast address or Broadcast Address */
> +		return false;
> +
> +	return true;
> +}

Don't we have a generic helper for this kind of thing?

