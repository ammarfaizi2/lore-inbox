Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266870AbUJVTL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266870AbUJVTL4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 15:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266048AbUJVTJS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 15:09:18 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:8317 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S266870AbUJVTFv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 15:05:51 -0400
Message-ID: <41795E69.9090909@cs.aau.dk>
Date: Fri, 22 Oct 2004 21:24:25 +0200
From: =?ISO-8859-15?Q?Kristian_S=F8rensen?= <ks@cs.aau.dk>
Organization: The Umbrella Team
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040814)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
Cc: andre@tomt.net, Kasper Sandberg <lkml@metanurb.dk>,
       LKML Mailinglist <linux-kernel@vger.kernel.org>, umbrella@cs.aau.dk
Subject: Re: Gigantic memory leak in linux-2.6.[789]!
References: <200410221613.35913.ks@cs.aau.dk> <1098455535.12574.1.camel@localhost> <Pine.LNX.4.61.0410221102300.12605@chaos.analogic.com> <41792C36.4070301@users.sourceforge.net> <Pine.LNX.4.61.0410221208230.17016@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0410221208230.17016@chaos.analogic.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> On Fri, 22 Oct 2004, [ISO-8859-15] Kristian Sørensen wrote:
>
>> Richard B. Johnson wrote:
>>
>>> On Fri, 22 Oct 2004, Kasper Sandberg wrote:
>>>
>>>> On Fri, 2004-10-22 at 16:13 +0200, Kristian Sørensen wrote:
>>>>
>>>>> Hi all!
>>>>>
>>>>> After some more testing after the previous post of the OOPS in
>>>>> generic_delete_inode, we have now found a gigantic memory leak in 
>>>>> Linux 2.6.
>>>>> [789]. The scenario is the same:
>>>>>
>>>>> File system: EXT3
>>>>> Unpack and delete linux-2.6.8.1.tar.bz2 with this Bash while loop:
>>>>>
>>>>> let "i = 0"
>>>>> while [ "$i" -lt 10 ]; do
>>>>>    tar jxf linux-2.6.8.1.tar.bz2;
>>>>>    rm -fr linux-2.6.8.1;
>>>>>    let "i = i + 1"
>>>>> done
>>>>>
>>>>> When the loop has completed, the system use 124 MB memory more 
>>>>> _each_ time....
>>>>> so it is pretty easy to make a denial-of-service attack :-(
>>>>
>>>
>>>
>>>
>>> Do something like this with your favorite kernel version.....
>>>
>>> while true ; do tar -xzf linux-2.6.9.tar.gz ; rm -rf linux-2.6.9 ; 
>>> vmstat ; done
>>>
>>> You can watch this for as long as you want. If there is no other
>>> activity, the values reported by vmstat remain, on the average, stable.
>>> If you throw in a `sync` command, the values rapidly converge to
>>> little memory usage as the disk-data gets flused to disk.
>>
>> The problem is, that the free memory reported by vmstat is decresing 
>> by 124mb for each 10-iterations....
>>
>> The allocated memory does not get freed even if the system has been 
>> left alone for three hours!
>>
>
> Yes. So?  Why would it be freed? It's left how it was until it
> is needed. Freeing it would waste CPU cycles.

Okay :-) So it looks like two of you says we have been mistaken :-D (and 
the behaviour has been changed since linux-2.4)

Anyway - How does this work in practice? Does the file system 
implementation use a wrapper for kfree or?
Is there any way to force instant free of kernel memory - when freed? 
Else it is quite hard testing for possible memory leaks in our Umbrella 
kernel module ... :-/


Best regards,

-- 
Kristian Sørensen
- The Umbrella Project
  http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816


