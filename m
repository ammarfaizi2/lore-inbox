Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129667AbQK1V1r>; Tue, 28 Nov 2000 16:27:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130422AbQK1V1i>; Tue, 28 Nov 2000 16:27:38 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:10511 "EHLO
        mail.valinux.com") by vger.kernel.org with ESMTP id <S129410AbQK1V1b>;
        Tue, 28 Nov 2000 16:27:31 -0500
Date: Tue, 28 Nov 2000 12:58:40 -0800
From: David Hinds <dhinds@valinux.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] removal of "static foo = 0" from drivers/ide (test11)
Message-ID: <20001128125840.A28888@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What information is lost? Unless you're working on a really strange
> machine which does not zero bss, the following means the same from the
> codes point of view:
>
> static int foo = 0;
> static int foo; 

I think the argument is that "static int foo;" implies you don't
actually care how "foo" is initialized, but adding the "= 0" is
revealing that the code actually relies on the default value.  The
code is obviously equivalent.  It is a readability issue, not an issue
of what the code does.

I would contend that it is a compiler bug in gcc if it treats the two
statements differently, since they are trivially equivalent.  I guess
that it has been decided that linux kernel coding style dictates no
zero initializers, so that's that.  Personally, I prefer symmetry: if
I have a list of static variables initialized to various things, I
don't have to use a different form for ones that are zero initialized.

Did the savings really work out to be measured in kb's of space?  I
would have expected compression to eliminate most of the savings.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
