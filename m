Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266775AbUBRXBp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 18:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266518AbUBRXBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 18:01:45 -0500
Received: from fw.osdl.org ([65.172.181.6]:58332 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267001AbUBRXA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 18:00:27 -0500
Date: Wed, 18 Feb 2004 14:59:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: tridge@samba.org
cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: UTF-8 and case-insensitivity
In-Reply-To: <16435.60448.70856.791580@samba.org>
Message-ID: <Pine.LNX.4.58.0402181457470.18038@home.osdl.org>
References: <16433.38038.881005.468116@samba.org> <16433.47753.192288.493315@samba.org>
 <Pine.LNX.4.58.0402170704210.2154@home.osdl.org> <16434.41376.453823.260362@samba.org>
 <c0uj52$3mg$1@terminus.zytor.com> <Pine.LNX.4.58.0402171859570.2686@home.osdl.org>
 <4032D893.9050508@zytor.com> <Pine.LNX.4.58.0402171919240.2686@home.osdl.org>
 <16435.55700.600584.756009@samba.org> <Pine.LNX.4.58.0402181422180.2686@home.osdl.org>
 <Pine.LNX.4.58.0402181427230.2686@home.osdl.org> <16435.60448.70856.791580@samba.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Feb 2004 tridge@samba.org wrote:
> 
>  > And I bet the performance advantages of _not_ doing native case 
>  > insensitivity are likely to dominate hugely.
> 
> This part I just don't understand at all. The proposed changes would
> be extremely cheap performance wise as you are just replacing one hash
> with another, and dealing with one extra context bit in the
> dcache. There is no way that this could come anywhere near the cost of
> doing linear directory scans.

Why do you focus on linear directory scans?

They simply do not happen under any reasonable IO patterns. You look up 
names under the same name that they are on the disk. So the _only_ thing 
that should matter is the exact match.

The inexact matches should be a case of "make them correct". Screw 
performance. And tell people that they are slower.

Sure, I can imaging that MS would make some benchmark to show that case, 
but at that point I just don't care. 

		Linus
