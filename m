Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWCZRp6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWCZRp6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCZRp6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:45:58 -0500
Received: from web32404.mail.mud.yahoo.com ([68.142.207.197]:8119 "HELO
	web32404.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750754AbWCZRp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:45:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oGKlHGvPF7hfEjVTkK7tYF+cuanlbG4fZr4N+SP6qq1+rEjG3DRxaN1T1zDlWKIm/Yxh+hnD8EtEkPmUAAX66PIKDPgRZ6nJJhnT8qEEdL6QiSCBnpXHDrO6PVe1KsZaPwRAW5cYAUAME0CU2W+sbW7Om0dFtGiY6TWUCNTejZw=  ;
Message-ID: <20060326174556.45649.qmail@web32404.mail.mud.yahoo.com>
Date: Sun, 26 Mar 2006 09:45:56 -0800 (PST)
From: Anil kumar <anils_r@yahoo.com>
Subject: kernel BUG at arch/i386/mm/highmem.c:63! kunmap_atomic
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

I get the following kernel panic,

kernel BUG at arch/i386/mm/highmem.c:63!
EIP:    0060:[<c011af5a>]    Tainted: PF     VLI
EFLAGS: 00010006   (2.6.11-1.1369_FC4smp)
EIP is at kunmap_atomic+0x35/0x5f

The following is the code, I am using in my driver:

kmap_atomic code:

int hr_km_type = (in_interrupt())? KM_IRQ0: KM_USER0;
         pDataBuffer = kmap_atomic(cur_seg->page,
hr_km_type) + cur_seg->offset;
         if(pDataBuffer == NULL) {
            return (ENOMEM);
         }

kunmap_atomic code:

int hr_km_type = (in_interrupt())? KM_IRQ0: KM_USER0;
                  kunmap_atomic(pDataBuffer -
sg->offset, hr_km_type);

I am not using any locks like irq_disable/restore
before and after calling kmap_atomic/kunmap_atomic.

The system has 1GB memory.

with regards,
   Anil

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
