Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbWCaIgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbWCaIgc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 03:36:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWCaIgc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 03:36:32 -0500
Received: from 220-130-178-143.HINET-IP.hinet.net ([220.130.178.143]:63968
	"EHLO areca.com.tw") by vger.kernel.org with ESMTP id S1751270AbWCaIgb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 03:36:31 -0500
Message-ID: <002301c6549e$43677f20$b100a8c0@erich2003>
From: "erich" <erich@areca.com.tw>
To: "Jens Axboe" <axboe@suse.de>, "Chris Caputo" <ccaputo@alt.net>
Cc: <dax@gurulabs.com>, <axboe@suse.de>,
       =?UTF-8?B?Iijlu6Plronnp5HmioAp5a6J5Y+vTyI=?= 
	<billion.wu@areca.com.tw>,
       "\"Al Viro\"" <viro@ftp.linux.org.uk>,
       "\"Andrew Morton\"" <akpm@osdl.org>,
       "\"Randy.Dunlap\"" <rdunlap@xenotime.net>,
       "\"Matti Aarnio\"" <matti.aarnio@zmailer.org>,
       <linux-kernel@vger.kernel.org>,
       "\"James Bottomley\"" <James.Bottomley@steeleye.com>
References: <Pine.LNX.4.64.0603212310070.20655@nacho.alt.net> <007701c653d7$8b8ee670$b100a8c0@erich2003> <Pine.LNX.4.64.0603301542590.19680@nacho.alt.net> <004a01c65470$412daaa0$b100a8c0@erich2003> <20060330192057.4bd8c568.akpm@osdl.org> <20060331074237.GH14022@suse.de>
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken
Date: Fri, 31 Mar 2006 16:36:50 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3790.1830
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.1830
X-OriginalArrivalTime: 31 Mar 2006 08:31:39.0093 (UTC) FILETIME=[87C2D850:01C6549D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jens Axboe,

I have done this test as your request but it still there.
But more less.
I have modify  #define ARCMSR_MAX_XFER_SECTORS  4096 => 512.
It had worked all of this morning on bonnie++ , iometer and my copy/compare 
test script.
All machines in my lab.do not have this message again.

Best Regards
Erich Chen


----- Original Message ----- 
From: "Jens Axboe" <axboe@suse.de>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "James Bottomley" <James.Bottomley@steeleye.com>; <erich@areca.com.tw>
Sent: Friday, March 31, 2006 3:42 PM
Subject: Re: new Areca driver in 2.6.16-rc6-mm2 appears to be broken


>
> (irk, Erich wasn't in the cc, sorry to Andrew and James for getting this
> mail twice)
>
> On Thu, Mar 30 2006, Andrew Morton wrote:
>> "erich" <erich@areca.com.tw> wrote:
>> >
>> > Dear Chris Caputo,
>> >
>> >  Thanks you to conform this issue again, my colleague assisted me and 
>> > to
>> >  double check my older version driver yesterday.
>> >  and the old driver is working fine as your mention before.
>> >
>> >  The ARCMSR_MAX_XFER_SECTORS is the reason why cause "attempt to access
>> >  beyond end of device".
>> >
>> >  #define ARCMSR_MAX_XFER_SECTORS
>> >  256     -----old
>> >  #define ARCMSR_MAX_XFER_SECTORS
>> >  4096     -----new
>>
>> That seems odd.  ARCMSR_MAX_XFER_SECTORS just gets put into
>> scsi_host_template.max_sectors.  Could it be a scsi core buglet?
>
> Perhaps the larger max sectors setting is causing read-ahead to be
> overly optimistic and going beyond the end? Should not happen.
>
> Erich, can you try and shrink read-ahead on that device and retest?
> Basically just do
>
> # echo 0 > /sys/block/sdX/queue/read_ahead_kb
>
> and see if it still complains.
>
> -- 
> Jens Axboe
> 

