Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSCGBVo>; Wed, 6 Mar 2002 20:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289306AbSCGBVe>; Wed, 6 Mar 2002 20:21:34 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:1245 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289298AbSCGBVV>;
	Wed, 6 Mar 2002 20:21:21 -0500
Message-ID: <3C86BEB0.4090203@us.ibm.com>
Date: Wed, 06 Mar 2002 17:13:20 -0800
From: mingming cao <cmm@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jean-Eric Cuendet <jean-eric.cuendet@linkvest.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Rework of /proc/stat
In-Reply-To: <3C86553E.3070608@linkvest.com> <E16ik6y-0008Qf-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I've made a new version of IO statistics in kstat that remove the
>>previous limitations of MAX_MAJOR. I've made tests on my machine only, so could someone test it, please?
>>Feedback welcome.
>>
> 
> Any reason for preferring this over the sard patches in -ac ?
> 

Basically, statistic data are moved from the global kstat structure to 
the request_queue structures, and it is allocated/freed when the request 
queue is initialized and freed.  This way it is

1)self-controlled;
2)avoid the lookup step before the accounting, so it should be faster;
3)statistics implementation is not affected by the major/minor numbers;
4)able to gathering statistics for all disks while keep the memory needs 
minimized.

