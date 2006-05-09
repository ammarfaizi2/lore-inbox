Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWEIS4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWEIS4f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 14:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWEIS4f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 14:56:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:6840 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751163AbWEIS4e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 14:56:34 -0400
Date: Tue, 9 May 2006 11:56:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Christoph Lameter <clameter@sgi.com>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <4460DEAD.9040900@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0605091152211.3718@g5.osdl.org>
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com> 
 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com> 
 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>
  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost>
 <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
 <44603543.8070205@colorfullife.com> <Pine.LNX.4.58.0605091316010.27821@sbz-30.cs.Helsinki.FI>
 <4460DEAD.9040900@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 9 May 2006, Manfred Spraul wrote:
>
> How many kmalloc(PAGE_SIZE*n) users are there?

A single PAGE_SIZE allocation is quite common. Lots of kernel structures 
end up (often for historical reasons) being that size. PATH_MAX, for one. 
Sometimes it's also simply because it's the one "known" size that doesn't 
cause fragmentation and is easily available, so..

In other words, it's often the "canonical size" for some random buffer: 
if only because it's known to be the largest possible buffer that is 
always available.

			Linus
