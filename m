Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWB1Sil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWB1Sil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 13:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWB1Sil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 13:38:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:37278 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S932293AbWB1Sik
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 13:38:40 -0500
Message-ID: <440498AA.6000101@namesys.com>
Date: Tue, 28 Feb 2006 10:38:34 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Marr <marr@flex.com>, linux-kernel@vger.kernel.org,
       reiserfs-dev@namesys.com, philb@gnu.org
Subject: Re: Drastic Slowdown of 'fseek()' Calls From 2.4 to 2.6 -- VMM Change?
References: <200602241522.48725.marr@flex.com> <20060224211650.569248d0.akpm@osdl.org> <440374DF.8080901@namesys.com> <4403935A.3080503@tmr.com>
In-Reply-To: <4403935A.3080503@tmr.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:

> Hans Reiser wrote:
>
>> Andrew Morton wrote:
>>
>>> runs like a dog on 2.6's reiserfs.  libc is doing a (probably) 128k
>>> read
>>> on every fseek.
>>>
>>> - There may be a libc stdio function which allows you to tune this
>>>  behaviour.
>>>
>>> - libc should probably be a bit more defensive about this anyway -
>>>  plainly the filesystem is being silly.
>>>  
>>>
>> I really thank you for isolating the problem, but I don't see how you
>> can do other than blame glibc for this.  The recommended IO size is only
>> relevant to uncached data, and glibc is using it regardless of whether
>> or not it is cached or uncached.   Do I misunderstand something
>> myself here?
>
>
> I think the issue is not "blame" but what effect this behavior would
> have on things like database loads, where seek-write would be common.
> Good to get this info to users and admins.
>
Well, ok, let me phrase it as "this should be fixed in glibc".   Does
anyone know who the maintainer for it is?
