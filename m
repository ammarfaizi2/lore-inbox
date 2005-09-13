Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965036AbVIMTF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbVIMTF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 15:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVIMTF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 15:05:27 -0400
Received: from sabe.cs.wisc.edu ([128.105.6.20]:10941 "EHLO sabe.cs.wisc.edu")
	by vger.kernel.org with ESMTP id S965036AbVIMTFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 15:05:25 -0400
Message-ID: <432722E9.1090904@cs.wisc.edu>
Date: Tue, 13 Sep 2005 14:05:13 -0500
From: Mike Christie <michaelc@cs.wisc.edu>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Timothy Thelin <Timothy.Thelin@wdc.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.13] scsi: sd fails to copy cmd_len on SG_IO
References: <CA45571DE57E1C45BF3552118BA92C9D69BDDB@WDSCEXBECL03.sc.wdc.com>
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BDDB@WDSCEXBECL03.sc.wdc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Thelin wrote:
> 
>>-----Original Message-----
>>From: Mike Christie [mailto:michaelc@cs.wisc.edu]
>>Sent: Tuesday, September 13, 2005 10:49 AM
>>To: Timothy Thelin
>>Cc: James Bottomley; SCSI Mailing List; Linux Kernel; Andrew Morton
>>Subject: Re: [PATCH 2.6.13] scsi: sd fails to copy cmd_len on SG_IO
>>
>>
>>Timothy Thelin wrote:
>>
>>>This fixes an issue when doing SG_IO on an sd device: the
>>>sd driver fails to copy the request's cmd_len to the scsi
>>>command's cmd_len when initializing the command.
>>>
>>
>>Do you need the same fix to st, sr, and scsi_lib (in the 
>>scsi_generic_done path)?
>>
> 
> 
> I just looked, and st and sr look like they need the same fix, but i'm
> unaware of where scsi_lib might need it (I'm new to the Linux scsi stack).
> Mind elaborating on your thoughts of the scsi_generic_done path? (I cant
> find
> the symbol in drivers/scsi/*)
> 

look at the bottom of scsi_prep_fn() in scsi_lib.c. SCSI-ml will do 
block_pc commands (which come down like block layer SG_IO ones) for 
things like inquiry and report luns when scanning a host. At that time 
there is no upper layer driver like sd attached so scsi_generic_done() 
is used as a callback for finishing up commands.


