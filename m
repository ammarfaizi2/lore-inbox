Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932122AbWEWUVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbWEWUVW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWEWUVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:21:22 -0400
Received: from cyrus.iparadigms.com ([64.140.48.8]:17373 "EHLO
	cyrus.iparadigms.com") by vger.kernel.org with ESMTP
	id S932122AbWEWUVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:21:21 -0400
Message-ID: <44736EBE.3030704@iparadigms.com>
Date: Tue, 23 May 2006 13:21:18 -0700
From: fitzboy <fitzboy@iparadigms.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: linux-kernel@vger.kernel.org
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com> <44720DB8.4060200@argo.co.il> <447211E1.7080207@iparadigms.com> <447212B5.1010208@argo.co.il> <447259E7.8050706@iparadigms.com> <4472C25C.2090909@argo.co.il>
In-Reply-To: <4472C25C.2090909@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Avi Kivity wrote:
> 
> This will overflow. I think that
> 
>      currentPos = drand48() * s.st_size;
> 
> will give better results
> 
>>     currentPos=currentPos%s.st_size;
> 

why would it overflow? Random() returns a 32 bit number, and if I 
multiple that by 32k (basically the number random() returns is the block 
number I am going to), that should never be over 64 bits? It may be over 
to size of the file though, but that is why I do mod s.st_size... and a 
random number mod something is still a random number. Also, with this 
method it is already currentSize aligned...

> 
> Sorry, I wasn't specific enough: please run iostat -x /dev/whatever 1 
> and look at the 'r/s' (reads per second) field. If that agrees with what 
> your test says, you have a block layer or lower problem, otherwise it's 
> a filesystem problem.
> 

I ran it and found an r/s at 165, which basically corresponds to my 6 ms 
access time... when it should be around 3.5ms... so it seems like the 
seeks themselves are taking along time, NOT that I am doing extra seeks...
