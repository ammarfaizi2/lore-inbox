Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932615AbVLQRTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932615AbVLQRTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 12:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932614AbVLQRTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 12:19:44 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:19134 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S932613AbVLQRTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 12:19:43 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Date: Sat, 17 Dec 2005 09:19:47 -0800
User-Agent: KMail/1.9
Cc: torvalds@osdl.org, dhowells@redhat.com, nickpiggin@yahoo.com.au,
       arjan@infradead.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       cfriesen@nortel.com, hch@infradead.org, matthew@wil.cx,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <Pine.LNX.4.64.0512161429500.3698@g5.osdl.org> <200512161641.49571.jbarnes@virtuousgeek.org> <20051216.231056.124758189.davem@davemloft.net>
In-Reply-To: <20051216.231056.124758189.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512170919.47383.jbarnes@virtuousgeek.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, December 16, 2005 11:10 pm, David S. Miller wrote:
> From: Jesse Barnes <jbarnes@virtuousgeek.org>
> Date: Fri, 16 Dec 2005 16:41:49 -0800
>
> > Note that under contention prefetching with a write bias can cause
> > a lot more cache line bouncing than a regular load into shared
> > state (assuming you do a load and test before you try the CAS).
>
> If there is some test guarding the CAS, yes.

Yeah, I was only referring to that particular case (the ia64 code does 
test then CAS, so removing the write bias on the load avoided a lot of 
thrashing for locks under contention).

> But if there isn't, for things like atomic increment and
> decrement, where the CAS is unconditional, you'll always
> eat the two bus transactions without the prefetch for write.

Right, in that case, biasing for read might make sense, as long as some 
other CPU doesn't cause the line to go back to shared before you 
actually get to the CAS.

Jesse
