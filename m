Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276248AbRJDQBv>; Thu, 4 Oct 2001 12:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276623AbRJDQBn>; Thu, 4 Oct 2001 12:01:43 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:57730 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S276248AbRJDQBg>; Thu, 4 Oct 2001 12:01:36 -0400
Date: Thu, 4 Oct 2001 10:02:00 -0600
Message-Id: <200110041602.f94G20k06280@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com>
In-Reply-To: <m1n137zbyo.fsf@frodo.biederman.org>
	<Pine.LNX.4.33.0110040842320.8350-100000@penguin.transmeta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds writes:
> 
> On 4 Oct 2001, Eric W. Biederman wrote:
> >
> > First what user space really wants is the MAP_COPY.  Which is
> > MAP_PRIVATE with the guarantee that they don't see anyone else's changes.
> 
> Which is a completely idiotic idea, and which is only just another
> example of how absolutely and stunningly _stupid_ Hurd is.

Indeed. If you're updated a shared library, why not *create a new
file* and then rename it?!? That lets running programmes work fine,
and new programmes will get the new library. Also, the following
construct makes a lot of sense:
	ld -shared -o libfred.so *.o || mv libfred.so /usr/local/lib

Why? Because if ld(1) fails for some reason, and ends up writing a
short file, *you don't want to install the bloody thing*!!! Any new
user would be stuffed (no way around that, even with MAP_COPY).
I don't want to install/upgrade to a half-working library. What's the
point in that?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
