Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966805AbWKOMpV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966805AbWKOMpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 07:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966813AbWKOMpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 07:45:21 -0500
Received: from nz-out-0102.google.com ([64.233.162.194]:54136 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S966809AbWKOMpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 07:45:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=KDqZmP8SJarUp/XiHHu0rr9aUrR1yIE+Tw4BCNwH0NbJ0YxdsE0Y28mL2H7kxST9+vs8M61nY73IFqJC7qiIzq85RHKFSU4BDJi1Rdj8eVYPq6iFtgxnNIPnMLMMGbVhJgjShl0YaqTmYSo2e2bXaFv4FWenL5sob35lUx2taE0=
Message-ID: <455B0BD7.20108@gmail.com>
Date: Wed, 15 Nov 2006 21:45:11 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.7 (X11/20061014)
MIME-Version: 1.0
To: "Berck E. Nash" <flyboy@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18 - AHCI detection pauses excessively
References: <4557B7D2.2050004@gmail.com>
In-Reply-To: <4557B7D2.2050004@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Berck E. Nash wrote:
> AHCI pauses heartily on during detection boot, but eventually proceeds. 
>  I've mentioned the problem before, but have since narrowed it down a 
> bit.  The problem does not occur in 2.6.17.3, but does occur in 2.6.18. 
>  The problem is still occurring both in 2.6.19-rc5 as well as 
> 2.6.19-rc5-mm1.
> 
> Please cc me on replies since I am not subscribed to LKML.
> 
> Messages surrounding the hang:
> 
> scsi2 : ahci
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: qc timeout (cmd 0xec)
> ata2.00: failed to IDENTIFY (I/O error, err_mask=0x104)
> ata2: port is slow to respond, please be patient (Status 0x80)
> ata2: port failed to respond (30 secs, Status 0x80)
> ata2: COMRESET failed (device not ready)
> ata2: hardreset failed, retrying in 5 secs
> ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata2.00: ATA-6, max UDMA/133, 640 sectors: LBA
> ata2.00: ata2: dev 0 multi count 1
> ata2.00: configured for UDMA/133
> 
> I should note that on this system ata1 and ata3 both detect quickly, but 
> they have 1.5 Gbps devices whereas ata2 has a 3.0Gbps device.

Hmmm.. Can you try with the attached patch applied?  Also, please turn 
on kernel config 'Kernel Hacking -> Show timing info on printks' and 
report boot dmesg.

Thanks.

-- 
tejun
