Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267079AbTAUOCj>; Tue, 21 Jan 2003 09:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267080AbTAUOCj>; Tue, 21 Jan 2003 09:02:39 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:6662 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267079AbTAUOCi>; Tue, 21 Jan 2003 09:02:38 -0500
Date: Tue, 21 Jan 2003 09:09:03 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "David S. Miller" <davem@redhat.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] __cacheline_aligned_in_smp?
In-Reply-To: <20030113.223253.18825371.davem@redhat.com>
Message-ID: <Pine.LNX.3.96.1030121090420.30318B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, David S. Miller wrote:

>    From: Rusty Russell <rusty@rustcorp.com.au>
>    Date: Tue, 14 Jan 2003 12:10:12 +1100
> 
>    Hmm, you really want to weakly align it: you don't care if something follows it on
>    the cacheline, (ie. don't make it into an array, but it'd be nice if other
>    things could share the cacheline) in UP.
>    
> No, that is an incorrect statement.
> 
> I want the rest of the cacheline to be absent of any write-possible
> data.  There are many members in there which are read-only and thus
> will only consume a cacheline which would never need to be written
> back to main memory due to modification.
> 
> If you allow other things to seep into that cache line, you totally
> obliterate what I was trying to accomplish.

Am I missing something here? If you have ro and rw data in a cache line:
1r  0w  if you don't modify the data
1r  1w  if you do
if you have ro and rw in separate cache lines:
2r  0w  if you don't modify the data
2r  1w  if you do

It would seem that you always have at least one read, and if you modify
the data at least one write, wherein is the saving?

Note: I am not disagreeing with you, I just can't follow how this is a
win in any case.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

