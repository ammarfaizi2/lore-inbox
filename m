Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWIVQNm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWIVQNm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:13:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751081AbWIVQNm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:13:42 -0400
Received: from terminus.zytor.com ([192.83.249.54]:29601 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751083AbWIVQNl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:13:41 -0400
Message-ID: <45140B95.8080305@zytor.com>
Date: Fri, 22 Sep 2006 09:13:09 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
CC: Dax Kelson <dax@gurulabs.com>, Linux kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Smaller compressed kernel source tarballs?
References: <1158870777.24172.23.camel@mentorng.gurulabs.com> <20060921204250.GN13641@csclub.uwaterloo.ca> <45130792.9040104@zytor.com> <20060922140007.GK13639@csclub.uwaterloo.ca>
In-Reply-To: <20060922140007.GK13639@csclub.uwaterloo.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lennart Sorensen wrote:
> On Thu, Sep 21, 2006 at 02:43:46PM -0700, H. Peter Anvin wrote:
>> 7zip (LZMA) decompresses quickly, and the decompressor text is actually 
>> smaller than the equivalent for gzip.  Quite nice.
>>
>> What is not nice is the code for the compressor, which is a total mess. 
>>  I have been holding out on implementing LZMA on kernel.org, because 
>> just as zip (deflate) didn't become common in the Unix world until an 
>> encapsulation format that handles things expected in the Unix world, 
>> e.g. streaming, was created (gzip), I don't think LZMA is going to be 
>> widely used until there is an "lzip" which does the same thing.  I 
>> actually started the work of adding LZMA support to gzip, but then 
>> realized it would be better if a new encapsulation format with proper 
>> 64-bit support everywhere was created.
> 
> It doesn't handle streaming?
> 
> So you can't do: tar c dirname | 7zip dirname.tar.7z ?
> 

Nope, and in particular you can't do:

tar cf - dirname | 7zip | ssh ...

This is because 7zip is an archiving format in its own right, much like 
zip.  What we want is something that is to 7zip what gzip is to zip.

	-hpa
