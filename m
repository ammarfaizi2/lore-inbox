Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265584AbRGCIEi>; Tue, 3 Jul 2001 04:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266471AbRGCIE2>; Tue, 3 Jul 2001 04:04:28 -0400
Received: from t2.redhat.com ([199.183.24.243]:59382 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265584AbRGCIEV>; Tue, 3 Jul 2001 04:04:21 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dwmw2@infradead.org (David Woodhouse), dhowells@redhat.com (David Howells),
        jes@sunsite.dk (Jes Sorensen), linux-kernel@vger.kernel.org,
        arjanv@redhat.com
Subject: Re: [RFC] I/O Access Abstractions 
In-Reply-To: Your message of "Mon, 02 Jul 2001 17:56:56 BST."
             <E15H70K-0006Cn-00@the-village.bc.nu> 
Date: Tue, 03 Jul 2001 09:04:15 +0100
Message-ID: <3925.994147455@warthog.cambridge.redhat.com>
From: David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Case 1:
> 	You pass a single cookie to the readb code
> 	Odd platforms decode it

As opposed to passing a cookie (struct resource) and an offset, and letting
the compiler do the addition it'd do anyway or eliminate the cookie directly
on platforms where this is suitable.

> Case 2:
> 	You carry around bus number information all throughout
> 		each driver

Eh? Who said anything about bus number info? Just the information in the
resource structure.

> 	You keep putting it on/off the stack

Why should I want to do that? You've got to keep the base address of your
resource space somewhere anyway, so you could just replace it with a pointer
to the resource struct (which you've already got). Plus, I can pass this in a
register to any behind the scenes function.

In my example code, in the really simple cases (most of them), there were no
pushes and pops.

> 	You keep it in structures

Doesn't everyone? Apart from those that use global variables, I suppose, but
surely they're limited in reusability.

> 	You do complex generic locking for hotplug 'just in case'

Eh? No I wasn't, but under some circumstances one might have to do that
anyway, and so the out-of-line functions may be the best place to do that.

David
