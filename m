Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVIBR4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVIBR4n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 13:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750733AbVIBR4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 13:56:43 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2722 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750728AbVIBR4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 13:56:42 -0400
Message-ID: <4318E6B3.7010901@us.ibm.com>
Date: Fri, 02 Sep 2005 18:56:35 -0500
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: greg@kroah.com, matthew@wil.cx, benh@kernel.crashing.org, ak@muc.de,
       paulus@samba.org, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 1/2] pci: Block config access during BIST (resend)
References: <41F7C6A1.9070102@us.ibm.com>	<1106777405.5235.78.camel@gaston>	<1106841228.14787.23.camel@localhost.localdomain>	<41FA4DC2.4010305@us.ibm.com>	<20050201072746.GA21236@kroah.com>	<41FF9C78.2040100@us.ibm.com>	<20050201154400.GC10088@parcelfarce.linux.theplanet.co.uk>	<41FFBDC9.2010206@us.ibm.com>	<20050201174758.GE10088@parcelfarce.linux.theplanet.co.uk>	<4200F2B2.3080306@us.ibm.com>	<20050208200816.GA25292@kroah.com>	<42B83B8D.9030901@us.ibm.com>	<430B3CB4.1050105@us.ibm.com> <20050901160356.2a584975.akpm@osdl.org>
In-Reply-To: <20050901160356.2a584975.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Brian King <brking@us.ibm.com> wrote:
> 
>>+void pci_block_user_cfg_access(struct pci_dev *dev)
>>+{
>>+	unsigned long flags;
>>+
>>+	pci_save_state(dev);
>>+	spin_lock_irqsave(&pci_lock, flags);
>>+	dev->block_ucfg_access = 1;
>>+	spin_unlock_irqrestore(&pci_lock, flags);
> 
> 
> Are you sure the locking in here is meaningful?  All it will really do is
> give you a couple of barriers.

Actually, it is meaningful. It synchronizes the blocking of pci config 
accesses with other pci config accesses that may be going on when this 
function is called. Without the locking, the API cannot guarantee that 
no further user initiated PCI config accesses will be initiated after 
this function is called.

Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
