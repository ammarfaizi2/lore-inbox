Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161026AbWJYWsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161026AbWJYWsJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161052AbWJYWsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:48:09 -0400
Received: from 66-117-159-244.lmi.net ([66.117.159.244]:31180 "EHLO slick.org")
	by vger.kernel.org with ESMTP id S1161026AbWJYWsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:48:08 -0400
Message-ID: <453FE9C4.1090504@imvu.com>
Date: Wed, 25 Oct 2006 15:48:36 -0700
From: "Brett G. Durrett" <brett@imvu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David N. Welton" <d.welton@webster.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: megaraid_sas waiting for command and then offline
References: <453F2454.1000707@webster.it>
In-Reply-To: <453F2454.1000707@webster.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David,

We switched to 2.6.18 (SMP) and applied the latest patches from LSI (got 
them directly from Sumant Patro).  Also, he told me to make sure "read 
ahead" was set to "off".  This seems to have reduced the frequency of 
the failures to about once per week (across 10+ machines), down from 
several times per week.

After I reported an additional failure, Sumant said they were able to 
reproduce the problems with XFS but they have not seen it with EXT3.  I 
prefer XFS but I prefer to have reliable databases even more...

I now have a couple of systems running in the new configuration and I am 
slowly migrating others to it as well.  I have not seen a failure with 
EXT3 but I statistically it would have been unlikely... I won't declare 
victory until I have more systems converted with a few weeks of reliable 
use.

Hope this helps... if anybody solves the root cause I will happily offer 
them a small gift to show my gratitude.

B-



David N. Welton wrote:

>Hi,
>
>I found someone corresponding to your name writing about a problem with
>the megaraid sas driver/hardware on the LKML:
>
>http://lkml.org/lkml/2006/9/6/12
>
>We have a Dell (2950, running 2.6.18 #1 SMP) as well, and the way I
>managed to kill the thing dead in its tracks (symptoms basically what
>you you describe) is with smartctl:
>
>root@salgari:~# smartctl --all /dev/sda
>smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
>Home page is http://smartmontools.sourceforge.net/
>
>Device: DELL     PERC 5/i         Version: 1.00
>Device type: disk
>Local Time is: Wed Oct 25 10:14:40 2006 CEST
>Device does not support SMART
>
>Error Counter logging not supported
>
>
>Device does not support Self Test logging
>
>----
>
>[61101.681857] sd 0:2:0:0: rejecting I/O to offline device
>[61101.681944] EXT3-fs error (device sda1): ext3_readdir: directory
>#7553069 contains a hole at offset 0
>[61103.944794] sd 0:2:0:0: rejecting I/O to offline device
>[61103.944879] EXT3-fs error (device sda1): ext3_readdir: directory
>#7553069 contains a hole at offset 0
>[61104.672212] sd 0:2:0:0: rejecting I/O to offline device
>[61104.672295] EXT3-fs error (device sda1): ext3_readdir: directory
>#7553069 contains a hole at offset 0
>[61105.255981] sd 0:2:0:0: rejecting I/O to offline device
>[61105.256066] EXT3-fs error (device sda1): ext3_readdir: directory
>#7553069 contains a hole at offset 0
>
>----
>
>Dead in the water.  We suspect that in any case there are some disk
>problems, which is why we were trying to use smartctl in the first place.
>
>I was just curious if you managed to figure anything out...
>
>Thanks,
>Dave Welton
>  
>
