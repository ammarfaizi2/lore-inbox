Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267269AbUHOXpP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267269AbUHOXpP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267272AbUHOXpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:45:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40845 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267259AbUHOXo5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:44:57 -0400
Message-ID: <411FF568.8030202@pobox.com>
Date: Sun, 15 Aug 2004 19:44:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: new tool:  blktool
References: <411FD744.2090308@pobox.com> <411FF170.9070700@rtr.ca> <411FF2FA.4000602@rtr.ca>
In-Reply-To: <411FF2FA.4000602@rtr.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Supplementary or Alternatively, all of the ATA device commands issued by 
> hdparm
> can be supported in a driver by simply implementing the HDIO_DRIVE_CMD
> ioctl -- This is only a few lines of code in a typical SATA/SCSI driver,
> and I could easily supply a patch to implement it in libata.
> 
> Sure it's old, looks clunky, but it is simple code that works
> and is used by many more tools than just hdparm today.


True but I'm wrestling with one of its design flaws...  it doesn't 
provide the taskfile protocol.

I really really want to know before the command is submitted whether I 
am going to be receiving data, sending data, or neither.  The current 
IDE driver "guesses" by virtue of DRQ flag behavior, but such a guess is 
impossible on modern SATA controllers.

You either have to provide a lookup table (command opcode -> protocol), 
or specify it through the userland API.  HDIO_DRIVE_TASKFILE does this 
via 'data_phase'.

On a more general note, though, I certainly welcome libata patches from 
any and all sources.  Hack away!

	Jeff


