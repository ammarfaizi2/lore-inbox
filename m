Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUAANLl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 08:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbUAANLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 08:11:41 -0500
Received: from gamemakers.de ([217.160.141.117]:54410 "EHLO www.gamemakers.de")
	by vger.kernel.org with ESMTP id S264455AbUAANLe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 08:11:34 -0500
Message-ID: <3FF41C89.1010402@lambda-computing.de>
Date: Thu, 01 Jan 2004 14:11:37 +0100
From: =?ISO-8859-1?Q?R=FCdiger_Klaehn?= <rudi@lambda-computing.de>
Reply-To: rudi@lambda-computing.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Clark <michael@metaparadigm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File change notification
References: <3FF2FC85.5070906@lambda-computing.de> <3FF31366.30206@acm.org> <3FF31A15.4070307@lambda-computing.de> <3FF377A8.6040302@metaparadigm.com>
In-Reply-To: <3FF377A8.6040302@metaparadigm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Clark wrote:

> On 01/01/04 02:48, Rüdiger Klaehn wrote:
>
>> Javier Fernandez-Ivern wrote:
>>
>>> Rüdiger Klaehn wrote:
>>>
>>>> I have been wondering for some time why there is no decent file 
>>>> change notification mechanism in linux. Is there some deep 
>>>> philosophical reason for this, or is it just that nobody has found 
>>>> the time to implement it? If it is the latter, I am willing to 
>>>> implement it as long there is a chance to get this accepted into 
>>>> the mainstream kernel.
>>>
>>>
>>>
>>>
>>> Well, there's fam.  But AFAIK that's all done in user space, and 
>>> your approach would be significantly more efficient (as a matter of 
>>> fact, fam could be modified to use your change device as a first 
>>> level of notification.)
>>>
>> Fam is a user space library that has some nice features such as 
>> network transparent change notification. It currently uses the 
>> dnotify mechanism if the underlying kernel supports it, but as I 
>> mentioned the dnotify mechanism requires an open file handle and 
>> works only for single directories. If the underlying os does not 
>> support dnotify, fam resorts to polling for file changes (yuk!).
>
>
> Have you had a look at dazuko. It provides a consistent file access
> notification mechanism (and also intervention for denying access) across
> linux and freebsd. It is currently being used by various on-access
> virus scanners. It is under active development and supports 2.6 (and 2.4) 

This seems to be a descendant of this one: 
<http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/openxdsm/openxdsm/eventmodule/>

It works, but it is a slow and ugly hack to just hook into every syscall 
that does something with files. And it is quite slow and ambiguous to 
log paths instead of inodes since file paths are not unique (hard links 
etc).

But I will take a look at that code to see how they get the events to 
user space.

>
> Seems like a good idea. I've always thought it would be nice to use
> something like this to maintain a dynamic locatedb (among many other
> potential uses).
>
File change notification would be immensely useful. I think there is a 
consensus about that.


