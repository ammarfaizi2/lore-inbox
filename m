Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261509AbVASAor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261509AbVASAor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 19:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbVASAor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 19:44:47 -0500
Received: from tron.kn.vutbr.cz ([147.229.191.152]:56068 "EHLO
	tron.kn.vutbr.cz") by vger.kernel.org with ESMTP id S261509AbVASAoi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 19:44:38 -0500
Message-ID: <41EDAD71.80203@stud.feec.vutbr.cz>
Date: Wed, 19 Jan 2005 01:44:33 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Osterlund <petero2@telia.com>
CC: Jens Axboe <axboe@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix verify_command to allow burning more than 1 DVD
References: <41EC214D.6060607@stud.feec.vutbr.cz> <m3k6qafjea.fsf@telia.com>
In-Reply-To: <m3k6qafjea.fsf@telia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Report: Spam detection software, running on the system "tron.kn.vutbr.cz", has
  identified this incoming email as possible spam.  The original message
  has been attached to this so you can view it (if it isn't spam) or block
  similar future email.  If you have any questions, see
  the administrator of that system for details.
  ____
  Content analysis details:   (-3.9 points, 6.0 required)
  ____
   pts rule name              description
  ---- ---------------------- --------------------------------------------
   0.7 FROM_ENDS_IN_NUMS      From: ends in numbers
  -4.9 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
                              [score: 0.0000]
   0.3 MAILTO_TO_SPAM_ADDR    URI: Includes a link to a likely spammer email
  ____
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund wrote:
> Michal Schmidt <xschmi00@stud.feec.vutbr.cz> writes:
>>--- linux-2.6.11-mm1/drivers/block/scsi_ioctl.c.orig	2005-01-17 20:42:40.000000000 +0100
>>+++ linux-2.6.11-mm1/drivers/block/scsi_ioctl.c	2005-01-17 20:43:14.000000000 +0100
>>@@ -197,9 +197,7 @@ static int verify_command(struct file *f
>> 	if (type & CMD_WRITE_SAFE) {
>> 		if (file->f_mode & FMODE_WRITE)
>> 			return 0;
>>-	}
>>-
>>-	if (!(type & CMD_WARNED)) {
>>+	} else if (!(type & CMD_WARNED)) {
>> 		cmd_type[cmd[0]] = CMD_WARNED;
>> 		printk(KERN_WARNING "scsi: unknown opcode 0x%02x\n", cmd[0]);
>> 	}
> 
> 
> That patch will not write the warning message in some cases. 

Yes. In cases when the device is opened for reading and the command is 
known as safe_for_write.
Do we really want to print this warning in that case?

> I think this patch is better:
> 
> ---
> 
>  linux-petero/drivers/block/scsi_ioctl.c |    2 +-
>  1 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff -puN drivers/block/scsi_ioctl.c~scsi-filter drivers/block/scsi_ioctl.c
> --- linux/drivers/block/scsi_ioctl.c~scsi-filter	2005-01-18 23:38:37.966026728 +0100
> +++ linux-petero/drivers/block/scsi_ioctl.c	2005-01-18 23:38:37.970026120 +0100
> @@ -200,7 +200,7 @@ static int verify_command(struct file *f
>  	}
>  
>  	if (!(type & CMD_WARNED)) {
> -		cmd_type[cmd[0]] = CMD_WARNED;
> +		cmd_type[cmd[0]] |= CMD_WARNED;
>  		printk(KERN_WARNING "scsi: unknown opcode 0x%02x\n", cmd[0]);
>  	}
>  
> _
> 
