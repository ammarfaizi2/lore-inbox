Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262522AbVDGRgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbVDGRgY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 13:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVDGRgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 13:36:24 -0400
Received: from fire.osdl.org ([65.172.181.4]:24029 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262522AbVDGRgM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 13:36:12 -0400
Date: Thu, 7 Apr 2005 10:38:06 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Phillips <phillips@istop.com>
cc: Paul Mackerras <paulus@samba.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel SCM saga..
In-Reply-To: <200504071300.51907.phillips@istop.com>
Message-ID: <Pine.LNX.4.58.0504071023190.28951@ppc970.osdl.org>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <16980.55403.190197.751840@cargo.ozlabs.ibm.com>
 <Pine.LNX.4.58.0504070747580.28951@ppc970.osdl.org> <200504071300.51907.phillips@istop.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2005, Daniel Phillips wrote:
> 
> In that case, a nice refinement is to put the sequence number at the end of 
> the subject line so patch sequences don't interleave:

No. That makes it unsortable, and also much harder to pick put which part 
of the subject line is the explanation, and which part is just metadata 
for me.

So my prefernce is _overwhelmingly_ for the format that Andrew uses (which 
is partly explained by the fact that I am used to it, but also by the fact 
that I've asked for Andrew to make trivial changes to match my usage).

That canonical format is:

	Subject: [PATCH 001/123] [<area>:] <explanation>

together with the first line of the body being a

	From: Original Author <origa@email.com>

followed by an empty line and then the body of the explanation.

After the body of the explanation comes the "Signed-off-by:" lines, and 
then a simple "---" line, and below that comes the diffstat of the patch 
and then the patch itself.

That's the "canonical email format", and it's that because my normal
scripts (in BK/tools, but now I'm working on making them more generic)  
take input that way. It's very easy to sort the emails alphabetically by
subject line - pretty much any email reader will support that - since
because the sequence number is zero-padded, the numerical and alphabetic
sort is the same.

If you send several sequences, you either send a simple explaining email
before the second sequence (hey, it's not like I'm a machine - I can use
my brains too, and in particular if the final number of patches in each
sequence is different, even if the sequences got re-ordered and are
overlapping, I can still just extract one from the other by selecting for
"/123] " in the subject line), or you modify the Subject: line subtly to
still sort uniquely and alphabetically in-order, ie the subject lines for
the second series might be

	Subject: [PATCHv2 001/207] x86: fix eflags tracking
	...

All very unambiguous, and my scripts already remove everything inside the 
brackets and will just replace it with "[PATCH]" in the final version.

		Linus
