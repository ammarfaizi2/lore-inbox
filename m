Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVDFJCF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVDFJCF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 05:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262151AbVDFJCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 05:02:05 -0400
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:55138 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262145AbVDFJCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 05:02:00 -0400
Message-ID: <4253A584.2000201@yahoo.com.au>
Date: Wed, 06 Apr 2005 19:01:56 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kenneth_Aafl=F8y?= <lists@kenneth.aafloy.net>
CC: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style: mixed-case
References: <200504060329.21469.lists@kenneth.aafloy.net> <20050406020929.GJ25554@waste.org> <200504060437.40256.lists@kenneth.aafloy.net>
In-Reply-To: <200504060437.40256.lists@kenneth.aafloy.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Aafløy wrote:
> On Wednesday 06 April 2005 04:09, Matt Mackall wrote:
> 
>>While there may be reasons why mixed case is suboptimal, the real
>>reason is that it's hard to keep track of which style is used where.
>>It's annoying and error-prone to have to remember the naming format
>>for everything in addition to its name. As most things are in a
>>standard style, things are made easier by having every piece of new
>>code follow that style and let us slowly approach uniformity.
> 
> 
> My primary concern was that of; why does the kernels own coding style
> deviate from that advise given in it's documentation. Other than that

Probably it's been like that for a long time, and nobody has
really bothered to change it.

>>If you posted a patch for pf_locked() and friends (and note that it's
>>lowercase to match function-like usage), you'd probably find some
>>enthusiasts and some naysayers. Most of the naysayers would object on
>>the grounds of "it ain't broke", but if someone were to do it as part
>>of a series of more substantial clean-ups, it'd likely be accepted.
> 
> 
> Certainly I would like to have a go at a patch, but I must say that I do not
> feel particularly familiar with the code in question to make such a change.
> I would have risen to the challenge had this been a driver level change,
> but the mmu is something that I will not touch untill I feel comfortable.

Well the only patch that could possibly be considered would be a
straight search and replace, and absolutely no functional changes;
I think you would be up to it ;)

A few suggestions:
Don't use PF_*. That namespace is already being used by at least
process flags and protocol flags. Maybe page_locked, page_dirty,
etc. might be better

There could be a quite a bit of external code using these interfaces.
Typically we wouldn't just rename public interfaces in a stable
series "just because", but the rules are a bit different for 2.6.

Your best bet would be to firstly do a patch to create the new interface
names but keep the old ones in place for backwards compatibility (just
#defined to the new name), then a second patch to convert over all the
in-kernel users. The compatibility stuff can be removed in N years.

Lastly, it is quite likely that many people will consider this to be
more trouble than it's worth. So keep in mind it is not guaranteed to
get included.

-- 
SUSE Labs, Novell Inc.

