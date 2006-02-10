Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWBJGDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWBJGDL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 01:03:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWBJGDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 01:03:11 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:49851 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751151AbWBJGDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 01:03:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=tF/NIku0bp4LZQ+DVjIZ8TYpbS5KeJEFx1pDDaJegU+8XUm4UTBV4CWNKxuAHJolytSRgMzGUGbR+JHSGJqeeQ+2D5l4ADlZ5PCGPePZMjDyXLTrvbIOoiryTP4SHwWHA4qyoml1U2ue38LxHnDl6UD124CjRLuGGabMSQ1byBw=  ;
Message-ID: <43EC2C9A.7000507@yahoo.com.au>
Date: Fri, 10 Feb 2006 17:03:06 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au>	<20060209094815.75041932.akpm@osdl.org>	<43EC0A44.1020302@yahoo.com.au>	<20060209195035.5403ce95.akpm@osdl.org>	<43EC0F3F.1000805@yahoo.com.au>	<20060209201333.62db0e24.akpm@osdl.org>	<43EC16D8.8030300@yahoo.com.au>	<20060209204314.2dae2814.akpm@osdl.org>	<43EC1BFF.1080808@yahoo.com.au>	<20060209211356.6c3a641a.akpm@osdl.org>	<43EC24B1.9010104@yahoo.com.au> <20060209215040.0dcb36b1.akpm@osdl.org>
In-Reply-To: <20060209215040.0dcb36b1.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:

>>But I've explained that they only matter for people using it in stupid ways.
>>fsync also poses a performance problem for programs that call it after every
>>write(2).
> 
> 
> There's absolutely nothing stupid about
> 
> 	*p = <expr>
> 	msync(p, sizeof(*p), MS_ASYNC);
> 

There really is if you're expecting a short time later to do

	*p = <expr2>

and had no need for a MS_SYNC anywhere in the meantime.
If you did have the need for MS_SYNC, then kicking off the IO
ASAP is going to be more efficient.

>>
>>Is a more efficient implementation know-problematic?
> 
> 
> It's less efficient for some things.  A lot.
> 

But only for stupid things, right?

> 
>>What applications did
>>you observe problems with, can you remember?
> 
> 
> Linus has some application which was doing the above.  It ran extremely
> slowly, so we changed MS_ASYNC (ie: made it "more efficient"...)

Can he remember what it is? It sounds like it is broken.

OTOH, it could have been blocking on pages already under writeout
but a smarter implementation could ignore those (at the cost of
worse IO efficiency in these rare cases).

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
