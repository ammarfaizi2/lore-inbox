Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261516AbVBRUvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261516AbVBRUvo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 15:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVBRUvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 15:51:09 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:64128 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S261501AbVBRUum
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 15:50:42 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Date: Fri, 18 Feb 2005 12:50:22 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give
 dev=/dev/hdXas device
In-Reply-To: <cv5hv3$ana$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.60.0502181249110.5315@dlang.diginsite.com>
References: <cv36kk$54m$1@gatekeeper.tmr.com><cv36kk$54m$1@gatekeeper.tmr.com>
 <20050218103107.GA15052@wszip-kinigka.euro.med.ge.com> <cv5hv3$ana$1@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I regularly burn tarballs to a CD without useing a filesystem and as long 
as I use the -pad option when burning I've had no problems reading them 
(the -pad was nessasary even when I was useing ide-scsi)

David Lang

  On Fri, 18 Feb 
2005, Bill Davidsen wrote:

> Date: Fri, 18 Feb 2005 15:23:44 -0500
> From: Bill Davidsen <davidsen@tmr.com>
> To: linux-kernel@vger.kernel.org
> Newsgroups: mail.linux-kernel
> Subject: Re: ide-scsi is deprecated for cd burning! Use ide-cd and give
>     dev=/dev/hdXas device
> 
> Kiniger, Karl (GE Healthcare) wrote:
>> On Thu, Feb 17, 2005 at 05:58:05PM -0500, Bill Davidsen wrote:
>> 
>>> Valdis.Kletnieks@vt.edu wrote:
>>> 
>>>> On Wed, 16 Feb 2005 10:42:21 +0100, "Kiniger, Karl (GE Healthcare)" 
>>>> said:
>>>> 
>>>> 
>>>> 
>>>>>> Have you tested the ISO on some *OTHER* hardware?  The impression 
>>>>>> I got
>>>>>> was that the cd was *burned* right by ide-cd, but when *read 
>>>>>> back*, it
>>>>>> bollixed things up at the end of the CD.....
>>>>> 
>>>>> Using ide-scsi is enough to get all the data till the real end of 
>>>>> the CD.
>>>> 
>>>> 
>>>> OK, so the problem is that ide-cd is able to *burn* the CD just fine, 
>>>> but it
>>>> suffers lossage when ide-cd tries to read it back...
>>>> 
>>>> Alan - are the sense-byte patches for ide-cd in a shape to push either 
>>>> upstream
>>>> or to -mm?
>>> 
>>> The last time I looked at this, the issue was that the user software did 
>>> a large read and the ide-cd didn't properly return a small data block 
>>> with no error, but rather returned an error with no data. If you get the 
>>> size of the ISO image, you can read that with any program which doesn't 
>>> try to read MORE than that.
>> 
>> 
>> Not entirely true (at least for me). I actually tried to read the last 
>> iso9660 data sector with a small C program (reading 2 kb) and
>> it failed to read the sector. Using ide-scsi I was able to read it.....
>> 
>> sdd (from Joerg Schilling) should not try to read more than ivsize
>> bytes (InputVolumeSize) if that argument is given - I did not
>> verify with strace though.
>
> I'll try to build a truth table for this, I'm now working with some non-iso 
> data sets, so I'm a bit more interested. I would expect read() to only try to 
> read one sector, so I'll just do a quick and dirty to get the size from the 
> command line, seek and read.
>
> I haven't had a problem using dd to date, as long as I know how long the data 
> set was, but I'll try to have results tonight.
>
> Thanks for your additional info on this.
>
> -- 
>   -bill davidsen (davidsen@tmr.com)
> "The secret to procrastination is to put things off until the
> last possible moment - but no longer"  -me
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
