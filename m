Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161085AbWASLKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161085AbWASLKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 06:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbWASLKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 06:10:05 -0500
Received: from anchor-post-32.mail.demon.net ([194.217.242.90]:12037 "EHLO
	anchor-post-32.mail.demon.net") by vger.kernel.org with ESMTP
	id S1161085AbWASLKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 06:10:04 -0500
Message-ID: <43CF7385.9020201@superbug.demon.co.uk>
Date: Thu, 19 Jan 2006 11:09:57 +0000
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Ram Gupta <ram.gupta5@gmail.com>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: X killed
References: <43CA883B.2020504@superbug.demon.co.uk> <20060115192711.GO7142@w.ods.org> <43CCE5C8.7030605@superbug.demon.co.uk> <Pine.LNX.4.61.0601172111070.11929@yvahk01.tjqt.qr> <43CD599B.8050002@superbug.demon.co.uk> <728201270601171332v6c95df17u167d15212dde66c4@mail.gmail.com> <20060117214149.GA30467@w.ods.org>
In-Reply-To: <20060117214149.GA30467@w.ods.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Tue, Jan 17, 2006 at 03:32:11PM -0600, Ram Gupta wrote:
> 
>>On 1/17/06, James Courtier-Dutton <James@superbug.demon.co.uk> wrote:
>>
>>>Jan Engelhardt wrote:
>>>
>>>>>My point is that there is no way to tell what kills me. No messages in
>>>>>syslog...nothing. Surely the OOM killer would send a message to ksyslog, or at
>>>>>least dmesg?
>>
>>You may try using strace . It may throw some light on the cause of the problem.
> 
> 
> I would particularly suggest using 'strace -tt' both on X and on the
> python process. It will make it easier to analyse the causes later. You
> might even encounter a bug in the python application causing an explicit
> kill of a miscalculated pid (although unlikely, but who knows ?).
> 
> 
>>Regards
>>Ram gupta
> 
> 
> Regards,
> Willy
> 

I have managed to narrow down the problem. strace did not help at all.
The problem was the Load "freetype" line in xorg.conf.
With it commented out, python wsjt.py runs fine.
That would explain why strace did not help at all.
So, this is not a kernel problem now, it is an Xorg problem.

Section "Module"
#       Load  "glx"
        Load  "record"
        Load  "extmod"
        Load  "dbe"
        Load  "dri"
        Load  "xtrap"
#       Load  "freetype"   ### freetype crashes X in wsjt.py
        Load  "type1"
        Load  "speedo"
EndSection

I will have to ask the Xorg people how to run gdb on the freetype module.

James
