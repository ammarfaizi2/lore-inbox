Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWI1Xnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWI1Xnz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 19:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWI1Xnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 19:43:55 -0400
Received: from gw.goop.org ([64.81.55.164]:26758 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751180AbWI1Xny (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 19:43:54 -0400
Message-ID: <451C5E3B.60204@goop.org>
Date: Thu, 28 Sep 2006 16:43:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Andi Kleen <ak@muc.de>,
       Hugh Dickens <hugh@veritas.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
References: <20060928225444.439520197@goop.org>	<20060928225452.229936605@goop.org> <20060928163256.aa53b8d7.akpm@osdl.org>
In-Reply-To: <20060928163256.aa53b8d7.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> What is the locking for these lists?  I don't see much in here.  It has
> implications for code which wants to do BUG while holding that lock..
>   

There's no locking.  This is a direct copy of the original powerpc 
code.  I assume, but haven't checked, that there's a lock to serialize 
module loading/unloading, so the insertion/deletion is all properly 
synchronized. 

The only other user is traversal when actually handling a bug; if you're 
very unlucky this could happen while you're actually loading/unloading 
and you would see the list in an inconsistent state.  I guess we could 
put a lock there, and trylock it on traversal; at least that would stop 
a concurrent modload/unload from getting in there while we're trying to 
walk the list.

> Shouldn't this be u64? ;)
>   

I'll get right on that.  And perhaps it should be signed if people 
overshoot and introduce a negative number of BUGs.

    J
