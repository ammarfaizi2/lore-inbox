Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286210AbRLaDyL>; Sun, 30 Dec 2001 22:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286211AbRLaDyC>; Sun, 30 Dec 2001 22:54:02 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:60684 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286210AbRLaDxx>;
	Sun, 30 Dec 2001 22:53:53 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: merge in progress. 
In-Reply-To: Your message of "Mon, 31 Dec 2001 03:15:06 -0000."
             <20011231031506.A1537@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 31 Dec 2001 14:53:34 +1100
Message-ID: <29543.1009770814@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001 03:15:06 +0000, 
Dave Jones <davej@suse.de> wrote:
>Ok, pre5 gets us in sync with most of the important and easy
>to merge bits. Here's a list of whats left between the trees.
>
>Pending:
>o  Bunch of __devexit changes
>o  Keith's text.lock -> .subsection changes
>   Better to merge this first and see whats left broken before merging
>   the __devexit changes, in case there are any more bogus ones.

The __devexit_p changes are required in addition to .text.lock ->
.subsection, they are fixing different parts of the same problem.  Most
of the devexit_p changes were in my patch against 2.4.17-pre6, all of
those changes are needed.  The only devexit changes from 2.4.17-pre6 to
2.4.17 are :-

drivers/char/synclink.c

  Spurious, there is no point in specifying __init, __exit etc. on the
  declaration, those attributes only affect the function body.  The
  change has no effect.  Anybody want to go through and remove spurious
  __init, __exit etc. on forward function declarations?

drivers/pcmcia/i82092.c

  Mine, valid AFAICT.

drivers/isdn/hisax/hisax_fcpcipnp.c

  Don't know who changed it but it is valid.  hisax_fcpcipnp was added
  after my first patch against 2.4.16 and I missed the new driver when
  I redid the devexit_p patch for 2.4.17.

I would add all the devexit_p changes through 2.4.17 at least, in
addition to the .text.lock changes.

