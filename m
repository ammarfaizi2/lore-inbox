Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267316AbUHSTaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267316AbUHSTaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHSTaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:30:20 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:36309 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267306AbUHST15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:27:57 -0400
Message-ID: <4124FF3C.6080108@acm.org>
Date: Thu, 19 Aug 2004 14:27:56 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patch to 2.6.8.1-mm2 to allow multiple NMI handlers to be registered
References: <4124BACB.30100@acm.org> <20040819164049.GS8967@schnapps.adilger.int>
In-Reply-To: <20040819164049.GS8967@schnapps.adilger.int>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

>On Aug 19, 2004  09:35 -0500, Corey Minyard wrote:
>  
>
>>* Allow multiple handlers to be registered and return if they have 
>>handled the NMI or not.  oprofile and nmi_watchdog are modified to use this.
>>    
>>
>
>Why not use a notifier call chain as is done with panic & friends instead
>of implementing the same thing specifically for NMI?
>
>  
>
A couple of reasons:

* The "handled" value needs to be passed around so handler know if 
previous handlers have already handled the NMI.
* It allows the list of registered NMI handlers to be dumped in 
/proc/interrupts

I thought that the notifiers callout used locks (which would be a 
no-go), but it doesn't.  So I can scratch that one from my list.

Thanks,

-Corey
