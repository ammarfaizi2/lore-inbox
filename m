Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVFULW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVFULW7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 07:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVFULW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 07:22:59 -0400
Received: from mail2.turbolinux.co.jp ([203.174.69.140]:15808 "EHLO
	mail2.turbolinux.com") by vger.kernel.org with ESMTP
	id S261165AbVFUKlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 06:41:11 -0400
Message-ID: <42B7EE85.9050102@turbolinux.com>
Date: Tue, 21 Jun 2005 18:40:05 +0800
From: bobl <bobl@turbolinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050308
X-Accept-Language: en-us, en, zh-cn
MIME-Version: 1.0
To: Michael Buesch <mbuesch@freenet.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: a trival bug of megaraid in patch 2.6.12-mm1
References: <42B7E5F2.2060409@turbolinux.com> <200506211220.42136.mbuesch@freenet.de>
In-Reply-To: <200506211220.42136.mbuesch@freenet.de>
Content-Type: multipart/mixed;
 boundary="------------070803080307000207060709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070803080307000207060709
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Michael Buesch wrote:

>Quoting bobl <bobl@turbolinux.com>:
>  
>
>>    The attachment is the patch, please confirm it.
>>    
>>
>
>  
>
>>diff -purN linux-2.6.12/drivers/scsi/megaraid.c linux-2.6.12.new/drivers/scsi/megaraid.c
>>--- linux-2.6.12/drivers/scsi/megaraid.c        2005-06-21 18:49:50.118732304 +0900
>>+++ linux-2.6.12.new/drivers/scsi/megaraid.c    2005-06-21 18:57:55.266978560 +0900
>>@@ -1975,6 +1975,7 @@ __megaraid_reset(Scsi_Cmnd *cmd)
>> static int
>> megaraid_reset(Scsi_Cmnd *cmd)
>> {
>>+       adapter_t       *adapter;
>>        adapter = (adapter_t *)cmd->device->host->hostdata;
>>        int rc;
>>    
>>
>
>That's mixed code and declarations (aka Not Good (tm)).
>Please do something like this instead:
>
>-       adapter = (adapter_t *)cmd->device->host->hostdata;
>+       adapter_t *adapter = (adapter_t *)cmd->device->host->hostdata;
>        int rc;
>
>
>  
>

Thanks!

The attachment is the new one!

--------------070803080307000207060709
Content-Type: text/x-patch;
 name="linux-2.6.12-mm1-megaraid.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.12-mm1-megaraid.patch"

diff -purN linux-2.6.12.orig/drivers/scsi/megaraid.c linux-2.6.12.new/drivers/scsi/megaraid.c
--- linux-2.6.12.orig/drivers/scsi/megaraid.c	2005-06-21 19:37:38.846619376 +0900
+++ linux-2.6.12.new/drivers/scsi/megaraid.c	2005-06-21 19:38:03.241910728 +0900
@@ -1975,7 +1975,7 @@ __megaraid_reset(Scsi_Cmnd *cmd)
 static int
 megaraid_reset(Scsi_Cmnd *cmd)
 {
-	adapter = (adapter_t *)cmd->device->host->hostdata;
+	adapter_t *adapter = (adapter_t *)cmd->device->host->hostdata;
 	int rc;
 
 	spin_lock_irq(&adapter->lock);

--------------070803080307000207060709--
