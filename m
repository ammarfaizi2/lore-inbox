Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132610AbRAKQy4>; Thu, 11 Jan 2001 11:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132618AbRAKQyq>; Thu, 11 Jan 2001 11:54:46 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:9226 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S132610AbRAKQyg>;
	Thu, 11 Jan 2001 11:54:36 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200101111650.f0BGoLG473101@saturn.cs.uml.edu>
Subject: Re: Subtle MM bug
To: sct@redhat.com (Stephen C. Tweedie)
Date: Thu, 11 Jan 2001 11:50:21 -0500 (EST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.de (Andi Kleen),
        trond.myklebust@fys.uio.no (Trond Myklebust),
        phillips@innominate.de (Daniel Phillips), linux-kernel@vger.kernel.org,
        sct@redhat.com (Stephen Tweedie)
In-Reply-To: <20010111125604.A17177@redhat.com> from "Stephen C. Tweedie" at Jan 11, 2001 12:56:04 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie writes:
> On Wed, Jan 10, 2001 at 12:11:16PM -0800, Linus Torvalds wrote:

>> That said, we can easily support the notion of CLONE_CRED if
>> we absolutely have to (and sane people just shouldn't use it),
>> so if somebody wants to work on this for 2.5.x...
>
> But is it really worth the pain?  I'd hate to have to audit the
> entire VFS to make sure that it works if another thread changes our
> credentials in the middle of a syscall, so we either end up having to
> lock the credentials over every VFS syscall, or take a copy of the
> credentials and pass it through every VFS internal call that we make.

1. each thread has a copy, and doesn't need to lock it
2. threads are commanded to change their own copy

Credentials could be changed on syscall exit. It is a bit like
doing signals I think, with less overhead than making userspace
muck around with signal handlers and synchronization crud.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
