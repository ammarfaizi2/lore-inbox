Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWDVTFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWDVTFq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbWDVTFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:05:46 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:3740 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750945AbWDVTFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:05:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=uCDEj9zmW2+nNN1aEw0FeJujoJZQA49vhEM8q5inMekw9VMbvWsTfqEO06CoO+KVDjYE1OCn6ebdt/sRog9mbitlVMQ/RPPF8b9a4XG4juJw1FEYu4lreIQRTo31oOTdXRnIPzoV1JLTbXDMZTSwECKWpW+Uy3sc5cdkBHL/IH0=  ;
Message-ID: <444A7E85.4030803@yahoo.com.au>
Date: Sun, 23 Apr 2006 05:05:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Hua Zhong <hzhong@gmail.com>
CC: "'Paul Mackerras'" <paulus@samba.org>,
       "'Pekka Enberg'" <penberg@cs.helsinki.fi>,
       "'Andrew Morton'" <akpm@osdl.org>, "'James Morris'" <jmorris@namei.org>,
       dwalker@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
References: <001201c6663e$983f7960$0200a8c0@nuitysystems.com>
In-Reply-To: <001201c6663e$983f7960$0200a8c0@nuitysystems.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hua Zhong wrote:
>  > There is a judgement to be made at each call site of kfree 
> 
>>(and similar functions) about whether the argument is rarely 
>>NULL, or could often be NULL.  If the janitors have been 
>>making this judgement, I apologise, but I haven't seen them 
>>doing that.
>>
>>Paul.
> 
> 
> Even if the caller passes NULL most of the time, the check should be removed.
> 
> It's just crazy talk to say "you should not check NULL before calling kfree, as long as you make sure it's not NULL most of the
> time".

It can reduce readability of the code [unless it is used in error path
simplification, kfree(something) usually suggests kfree-an-object].

If the caller passes NULL most of the time, it could be in need of
redesign.

I don't actually like kfree(NULL) any time except error paths. It is
subjective, not crazy talk.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
