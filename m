Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVKEAMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVKEAMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 19:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbVKEAMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 19:12:24 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:59003 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751184AbVKEAMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 19:12:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kXFnHgvWBMGpNVkpgPklYY/1AJJxVjRyA5xbmwtsMAtdrJuWoR3L5jVULVKo/ShDbZNoU+QPoViATGPZ3FNxxDjnyVTm4OmXkWmpMAM+ZIRsJIEd9NEx6KImYTdTwnAY74jliGz2l288rizgx67vgR1VoFMZXh4E6nCgN++hOFI=  ;
Message-ID: <436BF961.9070402@yahoo.com.au>
Date: Sat, 05 Nov 2005 11:14:25 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: ntl@pobox.com, viro@ftp.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] big reader semaphore take#2
References: <20051028104437.GA17461@htj.dyndns.org> <436B79BA.6070300@gmail.com>
In-Reply-To: <436B79BA.6070300@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Tejun Heo wrote:
> 
>>  Hello guys,
>>
>> This is the second take of brsem (big reader semaphore).
>>
>> Nick, unfortunately, simple array of rwsem's does not work as lock
>> holders are not pinned down to cpus and may release locks on other
>> cpus.
>>

[...]

> 
> (Nick, what do you think about the new implementation?)
> 

As I said, I think I'd prefer to see an implementation that returns
a token from down_read to be used in up_read (ie. the slot # of the
counter which has been downed).

This obviously no longer makes it a drop in replacement for an rwsem.
But could such a beast ever be considered so? Would that make your
VFS patches really ugly?

The upshot of that would be that you could build the whole thing
from rwsem infrastructure and have basically zero other locking
mechanisms or complexity that you don't want in a synchronisation
primitive.

Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
