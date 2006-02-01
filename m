Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWBAEGM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWBAEGM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 23:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWBAEGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 23:06:12 -0500
Received: from xproxy.gmail.com ([66.249.82.193]:52284 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964902AbWBAEGK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 23:06:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=D8tywxsL9QE+FX9lYKE6zXQxZVStR91aYk+VOeR/9/5A9j3+9vf8bc0oxutHRCkzNKjwRjXam6MKc1SI6OyHAKE529bIaDA78r0P9quAwWE+q+zlliq4Ylll3nyBlI5PoKCej0ITQydryK5cP66HE21ZKFBi4VReYe4SNMVSO+s=
Message-ID: <986ed62e0601312006y75748bd9x8925556e979d59c9@mail.gmail.com>
Date: Tue, 31 Jan 2006 20:06:10 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [RFC] VM: I have a dream...
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Bryan Henderson <hbryan@us.ibm.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <200601311856.17569.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <OFA0FDB57C.2E4B1B4D-ON88257103.00688AE2-88257103.0069EF1C@us.ibm.com>
	 <200601301621.24051.a1426z@gawab.com>
	 <8F530CA8-1AC8-4AE5-8F1E-DC6518BD7D42@mac.com>
	 <200601311856.17569.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Al Boldi <a1426z@gawab.com> wrote:
> Faulty, because we are currently running a legacy solution to workaround an
> 8,16,(32) arch bits address space limitation, which does not exist in
> 64bits+ archs for most purposes.

In the early 1990's (and maybe even the mid 90's), the typical hard
disk's storage could theoretically be byte-addressed using 32-bit
addresses -- just as (if I understand you correctly) you are arguing
that today's hard disks can be byte-addressed using 64-bit addresses.

If this was going to be practical ever (on commodity hardware anyway),
I would have expected someone to try it on a 32-bit PC or Mac when
hard drives were in the 100MB-3GB range... That suggests to me that
there's a more fundamental reason (i.e. other than lack of address
space) that caused people to stick with the current scheme.

[snip]
> There is a lot to gain, for one there is no more swapping w/ all its related
> side-effects.  You're dealing with memory only.  You can also run your fs
> inside memory, like tmpfs, which is definitely faster.  And there may be
> lots of other advantages, due to the simplified architecture applied.

tmpfs isn't "definitely faster". Remember those benchmarks where Linux
ext2 beat Solaris tmpfs?
http://www.tux.org/lkml/#s9-12

Also, the only way I see where "there is no more swapping" and
"[y]ou're dealing with memory only" is if the disk *becomes* main
memory, and main memory becomes an L3 (or L4) cache for the CPU [and
as a consequence, main memory also becomes the main form of long-term
storage]. Is that what you're proposing?

If so, then it actually makes *less* sense to me than before -- with
your scheme, you've reduced the speed of main memory by 100x or more,
then you try to compensate with a huge cache. IOW, you've reduced the
speed of *main* memory to (more or less) the speed of today's swap!
Suddenly it doesn't sound so good anymore...

--
-Barry K. Nathan <barryn@pobox.com>
