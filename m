Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319699AbSIMP4N>; Fri, 13 Sep 2002 11:56:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319704AbSIMP4N>; Fri, 13 Sep 2002 11:56:13 -0400
Received: from hermes.domdv.de ([193.102.202.1]:42761 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S319699AbSIMP4L>;
	Fri, 13 Sep 2002 11:56:11 -0400
Message-ID: <3D820BC9.5080207@domdv.de>
Date: Fri, 13 Sep 2002 18:01:13 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thunder from the hill <thunder@lightweight.ods.org>
CC: Bob_Tracy <rct@gherkin.frus.com>, dag@brattli.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
References: <Pine.LNX.4.44.0209121414570.10048-100000@hawkeye.luckynet.adm>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thunder from the hill wrote:
> Hi,
> 
> On Thu, 12 Sep 2002, Bob_Tracy wrote:
> 
>>define DERROR(dbg, args...) \
>>	{if(DEBUG_##dbg){\
>>		printk(KERN_INFO "irnet: %s(): ", __FUNCTION__);\
>>		printk(KERN_INFO args);}}
>>
>>which strikes me as not quite what the author intended, although it
>>should work.
> 
> 
> Why not
> 
> #define DERROR(dbg, fmt, args...) \
> 	do { if (DEBUG_##dbg) \
> 		printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION, args); \
> 	} while(0)
> 
> ?
> 
> 			Thunder

At least for gcc 3.2 this would be better:

#define DERROR(dbg, fmt, args...) \
     do { if (DEBUG_##dbg) \
         printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, ##args); \
     } while(0)

Unfortunately this doesn't work with gcc 2.95.3.

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

