Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312148AbSCVLwB>; Fri, 22 Mar 2002 06:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312050AbSCVLvu>; Fri, 22 Mar 2002 06:51:50 -0500
Received: from [195.63.194.11] ([195.63.194.11]:48136 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312034AbSCVLvs>; Fri, 22 Mar 2002 06:51:48 -0500
Message-ID: <3C9B1A73.2070606@evision-ventures.com>
Date: Fri, 22 Mar 2002 12:50:11 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Langford <jcl@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.4.18 & ALI15X3 DMA hang on boot
In-Reply-To: <Pine.LNX.4.10.10203220309400.10409-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Hedrick wrote:
> Martin,
> 
> You go and play in 2.5, please.

I didn't look at the issue but anyway the following is still
obviously wrong. hwif->index should be hwif->channel

Anyway please note the following:

diff -urN linux-2.5.7/drivers/ide/alim15x3.c linux/drivers/ide/alim15x3.c
--- linux-2.5.7/drivers/ide/alim15x3.c	Thu Mar 21 23:54:16 2002
+++ linux/drivers/ide/alim15x3.c	Fri Mar 22 02:08:58 2002
@@ -247,8 +247,8 @@
  	int s_time, a_time, c_time;
  	byte s_clc, a_clc, r_clc;
  	unsigned long flags;
	int port = hwif->index ? 0x5c : 0x58;
	int portFIFO = hwif->channel ? 0x55 : 0x54;

The usage of hwif->index *is* wrong.


