Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136039AbRAHAwz>; Sun, 7 Jan 2001 19:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136123AbRAHAwp>; Sun, 7 Jan 2001 19:52:45 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48907 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136039AbRAHAwe>;
	Sun, 7 Jan 2001 19:52:34 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: richbaum@acm.org
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix compile warnings in 2.4.0 
In-Reply-To: Your message of "Sun, 07 Jan 2001 16:19:50 CDT."
             <3A589726.5449.291B75@localhost> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 11:52:27 +1100
Message-ID: <9097.978915147@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001 16:19:50 -0500, 
"Rich Baum" <baumr1@coral.indstate.edu> wrote:
>This patch should fix the rest of the warnings about #endif 
>statements when using the 20001225 gcc snapshot.  Thanks to 
>Keith Owens for providing a script to automate this process.  It got 
>the job done sooner and found warnings to fix for non x86 platforms.

As reported by Neil Booth, your patch contains errors which do not
appear in my patched system using my script.  You probably skipped the
leading '^' in the regexp.  It also turns out that there are a couple
of m68k assembler lines which have a trailing '#' which starts a
comment on that assembler.  So treat '#' as a comment marker as well.

Whatever you used, it was not my script.  It should be (with '#' added)

  find -type f -name '*.[chS]' | \
    xargs perl -lpi -e 's:^(\s*#\s*endif)\s+([^/\s#].*)$:\1\t/* \2 */:;'

BTW, until the patch is correct do not bother sending it to Alan Cox or
Linus, just to linux-kernel..

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
