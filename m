Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261987AbULKSwV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261987AbULKSwV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 13:52:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261991AbULKSwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 13:52:21 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11402 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261987AbULKSwR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 13:52:17 -0500
Message-ID: <41BB41DC.6020808@pobox.com>
Date: Sat, 11 Dec 2004 13:52:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alan J. Wylie" <alan@wylie.me.uk>
CC: linux-kernel@vger.kernel.org, EC <wingman@waika9.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: 2.4.29-pre1 OOPS early in boot with Intel ICH5 SATA controller
References: <16824.8109.697757.673632@devnull.wylie.me.uk>
In-Reply-To: <16824.8109.697757.673632@devnull.wylie.me.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan J. Wylie wrote:
> Code;  c01ccd07 <ata_host_add+57/80>
> 00000000 <_EIP>:
> Code;  c01ccd07 <ata_host_add+57/80>   <=====
>    0:   ff 50 50                  call   *0x50(%eax)   <=====
> Code;  c01ccd0a <ata_host_add+5a/80>
>    3:   89 da                     mov    %ebx,%edx
> Code;  c01ccd0c <ata_host_add+5c/80>
>    5:   85 c0                     test   %eax,%eax
> Code;  c01ccd0e <ata_host_add+5e/80>
>    7:   75 12                     jne    1b <_EIP+0x1b>
> Code;  c01ccd10 <ata_host_add+60/80>
>    9:   8b 5c 24 14               mov    0x14(%esp),%ebx
> Code;  c01ccd14 <ata_host_add+64/80>
>    d:   89 d0                     mov    %edx,%eax
> Code;  c01ccd16 <ata_host_add+66/80>
>    f:   8b 74 24 18               mov    0x18(%esp),%esi
> Code;  c01ccd1a <ata_host_add+6a/80>
>   13:   8b 00                     mov    (%eax),%eax

If you are getting an oops there, it looks like your ata_piix driver is 
mismatched from the libata core.  Did you compile them both at the same 
time, from the same source kernel?

The assembly code above is where function ata_host_add in libata-core.c 
calls "ap->ops->port_start", which definitely exists in ata_piix.c.

	Jeff


