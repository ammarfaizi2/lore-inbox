Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUFYSpF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUFYSpF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 14:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUFYSpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 14:45:05 -0400
Received: from chnmfw01.eth.net ([202.9.145.21]:19471 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S263824AbUFYSo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 14:44:57 -0400
Message-ID: <40DC72AB.9020106@eth.net>
Date: Sat, 26 Jun 2004 00:14:59 +0530
From: Amit Gud <gud@eth.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: Pavel Machek <pavel@ucw.cz>, alan <alan@clueserver.org>,
       "Fao, Sean" <Sean.Fao@dynextechnologies.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Elastic Quota File System (EQFS)
References: <200406251707.i5PH7KOw009004@eeyore.valparaiso.cl>
In-Reply-To: <200406251707.i5PH7KOw009004@eeyore.valparaiso.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Jun 2004 18:37:15.0312 (UTC) FILETIME=[6FCEDB00:01C45AE3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

>Pavel Machek <pavel@ucw.cz> said:
>  
>
>>Hi!
>>
>>    
>>
>>>Case closed, anyway. It belongs in the kernel only if there is no
>>>reasonable way to do it in userspace.
>>>      
>>>
>>But... there's no reasonable way to do this in userspace.
>>    
>>
>
>Let's see...
>
>  
>
>>Two pieces of kernel support are needed:
>>
>>1) some way to indicate "this file is elastic" (okay perhaps xattrs
>>can do this already)
>>    
>>
>
>Or just a list of elastic files in ~/.elastic. Even better, could mark them
>as "Just delete", "compress"; could go as far as giving (fallback?) globs
>to select files for each treatment ("If space gets tight, delete *~ files,
>and compress *.tex that haven't been read in a week"). Sounds like a fun
>Perl project...
>
>  
>
.elastic is a file or directory? If its file, daemon has to do the ugly 
insertion deletion of the file enteries. If its a directory, daemon has 
to do the updating of the files in case of mv, plus follow the links for 
unlink, chown if we are storing the files as symlinks and we will be 
wasting the inodes.

Just think of the load on the system if we run a daemon, which sleeps 
for a time depending on the data transfer rate and the amount of free 
space left, and if the free space left is very close to the margin... 
the system might even freeze. The primary intention of taking 
filesystems into kernel is the speed and the security that we get, 
otherwise we do have userspace filesystems!

What we need is an application-transparent system which of course should 
be plugable within a system and which also shouldn't hamper the system 
throughput in a major way.

I really don't see user space implementation in the picture.

AG

