Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTEGRTn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 13:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTEGRTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 13:19:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:26071 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264061AbTEGRTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 13:19:42 -0400
Message-Id: <200305071732.h47HW7W32160@mail.osdl.org>
Date: Wed, 7 May 2003 10:32:03 -0700 (PDT)
From: markw@osdl.org
Subject: Re: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
To: gandalf@wlug.westbo.se
cc: akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <1052326742.24206.16.camel@tux.rsn.bth.se>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  7 May, Martin Josefsson wrote:
> On Wed, 2003-05-07 at 18:33, markw@osdl.org wrote:
>> I've collected some data from STP to see if it's useful or if there's
>> anything else that would be useful to collect. I've got some tests
>> queued up for the newer patches, but I wanted to put out what I had so
>> far.
>> 
>> 
>> METRICS OVER LAST 20 MINUTES:
>> --------------- -------- ----- ---- -------- -----------------------------------
>> Kernel          Elevator NOTPM CPU% Blocks/s URL                                
>> --------------- -------- ----- ---- -------- -----------------------------------
>> 2.5.68-mm2      as        1155 94.3   8940.2 http://khack.osdl.org/stp/271356/  
>> 2.5.68-mm2      deadline  1255 94.9   9598.7 http://khack.osdl.org/stp/271359/  
>> 
>> FUNCTIONS SORTED BY TICKS:
>> -- ------------------------- ------- ------------------------- -------
>>  # as 2.5.68-mm2             ticks   deadline 2.5.68-mm2       ticks  
>> -- ------------------------- ------- ------------------------- -------
>>  1 default_idle              6103428 default_idle              5359025
>>  2 bounce_copy_vec             86272 bounce_copy_vec             97696
>>  3 schedule                    63819 schedule                    70114
>>  4 __make_request              30397 __blk_queue_bounce          31167
>>  5 __blk_queue_bounce          26962 scsi_request_fn             26623
>>  6 scsi_request_fn             24845 __make_request              25012
> 
> You are using scsi, what tcq depth are you using? AS doesn't like >4 or
> something like that.

I'm told that it's set to 128 with this bit of code:

        if(dev->tagged_supported)
                scsi_adjust_queue_depth(dev, MSG_ORDERED_TAG, 128);
