Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264468AbTLRFuw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 00:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTLRFuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 00:50:52 -0500
Received: from pat.uio.no ([129.240.130.16]:20945 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S264468AbTLRFuu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 00:50:50 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.0
References: <Pine.LNX.4.58.0312171951030.5789@home.osdl.org>
	<20031217211516.2c578bab.akpm@osdl.org>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 18 Dec 2003 00:50:44 -0500
In-Reply-To: <20031217211516.2c578bab.akpm@osdl.org>
Message-ID: <shsekv2ptcb.fsf@guts.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.9, required 12,
	BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Congratulations Linus and Andrew...

Will you be posting a plan for how you want the 2.6.x series to
proceed? I gather I'm not alone in having a load of patches that I'd
like to send you ASAP...

Here's a brief commentary on the NFS client related sections in your 2
todo lists, as well as on outstanding client issues:

Must fix:
  - The mmap-versus-truncate NFS problem appears to be a lot more
    difficult to reproduce these days. I need a call for testing to
    verify that the problem still exists.
  - I'm mystified by Andi's comments about RPC having lots of
    uninterruptible waits. It sounds to me as if he is confusing the
    "soft" and "intr" options. The two are very distinct...

Should fix:
  - The VFS support for atomic open() has already been merged by Linus
    (as well as the NFSv2/v3 support). I still have a couple of
    trivial bugfixes for the VFS case (one place where we used O_READ
    instead of FMODE_READ, and one place where the "intent" is not
    filled in at all). NFSv4 support needs for atomic open to be
    merged in (this will fix several NFSv4 file creation races).


Not listed in either:
  - There are a few lockd fixes that need to be forward-ported from
    2.4.x.

  - A *lot* of progress has been made on the NFSv4 client. I would
    very much like to merge this into 2.6.x ASAP, since it concerns
    rather critical subjects such as adding support for locking, and
    reboot recovery (as well as lots of stability fixes). What are
    your feelings on a timeframe for this sort of thing?

  - The RPCSEC_GSS support for NFSv2/v3 was merged in before it had
    been thoroughly tested and reviewed. It contains a couple of
    serious bugs that need to be ironed out.

If you want info beyond this mail, then my current set of NFS client
patches may be found on

   http://www.fys.uio.no/~trondmy/src/Linux-2.6.x/2.6.0-test11

The file HEADER.html contains a list of patches and a brief
description of what each patch does. That should give an idea of how
much is currently outstanding (I still expect the list to continue
growing - I'm still working on several NFSv4 subtopics).

Cheers,
  Trond
