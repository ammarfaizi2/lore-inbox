Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWDYJGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWDYJGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 05:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWDYJGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 05:06:05 -0400
Received: from smtp809.mail.ukl.yahoo.com ([217.12.12.199]:53175 "HELO
	smtp809.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751472AbWDYJGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 05:06:04 -0400
Message-ID: <444DE678.4040805@btinternet.com>
Date: Tue, 25 Apr 2006 10:06:00 +0100
From: Matt Keenan <matt.keenan@btinternet.com>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com>	 <1145911546.1635.54.camel@localhost.localdomain>	 <444D3D32.1010104@argo.co.il> <1145915918.1635.64.camel@localhost.localdomain> <444DCDB8.4070807@argo.co.il>
In-Reply-To: <444DCDB8.4070807@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avi Kivity wrote:
> Alan Cox wrote:
>> On Maw, 2006-04-25 at 00:03 +0300, Avi Kivity wrote:
>>  
>>> Alan Cox wrote:
>>> I think it's easy to show that the equivalent C++ code would be 
>>> shorter, faster, and safer.
>>>     
>>
>> Mathematically the answer is "no you couldn't". You might be able to
>> argue that a fortran implementation would be faster but not a C++ one.
>>   
> Maybe not mathematically, but I can try to hand-wave my way through.
>
> By using exceptions, you free the normal return paths from having to 
> check for errors. The exception paths can be kept in a dedicated 
> section, avoiding cache pollution. The total code (and data) size 
> increases, but the non-exception paths size decreases significantly 
> and becomes faster.
>
> Using C++ objects instead of C objects allows you to avoid void 
> pointers, which are difficult for the compiler to optimize due to 
> aliasing.
Exception handling on a kernel with a 4K stack would be very 
interesting, now imagine what would happen if one exception triggered 
another? and possibly another?? And even giving up on the stack issues, 
what about cacheline / performance issues? Moving error handling even 
further from the fast path isn't going to help performance much.. How 
about an exception for every ENOENT? Have you seen how many ENOENT's 
/lib/ld-linux.so.2 generates when a large app starts? Take firefox, load 
it, let it open five tabs, then shut it down. On my system, 1377 
open()'s, 527 of which are ENOENT, 135 of those before the program has 
finished linking. Not exactly the best way to speed the system up. And 
don't say you can use the dentry cache to return an object or NULL, as 
this is just replication of what C does, but with even more syntatic 
goop. C++ is a good tool, for the right job. The kernel is not one of them.
