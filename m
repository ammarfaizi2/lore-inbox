Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758012AbWKZWXl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012AbWKZWXl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 17:23:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758013AbWKZWXl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 17:23:41 -0500
Received: from smtp.osdl.org ([65.172.181.25]:38320 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1758012AbWKZWXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 17:23:40 -0500
Date: Sun, 26 Nov 2006 14:20:10 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland Dreier <rdreier@cisco.com>
cc: Andrew Morton <akpm@osdl.org>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, openib-general@openib.org,
       tom@opengridcomputing.com, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] Avoid truncating to 'long' in ALIGN() macro
In-Reply-To: <adapsba2bvj.fsf@cisco.com>
Message-ID: <Pine.LNX.4.64.0611261415530.3483@woody.osdl.org>
References: <adazmag5bk1.fsf@cisco.com> <20061124.220746.57445336.davem@davemloft.net>
 <adaodqv5e5l.fsf@cisco.com> <20061125.150500.14841768.davem@davemloft.net>
 <adak61j5djh.fsf@cisco.com> <20061125164118.de53d1cf.akpm@osdl.org>
 <ada64d23ty8.fsf@cisco.com> <20061126111703.33247a84.akpm@osdl.org>
 <Pine.LNX.4.64.0611261208550.3483@woody.osdl.org> <adapsba2bvj.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 Nov 2006, Roland Dreier wrote:
>
>  > +#define ALIGN(x,a)		__ALIGN_MASK(x,(typeof(x))(a)-1)
>  > +#define __ALIGN_MASK(x,mask)	(((x)+(mask))&~(mask))
> 
> Fine by me, but it loses the extra (typeof(x)) cast that Al wanted to
> make sure that the result of ALIGN() is not wider than x.

Well, since "mask" is now made to be of the same type as "x", every 
sub-expression actually has the same type, modulo the normal C behaviour 
of "expand to at least "int".

So arguably, the result is _more_ like a normal C operation this way. 
Type-wise, the "ALIGN()" macro acts like any other C operation (ie if you 
feed it an "unsigned char", the end result is an "int" due to the normal C 
type widening that happens for all C operations).

But I don't care horribly much. Al may have some other reasons to _not_ 
want the normal C type expansion to happen (ie maybe he does something 
unnatural with sparse ;)

			Linus
