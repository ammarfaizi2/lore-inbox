Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbVBAPXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbVBAPXu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 10:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVBAPXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 10:23:50 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:5536 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262041AbVBAPXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 10:23:39 -0500
Message-ID: <41FF9EF8.2000101@us.ibm.com>
Date: Tue, 01 Feb 2005 09:23:36 -0600
From: Brian King <brking@us.ibm.com>
Reply-To: brking@us.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>
CC: Greg KH <greg@kroah.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-arch@vger.kernel.org
Subject: Re: pci: Arch hook to determine config space size
References: <200501281456.j0SEuI12020454@d01av01.pok.ibm.com> <20050128185234.GB21760@infradead.org> <20050129040647.GA6261@kroah.com> <41FE82B6.9060407@us.ibm.com> <41FE8994.4040802@us.ibm.com> <20050201074657.GA548@colo.lackof.org>
In-Reply-To: <20050201074657.GA548@colo.lackof.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> On Mon, Jan 31, 2005 at 01:40:04PM -0600, Brian King wrote:
> 
>>CC'ing the linux-pci mailing list...
> 
> 
> thanks...
> 
> 
>>>This patch adds an arch hook so
>>>that individual archs can indicate if the underlying system supports
>>>expanded config space accesses or not.
> 
> 
>>>@@ -653,6 +653,8 @@ static int pci_cfg_space_size(struct pci
>>>			goto fail;
>>>	}
>>>
>>>+	if (!pcibios_exp_cfg_space(dev))
>>>+		goto fail;
>>>	if (pci_read_config_dword(dev, 256, &status) != PCIBIOS_SUCCESSFUL)
>>>		goto fail;
> 
> 
> pci_read_config_dword lands in arch specific code.
> See drivers/pci/access.c:PCI_OP_READ() macro.
> 
> I'm missing what pcibios_exp_cfg_space() does that can't be handled by
> the bus_ops supplied by pci_scan_bus().
> 
> I would expect the pci_read_config_dword to fail for being out of bounds.
> Is that wrong?
> Or is bus_ops not feasible in this case because pcibios needs access
> to pci_dev?

The current patch for this has become essentially that. It is now a 
PPC64 specific patch that adds bounds checking in the PPC64 PCI config 
access functions.

-Brian


-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center
