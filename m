Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262532AbTCMSsc>; Thu, 13 Mar 2003 13:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262533AbTCMSsc>; Thu, 13 Mar 2003 13:48:32 -0500
Received: from impact.colo.mv.net ([199.125.75.20]:4245 "EHLO
	impact.colo.mv.net") by vger.kernel.org with ESMTP
	id <S262532AbTCMSsb>; Thu, 13 Mar 2003 13:48:31 -0500
Message-ID: <3E70D4F0.6060608@bogonomicon.net>
Date: Thu, 13 Mar 2003 12:58:56 -0600
From: Bryan Andersen <bryan@bogonomicon.net>
Organization: Bogonomicon
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Oleg Drokin <green@linuxhacker.ru>, alan@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       deanna_bonds@adaptec.com
Subject: Re: dpt_i2o.c memleak/incorrectness
References: <20030313182819.GA2213@linuxhacker.ru> <1047584663.25948.75.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>   There is something strange going on in drivers/scsi/dpt_i2o.c in both
>>   2.4 and 2.5. adpt_i2o_reset_hba() function allocates 4 bytes 
>>   for "status" stuff, then tries to reset controller, then 
>>   if timeout on first reset stage is reached, frees "status" and returns,
>>   otherwise it proceeds to monitor "status" (which is modified by hardware
>>   now, btw), and if timeout is reached, just exits.
> 
> Correctly - I2O does the same thing in this case. Its just better to
> throw a few bytes away than risk corruption

Better document it in the comments or it will get "corrected" by some 
mem leak detector.  If possible try to use a static for the pointer to 
the status block, but that may not work.  Re-enterant code and multi CPU 
situations likely won't allow for that.  Also it might not be worth the 
effort to properly determin if it is safe to use only one location.

- Bryan

