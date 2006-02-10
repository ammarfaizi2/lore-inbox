Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751249AbWBJMl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbWBJMl7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWBJMl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:41:59 -0500
Received: from smtp201.mail.sc5.yahoo.com ([216.136.129.91]:42633 "HELO
	smtp201.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751249AbWBJMlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:41:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=T6iAUb67G2jb5HgXPwTO+/2zrvObwREhZvKM9YOYklBsOUPk8nAFGxo2VciHeS8yEonRJJiy+nBqwknsNeiaROyG0ZhcHpsZIiSbvgRs5ZJjtu4XytNVF7E9QzshKoqOrNlxBGBJtW8xCov1hSx6BotbtSYA3K5XT4jH8DCRtTo=  ;
Message-ID: <43EC8A06.40405@yahoo.com.au>
Date: Fri, 10 Feb 2006 23:41:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com,
       torvalds@osdl.org
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
References: <20060209071832.10500.qmail@science.horizon.com>	<20060209001850.18ca135f.akpm@osdl.org>	<43EAFEB9.2060000@yahoo.com.au>	<20060209004208.0ada27ef.akpm@osdl.org>	<43EB3801.70903@yahoo.com.au>	<20060209094815.75041932.akpm@osdl.org>	<43EC0A44.1020302@yahoo.com.au>	<20060209195035.5403ce95.akpm@osdl.org>	<43EC0F3F.1000805@yahoo.com.au>	<20060209201333.62db0e24.akpm@osdl.org>	<43EC16D8.8030300@yahoo.com.au>	<20060209204314.2dae2814.akpm@osdl.org>	<43EC1BFF.1080808@yahoo.com.au>	<20060209211356.6c3a641a.akpm@osdl.org>	<43EC24B1.9010104@yahoo.com.au>	<20060209215040.0dcb36b1.akpm@osdl.org>	<43EC2C9A.7000507@yahoo.com.au>	<20060209221324.53089938.akpm@osdl.org>	<43EC3326.4080706@yahoo.com.au>	<20060209224656.7533ce2b.akpm@osdl.org>	<43EC3961.3030904@yahoo.com.au> <20060209231432.03a09dee.akpm@osdl.org>
In-Reply-To: <20060209231432.03a09dee.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
>>Instead of
>> LINUX_FADV_ASYNC_WRITE
>> LINUX_FADV_WRITE_WAIT
>>
>> can we have something more consistent? Perhaps
>> FADV_WRITE_ASYNC
>> FADV_WRITE_SYNC
> 
> 
> Nope, I had a bit of a think about this and decided that the two operations
> which we need are:
> 
> 

Do you need to introduce a completely new concept 'wait upon writeout'
though? Not to say they can't solve the problem but I don't think they
are any more expressive and they definitely depart from the norm which
has always been sync / async AFAIK.

It may be a very useful operation in kernel, but I think userspace either
wants to definitely know the data is on disk (WRITE_SYNC), or give a hint
to start writing (WRITE_ASYNC).

 From a kernel implementation point of view, WRITE_SYNC may be doing
several things (start writeout, wait writeout), but from userspace it is
just a single logical operation.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
