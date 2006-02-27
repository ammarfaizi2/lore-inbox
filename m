Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751706AbWB0JNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbWB0JNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 04:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWB0JNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 04:13:21 -0500
Received: from mta9.srv.hcvlny.cv.net ([167.206.4.204]:54512 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751706AbWB0JNU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 04:13:20 -0500
Date: Mon, 27 Feb 2006 04:13:19 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
Subject: Re: [Patch 5/7]  synchronous block I/O delays
In-reply-to: <1141028957.2992.61.camel@laptopd505.fenrus.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Message-id: <4402C2AF.2030008@watson.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
References: <1141026996.5785.38.camel@elinux04.optonline.net>
 <1141028448.5785.64.camel@elinux04.optonline.net>
 <1141028957.2992.61.camel@laptopd505.fenrus.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>>+static inline void delayacct_blkio(void)
>>+{
>>+	if (unlikely(current->delays && delayacct_on))
>>+		__delayacct_blkio();
>>+}
>>    
>>
>
>why is this unlikely?
>  
>
delayacct_on is expected to be off most of the time, hence the compound is
unlikely too.

>  
>
>>+	u64 blkio_delay;	/* wait for sync block io completion */
>>    
>>
>
>this misses O_SYNC, msync(), and general throttling.
>
Hmm, that it does :-(

>I get the feeling this is being measured at the wrong level
>currently.... since the number of entry points that needs measuring at
>the current level is hardly finite...
>  
>
Will take another look if it can be done elsewhere. Earlier was using 
io_schedule but that isn't
called from everywhere.

--Shailabh
