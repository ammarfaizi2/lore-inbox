Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264825AbUEPVr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264825AbUEPVr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 17:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbUEPVr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 17:47:28 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61415 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264825AbUEPVr0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 17:47:26 -0400
Message-ID: <40A7E161.5060207@pobox.com>
Date: Sun, 16 May 2004 17:47:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric BENARD / Free <ebenard@free.fr>
CC: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       webvenza@libero.it, dominik.karall@gmx.net
Subject: Re: 2.6.6 : bad PCI device ID for SiS ISA bridge => SiS900 eth0:
 Can not find ISA bridge
References: <200405162004.57041.ebenard@free.fr>
In-Reply-To: <200405162004.57041.ebenard@free.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric BENARD / Free wrote:
> 1- bad PCI device ID for SiS ISA bridge
> 
> 2- In 2.6.3-rc2 (and 2.4.x), the PCI device ID of the ISA bridge of the 
> SiS630e is 0x0008. This ID is used by sis900.c in order to get the MAC 
> adress. 
> In 2.6.6, the PCI device ID of the ISA bridge of the SiS630E is 0x0018. The 
> SiS900 driver fail to read MAC adress and exit with the following message : 
> eth0: Can not find ISA bridge
[...]
> 8- A quick fix to get sis900.c running (which doesn't explain why the PCI 
> Device ID changed from 2.6.3-rc2 to 2.6.6) :
> change line 263 from
> 	if ((isa_bridge = pci_find_device(0x1039, 0x0008, isa_bridge)) == NULL
> to
> 	if ((isa_bridge = pci_find_device(0x1039, 0x0018, isa_bridge)) == NULL


I'm not sure I understand your message.

Are you suggesting
a) the hardware PCI id changed from 0x0008 to 0x0018 when booting 2.6.6.
	or
b) sis900.c changed when booting 2.6.6.

If "a", the PCI id in sis900.c seems to be 0x0008 in both 2.4 and 2.6. 
And further, I did not see any changes to this line of code in while 
searching 2.6.2 -> 2.6.6 patches on ftp.kernel.org.  I would lean 
towards a solution that modified sis900.c to check for -both- 0x08 and 0x18.

If "b", I bet that is a problem related to ACPI or some other 
non-sis900.c piece of code :)  sis900.c has not changed very much in the 
past several kernel releases.

	Jeff



