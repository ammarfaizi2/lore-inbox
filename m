Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132580AbRDKORr>; Wed, 11 Apr 2001 10:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132579AbRDKORh>; Wed, 11 Apr 2001 10:17:37 -0400
Received: from t2.redhat.com ([199.183.24.243]:1275 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S132578AbRDKOR1>; Wed, 11 Apr 2001 10:17:27 -0400
To: afranck@gmx.de
Cc: David Howells <dhowells@cambridge.redhat.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2nd try: i386 rw_semaphores fix 
In-Reply-To: Your message of "Wed, 11 Apr 2001 15:40:21 +0200."
             <3AD45EC5.81EB82AD@akustik.rwth-aachen.de> 
Date: Wed, 11 Apr 2001 15:17:19 +0100
Message-ID: <16795.986998639@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd like you to look over it. It seems newer GCC's (snapshots and the
> upcoming 3.0) will be more strict when modifying some values through
> assembler-passed pointers - in this case, the passed semaphore structure got
> freed too early, causing massive stack corruption on early bootup.
>
> The solution was to directly mention the modified element (in this case,
> sem->count) with a "=m" qualifier, which told GCC that the contents of the
> semaphore structure are still really needed. It does not seem to have any
> bad side effects on older GCC, but lets the code work on people trying to
> use the newer snapshots.

I've just consulted with one of the gcc people we have here, and he says that
the '"memory"' constraint should do the trick.

Do I take it that that is actually insufficient?

David
