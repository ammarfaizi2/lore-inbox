Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261731AbUKUCBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261731AbUKUCBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 21:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUKUCBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 21:01:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:43652 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261728AbUKUBzk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 20:55:40 -0500
Message-ID: <419FF598.9080606@us.ibm.com>
Date: Sat, 20 Nov 2004 19:55:36 -0600
From: Brian King <brking@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] pci: Block config access during BIST
References: <200411192023.iAJKNNSt004374@d03av02.boulder.ibm.com>	 <1100917635.9398.12.camel@localhost.localdomain>	 <1100934567.3669.12.camel@gaston>	 <1100954543.11822.8.camel@localhost.localdomain>	 <419FD58A.3010309@us.ibm.com> <1100995616.27157.44.camel@gaston>
In-Reply-To: <1100995616.27157.44.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
>>It still doesn't address Greg's issue about making this apply to the
>>pci_bus_* functions as well, but I'm not sure of a good way to do that
>>due to the reasons given earlier.
> 
> 
> Looks good to me, I don't sure we actually have to deal with pci_bus_*
> functions, do we ? When are they called ?

For what we are trying to solve, which is blocking userspace config
accesses, I don't think we do. Greg - are you ok with this?

>>+void pci_block_config_access(struct pci_dev *dev)
>>+{
>>+	unsigned long flags;
>>+
>>+	spin_lock_irqsave(&pci_lock, flags);
>>+	dev->block_cfg_access = 1;
>>+	spin_unlock_irqrestore(&pci_lock, flags);
>>+}
> 
> 
> Shouldn't we save the config space here ?

I thought about that when coding this up and thought it would
be better to simply have the function do what it advertises and no
more. Seems strange that a function called pci_block_config_access
would go and do a bunch of pci config accesses, but we can
certainly add it if you like.

-Brian

-- 
Brian King
eServer Storage I/O
IBM Linux Technology Center

