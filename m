Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131742AbRC1Hvx>; Wed, 28 Mar 2001 02:51:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131750AbRC1Hvo>; Wed, 28 Mar 2001 02:51:44 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:12293 "HELO marcus.pants.nu") by vger.kernel.org with SMTP id <S131740AbRC1Hvf>; Wed, 28 Mar 2001 02:51:35 -0500
Subject: Re: 64-bit block sizes on 32-bit systems
To: lord@sgi.com (Steve Lord)
Date: Wed, 28 Mar 2001 00:09:08 -0800 (PST)
Cc: pollard@tomcat.admin.navo.hpc.mil (Jesse Pollard), jaharkes@cs.cmu.edu, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200103272356.f2RNuT101368@jen.americas.sgi.com> from "Steve Lord" at Mar 27, 2001 05:56:29 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20010328080908.9905E2B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:
> Just a brief add to the discussion, besides which I have a vested interest
> in this!

I'll add my little comments as well, and hopefully not start a flamewar... :)

[snip comments about blocksize, etc.]

Here's a real-life example of something that most of you will probably hate
me for mentioning:

HFS uses variable sized blocks (made up of multiple 512 byte sectors), but
stores block numbers as a 16 bit value. (I know, everyone will say, "We're
talking about moving from 32 to 64 bits." Keep listening.) This gave great
performance on the then current massive storage of a 20M drive. However,
when it became possible to get the absolutely gigantic hard drive of 1G,
it became more and more obvious that it was a drawback that was causing
a huge amount of wasted space. Apple had to design a new filesystem (HFS+)
that was able to represent blocks with a 32 bit number to overcome the
effective limitation on how big a filesystem could be. It's getting to
the point now that it's easily possible to put together a disk array that
is large enough that even referring to blocks with a 32 bit value requires
relatively large blocks. I don't know if we have very many filesystems that
would support this feature, but it will become important a lot sooner than
anyone may be thinking.

Obviously this case isn't a perfect fit for the situation, since HFS was
designed to be read by 32 bit machines, and the upgrade to 32 bits didn't
give a CPU penalty, just a bus bandwidth problem. Also, I'm coming from
a platform that actually can do a decent job of 64 bit, unlike x86, but
we shouldn't disallow people from doing bigger and better things. It's
become very popular lately to position Linux as an enterprise-ready system,
and this is something that will be expected. People will want to access
a multi-TB database as a single file, as well as other things that may
seem crazy to most people now.

I understand people's aversion to the #ifdefs in the code, but if the changes
are made in a sane way, it can still be clean and easy to maintain. It's
worth it to add a little complexity (particularly as an option) to add a
feature that people will be demanding in the relatively near future. It
might be a good idea to wait for 2.5, tho...

	Brad Boyer
	flar@pants.nu

P.S.: No, I have no personal reason to need any of this 64 bit filesystem
stuff. Just trying to point out possibilities. Don't expect me to actually
be writing this stuff...

