Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965055AbWEKCQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965055AbWEKCQP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 22:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWEKCQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 22:16:15 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:51392 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751525AbWEKCQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 22:16:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=h++qH6JIiNt9xvhkDeaJx3rgWhpRMpo3dQkf7CJlaDvwXejPgLaLFnnCD9j4krWZ9c9sM4U3bf9k90V6oLWkrcYKpDZukR0Ln3zfvyZ/dScZkU8A4Kkg62vjbm//n3bnKhfMPeDBrPC7+8gG2so1ux/IWK+HphWQc1bGjILkivU=
Message-ID: <44629E68.3020302@gmail.com>
Date: Thu, 11 May 2006 11:16:08 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: ata_piix failure on ich6m
References: <20060510235650.GA20206@srcf.ucam.org>
In-Reply-To: <20060510235650.GA20206@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> Hi,
> 
> We've got an ich6m system (a Toshiba Portege S100). ata_piix attempts to 
> drive the chipset, but fails - however, it doesn't bail out. As a result 
> it remains bound to the device and ahci isn't loaded.
> 
> I've attached the lspci output for the chipset. A few things to note 
> are:
> 
> 1) The AHCI BAR is set
> 2) The SCC register identifies it as an AHCI controller
> 3) Bits 2 and 0 of the PCS are set, which the spec claims indicates that 
> the port is to be controlled as an ahci device.
> 
> So, my question is effectively: why does ata_piix attempt to disable 
> ahci rather than simply letting the ahci driver bind? Points (1) and (2) 
> seem to be checked by the code, but I'm guessing that in the case of (3) 
> it should just return ENODEV and let ahci be run instead. If so, should 
> I code up a patch?
> 

I'm not very sure but it might be historical.  ahci got implemented 
after ata_piix and in the meantime ata_piix must have handled all it 
could.  Can you verify whether modifying the code to return -ENODEV work 
for your machine?  If so, that could be the correct solution but I'm a 
bit worried because it could change probing order or fail to enable 
devices it used to.  Maybe we need a hack to return -ENODEV iff ahci is 
there to handle the device.

-- 
tejun
