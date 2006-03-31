Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWCaUtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWCaUtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 15:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932154AbWCaUtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 15:49:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13445 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932110AbWCaUtw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 15:49:52 -0500
Date: Fri, 31 Mar 2006 12:49:43 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Hua Zhong <hzhong@gmail.com>
cc: "'Jens Axboe'" <axboe@suse.de>, "'Ingo Molnar'" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: RE: [PATCH] splice support #2
In-Reply-To: <000001c65503$207d8e40$853d010a@nuitysystems.com>
Message-ID: <Pine.LNX.4.64.0603311244300.27203@g5.osdl.org>
References: <000001c65503$207d8e40$853d010a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Mar 2006, Hua Zhong wrote:
> 
> If I understand correctly:
> 
> splice is one fd in, one fd out

Yes, and one of the fd's have to be a pipe.

> tee is one fd in, two fd out (and I'd assume the "one fd in" would always be
> a pipe)

Actually, all three of them would have to be pipes. The tee() thing has to 
push to both sources in a "synchronized" manner, so it can't just take 
arbitrary file descriptors that it doesn't know the exact buffering rules 
for.

(Otherwise you wouldn't need "tee()" at all - you could have a "splice()" 
that just takes several output fd's).

> How about one fd in, N fd out? Do you then stack the tee calls using
> temporary pipes?

I didn't write the tee() logic, but making it 1:N instead of 1:2 is not 
conceptually a problem at all. The exact system call interface might limit 
it some way, of course. 

		Linus
