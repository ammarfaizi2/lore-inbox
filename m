Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131513AbRC0TxA>; Tue, 27 Mar 2001 14:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131521AbRC0Twu>; Tue, 27 Mar 2001 14:52:50 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:20239 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131513AbRC0Twh>; Tue, 27 Mar 2001 14:52:37 -0500
Date: Tue, 27 Mar 2001 11:51:02 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: <Andries.Brouwer@cwi.nl>, <alan@lxorguk.ukuu.org.uk>,
        <linux-kernel@vger.kernel.org>, <tytso@MIT.EDU>
Subject: Re: Larger dev_t
In-Reply-To: <3AC0E9ED.3324F697@transmeta.com>
Message-ID: <Pine.LNX.4.31.0103271139530.24860-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Mar 2001, H. Peter Anvin wrote:
>
> Part of the reason we haven't -- quite -- run out of 8-bit majors yet is
> because I have been an absolute *bastard* with registrants lately.  It
> would cut down on my workload if I could assign majors without worrying
> too much about whether or not that particular driver is really going to
> be made public.

No.

The real problem, in my opinion, is needing device numbers in the first
place, for stuff that really shouldn't use them.

I don't want to make allocation easy. In fact, I want to make it _harder_.
I like it being painful, because it should not be done.

I've seen _way_ too many instances of "let's create a special device" for
no good reason. For example, all the crap about mice was (and is) a
mistake. And that's the least of the problems. Some devices on the device
list are there mainly as just a way to hook in an ioctl or something. It's
sad, and it's wrong.

And I'm sorry, but I do NOT want to envision a future where you can say
"ok, majors in the range 512-576 are PPC-specific, and you can go wild".
Yes, it would make your job easier. But it would make for a BAD SYSTEM,
which is what _I_ care about.

We should encourage people to not need major numbers. It's easy. The
driver exports a /proc entry in /proc/driver/xxx or similar . Or the
driver writer says "if you want to use this device, use devfs", and
exports the name there.

Don't get the issue of "it would make my life easier" override the issue
of "it's the wrong thing to do".

Another example: all the stupid pseudo-SCSI drivers that got their own
major numbers, and wanted their very own names in /dev. They are BAD for
the user. Install-scripts etc used to be able to just test /dev/hd[a-d]
and /dev/sd[0-x] and they'd get all the disks. Deficiencies in the SCSI
layer made it impossible for a driver writer to be nice to the user, so
instead they got their own major numbers.

But again, you're arguing for _more_ badness. While I'm of the opinion
that we _already_ have too many major numbers, and we should realize that,
and not make it worse.

A 64-bit dev_t only makes it _easier_ to continue to be stupid about
things.

And that, btw, is the hallmark of "bloat". Bloat is not about being big.
Bloat is about being slow and stupid and not realizing that it's because
of design mistakes.

		Linus

