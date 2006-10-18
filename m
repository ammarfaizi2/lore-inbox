Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbWJREph@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbWJREph (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 00:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWJREph
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 00:45:37 -0400
Received: from sp604002mt.neufgp.fr ([84.96.92.61]:50609 "EHLO sMtp.neuf.fr")
	by vger.kernel.org with ESMTP id S932078AbWJREpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 00:45:36 -0400
Date: Wed, 18 Oct 2006 06:45:35 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
Subject: Re: [take19 1/4] kevent: Core files.
In-reply-to: <20061018041014.GA14588@2ka.mipt.ru>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Message-id: <4535B16F.7080208@cosmosbay.com>
MIME-version: 1.0
Content-type: text/plain; charset=KOI8-R; format=flowed
Content-transfer-encoding: 7BIT
References: <11587449471424@2ka.mipt.ru>
 <200610171826.05028.dada1@cosmosbay.com> <20061017163536.GA17692@2ka.mipt.ru>
 <200610171845.54719.dada1@cosmosbay.com> <20061018041014.GA14588@2ka.mipt.ru>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Evgeniy Polyakov a e'crit :
> On Tue, Oct 17, 2006 at 06:45:54PM +0200, Eric Dumazet (dada1@cosmosbay.com) wrote:
>> I am not sure I understand what you wrote, English is not our native language.
>>
>> I think many people gave you feedbacks. I feel that all feedback on this 
>> mailing list is constructive. Many posts/patches on this list are never 
>> commented at all.
> 
> And I do greatly appreciate feedback from those people!
> 
> But I do not understand why I never got feedback on initial design and
> implementation (and then created as far as I recall at least 10
> releases) from Ulrich, who first asked for such a feture. 
> So right now I'm waiting for his opinion on that problem, even if it will 
> be 'it sucks' again, but at least in that case I will not waste people's time.
> 
> Ulrich, could you please comment on design notes sent couple of mail
> above?


Ulrich is a very busy man. We have to live with that.

<rant_mode>
For example, I *complained* one day, that each glibc fopen()/fread()/fclose() 
pass does a mmap()/munmap() to obtain a single 4KB of memory, without any 
cache mechanism. This badly hurts performance of multi-threaded programs as we 
know mmap()/munmap() has to down_write(&mm->mmap_sem); and play VM games.

So to avoid this, I manually call setvbuf() in my own programs, to provide a 
suitable buffer to glibc, because of its suboptimal default allocation, 
vestige of an old epoch...
</rant_mode>

Eric

