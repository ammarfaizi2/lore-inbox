Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUH1KGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUH1KGU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 06:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUH1KEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 06:04:38 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:12242 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S267433AbUH1Jyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 05:54:53 -0400
Message-ID: <4130566C.8020604@namesys.com>
Date: Sat, 28 Aug 2004 02:54:52 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Will Dyson <will_dyson@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
References: <20040824202521.GA26705@lst.de>	<412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <412E10A2.1020801@pobox.com> <412EEC07.30707@namesys.com> <412F7B6D.6010305@pobox.com>
In-Reply-To: <412F7B6D.6010305@pobox.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think there are two ways to analyze the code boundary issue.  One is 
"does it belong in the kernel?"  Another is, "does it belong in the 
filesystem. and if so should name resolution in a filesystem be split 
into two parts, one in kernel, and one in user space."  In ten years I 
might have the knowledge needed to make such a split, but I know for 
sure that I don't know how to do it today without regretting it 
tomorrow, and I don't really have confidence that I will ever be able to 
do it without losing performance.

Glad that BeFS finds the new model better.:)

Hans

Will Dyson wrote:

> Hans Reiser wrote:
>
>> Will Dyson wrote:
>>
>>>
>>> In the original BeOS, they solved the problem by having the 
>>> filesystem driver itself take a text query string and parse it, 
>>> returning a list of inodes that match. The whole business of parsing 
>>> a query string in the kernel (let alone in the filesystem driver) 
>>> has always seemed ugly to me. 
>>
>>
>> Why?
>
>
> Hmm. Trying to explain aesthetic judgments is always fun, but I'll try.
>
> String parsing bloats the kernel with code that will be called rarely, 
> and doing it inside the filesystem module makes for duplicate code if 
> more than one filesystem does it. But a good common parser routine (or 
> a kernel api that takes a pre-compiled parse tree) would reduce the 
> bad taste.
>
> The real objection I have is that it puts the kernel in the position 
> of doing more work than it has to for the system to operate correctly 
> and efficiently. The user wants to know what files match a certain set 
> of criteria. The filesystem provides special features which can 
> greatly accelerate some searches. Does it make more sense to move the 
> functionality of /usr/bin/find into the kernel, or to export the index 
> information so that an enhanced version of find can make use of it?
>
> I don't think having find in the kernel would be worth the cost or 
> complexity.
>
> However, now that I've had to think about it while writing the above, 
> it occurs to me that if we wanted to offer something like the beos's 
> live queries, doing it in the kernel might be the way to go.
>
> For the 99.9% of people who were not beos users back in the day, the 
> "live query" was a way to register a query string with the kernel, so 
> that you got notifications when the list of files matching the query 
> changed. It was pretty cool, but this is really just blue-skying since 
> I am not stepping up to write such a beast any time soon.
>
>>> However, the best alternative I've come up with is to simply export 
>>> the index data as a special file (perhaps in sysfs?) and have 
>>> userspace responsible for searching the index.
>>
>>
>> That is the best implementation suggestion I've heard for splitting 
>> the filesystem into two parts, one in user space and one in kernel, 
>> but I still don't trust it to work well.
>
>
> Why not? And if it really splits the filesystem into two parts depends 
> on which of the two following statements you agree with more:
>
> "Fast searching is a feature of the filesystem"
> "Maintaining indexes is a feature of the filesystem"
>
>
> PS.
> The file-as-directory attribute/stream/whatever model is a much better 
> fit for befs's internals than the xattr api. If the kernel supported 
> it, I would enable support for it in befs.
>

