Return-Path: <linux-kernel-owner+w=401wt.eu-S932852AbXAABvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbXAABvb (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 20:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932859AbXAABvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 20:51:31 -0500
Received: from mail.tmr.com ([64.65.253.246]:36816 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932852AbXAABva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 20:51:30 -0500
Message-ID: <45986AE5.9040903@tmr.com>
Date: Sun, 31 Dec 2006 20:59:01 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Phillip Susi <psusi@cfl.rr.com>
CC: Manish Regmi <regmi.manish@gmail.com>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: Linux disk performance.
References: <652016d30612172007m58d7a828q378863121ebdc535@mail.gmail.com>	 <1166431020.3365.931.camel@laptopd505.fenrus.org> <652016d30612180439y6cd12089l115e4ef6ce2e59fe@mail.gmail.com> <4589B92F.2030006@tmr.com> <45929658.3030507@cfl.rr.com>
In-Reply-To: <45929658.3030507@cfl.rr.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phillip Susi wrote:
> Bill Davidsen wrote:
>> Quite honestly, the main place I have found O_DIRECT useful is in 
>> keeping programs doing large i/o quantities from blowing the buffers 
>> and making the other applications run like crap. If you application is 
>> running alone, unless you are very short of CPU or memory avoiding the 
>> copy to an o/s buffer will be down in the measurement noise.
>>
>> I had a news (usenet) server which normally did 120 art/sec (~480 
>> tps), which dropped to about 50 tps when doing large file copies even 
>> at low priority. By using O_DIRECT the impact essentially vanished, at 
>> the cost of the copy running about 10-15% slower. Changing various 
>> programs to use O_DIRECT only helped when really large blocks of data 
>> were involved, and only when i/o clould be done in a way to satisfy 
>> the alignment and size requirements of O_DIRECT.
>>
>> If you upgrade to a newer kernel you can try other i/o scheduler 
>> options, default cfq or even deadline might be helpful.
> 
> I would point out that if you are looking for optimal throughput and 
> reduced cpu overhead, and avoid blowing out the kernel fs cache, you 
> need to couple aio with O_DIRECT.  By itself O_DIRECT will lower 
> throughput because there will be brief pauses between each IO while the 
> application prepares the next buffer.  You can overcome this by posting 
> a few pending buffers concurrently with aio, allowing the kernel to 
> always have a buffer ready for the next io as soon as the previous one 
> completes.

A good point, but in this case there was no particular urgency, other 
than not to stop the application while doing background data moves. The 
best way to do it would have been to put it where it belonged in the 
first place :-(

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
