Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262391AbUDDOMO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 10:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbUDDOMO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 10:12:14 -0400
Received: from postman2.arcor-online.net ([151.189.0.152]:3995 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S262391AbUDDOMK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 10:12:10 -0400
Message-ID: <407017B3.7000705@bndlg.de>
Date: Sun, 04 Apr 2004 14:12:03 +0000
From: Johannes Deisenhofer <joe@bndlg.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, de
MIME-Version: 1.0
To: Justin Cormack <justin@street-vision.com>
CC: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Undecoded Interrupt with SiL3112 IDE?
References: <406DA2DD.6040700@bndlg.de> <1080928106.30729.140.camel@lotte.street-vision.com>
In-Reply-To: <1080928106.30729.140.camel@lotte.street-vision.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Cormack wrote:
> siimage driver has buggy interrupt handling - have seen similar
> behaviour. It appears to be unmaintained. Recommend using libata
> instead.
> 

I tried libata from 2.6.5-rc3. Previous versions are considered broken by the 
author, especially for error handling.

However, I had far worse problems:

Apr  3 10:18:10 urmel kernel:  <3>ata1: DMA timeout, stat 0x0
Apr  3 10:18:10 urmel kernel: ATA: abnormal status 0x58 on port 0xF8854087
Apr  3 10:18:10 urmel kernel: scsi0: ERROR on channel 0, id 0, lun 0, CDB: 
Read (10) 00 00 07 65 3f 00 00 c8 00
Apr  3 10:18:10 urmel kernel: Current sda: sense key Medium Error
Apr  3 10:18:10 urmel kernel: Additional sense: Unrecovered read error - auto 
reallocate failed
Apr  3 10:18:10 urmel kernel: end_request: I/O error, dev sda, sector 484671
Apr  3 10:18:10 urmel kernel: ATA: abnormal status 0x58 on port 0xF8854087
Apr  3 10:18:10 urmel last message repeated 2 times
Apr  3 10:19:47 urmel PAM_pwdb[3086]: (login) session opened for user root by 
(uid=0)

This probably was a hardware problem. A new SATA cable seems to have fixed it. 
  Can't explain the 'medium error'.
SMART status of the drive is ok. No bad sectors according to SMART, none 
reallocated.

Jo

