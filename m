Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131063AbRC0JbB>; Tue, 27 Mar 2001 04:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131152AbRC0Jav>; Tue, 27 Mar 2001 04:30:51 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31657 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S131063AbRC0Jal>;
	Tue, 27 Mar 2001 04:30:41 -0500
Date: Tue, 27 Mar 2001 11:29:20 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200103270929.LAA29224.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com
Subject: Re: Larger dev_t
Cc: alan@lxorguk.ukuu.org.uk, hpa@transmeta.com, linux-kernel@vger.kernel.org,
        tytso@MIT.EDU
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 25 Mar 2001 Andries.Brouwer@cwi.nl wrote:

Aha - after your previous explosion I had concluded that working
on *dev_t was useless, but it seems we are still talking.

>> [a large name space is useful since it allows new types of usage]

> Fine.
> You'e now forced every piece of code that needs a dev_t
> to carry along the overhead of having a 64-bit field

Let me repeat: there is no such code. In user space dev_t already is
64 bits, whether you like it or not. We cannot go back to libc5.

In kernel space we all want to use pointers to a device struct,
and major and minor are fields in that struct. There is no advantage
in making those fields narrow. And what is carried around is the
pointer, a 32-bit object.

In other words, inside the kernel the normal obvious coding will
give us ints major, minor. Outside the kernel we have a 64-bit dev_t.
And there is only the interface of system calls that uses this
narrow 16-bit straw. Of course, making it 32-bit is an improvement
but I can really not see any reason to make things difficult for
ourselves by widening this straw to 32-bits only.
Changing kernel and filesystems and glibc is a bit of a hassle -
not very difficult, but we started six years ago and still have
not finished - so it is better to do things right at once.


> It's equally true that changing "pid_t" will require that you recompile
> every single app that might have a kernel interface to the current 32-bit
> pid_t.

It was an example showing the advantage of having a 64-bit object.
Code gets simpler and faster.
But while dev_t already is 64-bits in user space, the same does not
hold for pid_t. I think that I once sent you a patch that would make
the pid use 2^31 instead of 2^15 values. Changing the size of pid_t
is not really possible, it would require a new version of the glibc
library.

	In short, both your arguments are totally bogus. Your "simpler" function
	is in fact a horrible rats nest and a source of subtle bugs that you
	apparently never even thought about.

	And that's without ever actually mentioning the word "bloat" and "data
	cache usage".

Not so pessimistic. Think and reconsider.

Andries



