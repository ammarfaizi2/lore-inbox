Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755096AbWKQNx5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755096AbWKQNx5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 08:53:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755098AbWKQNx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 08:53:56 -0500
Received: from thing.hostingexpert.com ([67.15.235.34]:36768 "EHLO
	thing.hostingexpert.com") by vger.kernel.org with ESMTP
	id S1755095AbWKQNx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 08:53:56 -0500
Message-ID: <455DBED5.5030204@linuxtv.org>
Date: Fri, 17 Nov 2006 08:53:25 -0500
From: Michael Krufky <mkrufky@linuxtv.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Subject: Re: [v4l-dvb-maintainer] -mm: cx88-blackbird.c: unused code re-added
References: <20061114014125.dd315fff.akpm@osdl.org> <20061117124238.GV31879@stusta.de>
In-Reply-To: <20061117124238.GV31879@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - thing.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - linuxtv.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>On Tue, Nov 14, 2006 at 01:41:25AM -0800, Andrew Morton wrote:
>  
>
>>...
>>Changes since 2.6.19-rc5-mm2:
>>...
>> git-dvb.patch
>>...
>> git trees
>>...
>>    
>>
>
>Why does this patch re-add the still unused cx88_ioctl_hook and 
>cx88_ioctl_translator in drivers/media/video/cx88/cx88-blackbird.c 
>I removed a few months ago?
>

Adrian,

I have added those hooks back into the driver, because they are needed 
for the cx88-ivtv ioctl emulation layer.  However, I have instructed 
Mauro not to merge that patch upstream -- it is meant to stay at our 
mercurial repository only, since the vanilla kernel does not need to use 
the cx88-ivtv ioctl emulation layer.

It looks like somehow these got into -mm ... I think that is because 
Andrew's scripts pull from Mauro's devel branch in his git tree.

The problem commit is:  de513acdbafc48c52017255fee02af727dcfcc32

It appears that Mauro has folded my patch into Steve's patch, which he 
should not have done.  :-(  What a mess!

I will send a new patch to Mauro later on today to be applied to his git 
devel branch, which will remove those hooks again.

As soon as ivtv gets merged into our tree, that's when we will be able 
to remove cx88-ivtv alltogether, as there will no longer be any need to 
support the ivtv API.

regards,

Mike Krufky

