Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbVJ0ViA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbVJ0ViA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbVJ0ViA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:38:00 -0400
Received: from wproxy.gmail.com ([64.233.184.200]:59485 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932650AbVJ0ViA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:38:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Jr0F8fhe2vmRrr83MPnZrLPePjrZTPnWutKi+cKhC+Tq99UUmFu1noPUk7PIxVbHD4c2dr3YJBbDds9ujKxEVHARvWszkCIn7/LMf4nnftsycAI3Cc0018fUvENZBH4SOAMnXbon9w4TF1kjX6MLTHIOrFfva55Ki8q4YZJ5Nks=
Message-ID: <5c49b0ed0510271437x6108130bo4c8d86bc907dc70d@mail.gmail.com>
Date: Thu, 27 Oct 2005 14:37:59 -0700
From: Nate Diller <nate.diller@gmail.com>
To: Ben Greear <greearb@candelatech.com>
Subject: Re: kernel BUG at mm/slab.c:1488! (2.6.13.2)
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43613EC4.4080006@candelatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43613EC4.4080006@candelatech.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/05, Ben Greear <greearb@candelatech.com> wrote:
> I was compiling with ext3 as a module, then changed to compiling static
> and un-tarred the new kernel over the old (the old ext3 module was still
> in existence.)  I re-ran the mkinitrd and rebooted.
>
> It seems that something still tries to load the ext3 module, and I get the
> BUG seen below.  If I remove the ext3 module and re-build the initrd,
> the error goes away.
>
> I was thinking that at the least, the ext3 module code should somehow
> detect
> that it is already built-in and exit it's load attempt very early (before
> triggering whatever bug it hit).
>

There was a thread about this some months ago
(http://marc.theaimsgroup.com/?l=linux-kernel&m=111639356609390&w=2),
and two patches were proposed, to either return NULL here or WARN_ON,
and keep going.  Neither seems to have been picked up.  Maybe people
think this is not a big problem?  I would certainly like to see a way
to prevent modules from being loaded multiple times, or when they are
also compiled-in, but aside from returning NULL here in
kmem_cache_create, I don't see a trivial way of doing it.

NATE
