Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269171AbRGaEkk>; Tue, 31 Jul 2001 00:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269172AbRGaEka>; Tue, 31 Jul 2001 00:40:30 -0400
Received: from fes-qout.whowhere.com ([209.185.123.96]:13143 "HELO
	mailcity.com") by vger.kernel.org with SMTP id <S269171AbRGaEkU>;
	Tue, 31 Jul 2001 00:40:20 -0400
To: linux-kernel@vger.kernel.org
Date: Tue, 31 Jul 2001 10:10:10 +0530
From: "vijay srinath" <vijaysrinath@lycos.com>
Message-ID: <MEAIEKBGIFKBAAAA@mailcity.com>
Mime-Version: 1.0
Cc: vikram_kmurthy@yahoo.com
X-Sent-Mail: off
Reply-To: vijaysrinath@lycos.com
X-Mailer: MailCity Service
Subject: SCSI Tape driver problem
X-Sender-Ip: 156.153.255.126
Organization: Lycos Mail  (http://mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

hello all,

    I noticed a bug in the scsi tape class driver in kernel 2.2.16/2.4.x.
This is the test that i ran. 
1. I have two scsi-fc tape devices
2. I insert the hba driver, so that both the tape devices are enabled and map to st0 and st1
3. I remove the device that maps to st0 using 
   echo "scsi remove-single-device 0 0 0 0" > /proc/scsi/scsi
4. Now, if i try to do an open("/dev/st1",..), the process hangs as the open call never returns.

    The problem seems to be in the callback function st_sleep_done() where the following comparison is being made
if ((st_nbr = TAPE_NR(SCpnt->request.rq_dev)) < st_template.nr_dev) 
{
 ...
}

This comparision fails for the above test since nr_dev will be 1 and 
TAPE_NR() will also be 1 for /dev/st1. Hence the semaphore 
SCpnt->request.sem never gets released and open waits forever.


    Can somebody please let me know why this comparison is needed ?

regards
vijay



Get 250 color business cards for FREE!
http://businesscards.lycos.com/vp/fastpath/
