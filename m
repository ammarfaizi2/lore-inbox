Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285411AbRLNQjL>; Fri, 14 Dec 2001 11:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285412AbRLNQjB>; Fri, 14 Dec 2001 11:39:01 -0500
Received: from waste.org ([209.173.204.2]:28549 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S285411AbRLNQiu>;
	Fri, 14 Dec 2001 11:38:50 -0500
Date: Fri, 14 Dec 2001 10:38:17 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org, <torvalds@transmeta.com>, <kaos@ocs.com.au>
Subject: Re: [PATCH] 2.5.1-pre10 #ifdef CONFIG_KMOD Cleanup Part II.
In-Reply-To: <E16ELSB-0005Xt-00@wagner.rustcorp.com.au>
Message-ID: <Pine.LNX.4.40.0112141019100.11489-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2001, Rusty Russell wrote:

> 2) Adds request_module_start()/request_module_end() macros, eg.
>
> 	struct protocol protoptr;
>
> 	request_module_start("proto-%u", protonum) {
> 		/* search for protocol, set protoptr. */
>
> 	} request_module_end(protoptr != NULL);
>
>    This loops once if !CONFIG_KMOD or protoptr != NULL after first
>    iteration, otherwise calls request_module and loops a second time.

Clever, but very un-C-like. Perhaps something like this:

do {
  /* search for protocol, set protoptr. */
} while (protoptr != NULL || request_module("proto-%u",protonum)==0);

..with request_module returning -EBUSY if the module is already loaded.

> 3) Adds a request_module_unless() macro, eg:
>
> 	protoptr = request_module_unless(protoptrs[proto],
> 					 "proto-%u", protonum);

Also weird.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


