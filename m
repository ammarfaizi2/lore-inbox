Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129872AbQKYW4B>; Sat, 25 Nov 2000 17:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129538AbQKYWzv>; Sat, 25 Nov 2000 17:55:51 -0500
Received: from 213-123-73-152.btconnect.com ([213.123.73.152]:25348 "EHLO
        penguin.homenet") by vger.kernel.org with ESMTP id <S129518AbQKYWzo>;
        Sat, 25 Nov 2000 17:55:44 -0500
Date: Sat, 25 Nov 2000 22:27:15 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Andries Brouwer <aeb@veritas.com>
cc: rmk@arm.linux.org.uk, rusty@linuxcare.com.au, linux-kernel@vger.kernel.org,
        Andries.Brouwer@cwi.nl
Subject: Re: [PATCH] removal of "static foo = 0"
In-Reply-To: <20001125211939.A6883@veritas.com>
Message-ID: <Pine.LNX.4.21.0011252205500.768-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andries,

On Sat, 25 Nov 2000, Andries Brouwer wrote:
> What a strange reaction. If I write
> 
>  static int foo;
> 
> this means that foo is a variable, local to the present compilation unit,
> whose initial value is irrelevant because it will be assigned to before use.
> If I write
> 
>  static int foo = 0;
> 
> this means that the code depends on the initialization.
> Indeed, it is customary to write
> 
>  int foo = 0;  /* just for gcc */
> 
> when the initialization in fact is not necessary.

What I am suggesting (in fact, not me but common sense) is that if you
write:

static int foo;

then you really mean "a variable is foo and since it is required to be
initialized to zero, I am quite free to _rely_ on this fact and will
possibly do so". It is true that information about whether you actually
rely on it or not is lost but surely such "loss" is worth being able to
run Linux rather than non-Linux (i.e. in the cases where it is a matter of
a "few bytes" that decides whether you _can_ run Linux or not at all, i.e.
presumably some small devices where you have to squeeze Linux with a given
set of drivers into finite room).

> Saving a byte in the binary image is not very interesting. Preserving
> information about the program is important.

Saving a single byte may not be. Some studies have shown that the total is
in the range of a megabyte, that is first. The second is -- developing the
optimal set of mind (namely that described above around "static int foo;"
) is very interesting as it ensures that Linux remains optimal even as it
and the number of people working on it grows astronomically. You must have
seen the source code of various commercial flavours of UNIX and therefore
understand why they are such a failure -- there is no one like Linus
Torvalds behind them which has so much patience that he gratefully accepts
all improvements, however small they may seem. I hope that Linux will
remain the cleanest system wrt attention to detail. Yes, I understand that
it requires absolutely _impossible_ amount of patience on the part of
Linus Torvalds, but that is indeed what he does -- the impossible and may
God bless him and keep him.

> 
> I see that this message is cc'ed to Tigran, so let me address him as well.
> Tigran, you like to destabilize Linux. I like to stabilize Linux.
> 

Oh, Andries, that is insulting. Surely you do not really mean that. So, I
_will_ read the rest of your message. :)

> If it is your intention to destabilize then you need not read the following.
> But let us assume that you try to make a perfect system.
> 
> There is the issue of local and global correctness.
> A piece of code is locally correct when its correctness can be seen
> by just looking at those lines, or that function, or that source file.
> A piece of code is globally correct when you need to read the entire kernel
> source to convince yourself that all is well.
> 
> Often local correctness is obtained by local tests. After reading the entire
> kernel source you conclude that these tests are superfluous because they
> are satisfied in all cases. And you think it is an improvement to remove
> the test. It almost never is. On a fast path, where every cycle counts, yes.
> But it is not a good idea to sacrifice local correctness and save five
> kernel image bytes, or speed up the mount system call by 0.001%.
> Why not? Because you read the entire kernel source of today.
> But not that of next week. Somewhere someone changes some code.
> The test is gone and the kernel crashes instead of returning an error.

your theory is very good, in theory, but is not so in practice. Namely, if
you cared to look in depth at the specific instances of the optimizations
I suggested which required what you call "global correctness checks" (I
like that terminology!) then you would either have found out that either:

a) I have done enough investigations to show that such tests can not only
be removed now but nothing in the future should ever require them to be
added.

or

b) I have made a mistake, in which case, I would be happy to see you
correcting me. Failure to do so indicates that I was right.

in both cases, I did not intentionally sacrifice "local correctness" as
you are trying to present. I think I value local correctness as much as
you do.

> You even like to destabilize when there is no gain in size or speed at all.
> It is bad coding practice to use casts. They tell the compiler not to check.
> With functions returning (void *) the opposite is true. The compiler cannot
> check now, but given a cast, it can. Thus, I wrote a few months ago
> 
> > If one just writes
> >       foo = kmalloc(n * sizeof(some_type), GFP_x);
> > then neither the compiler nor the human eye can check
> > easily that things are right, i.e. that foo really is
> > a (some_type *). Therefore it is better to write
> >       foo = (some_type *) kmalloc(n * sizeof(some_type), GFP_x);
> 
> To my surprise you answered
> 
> : It is a small thing, Andries, but I still think otherwise than you.
> : It is better for code to be smaller than to be slightly more fool-proof.

Again, in theory you sound quite right. In practice, the specific cases
where I proposed removing such typecasts were immediately preceeded by the
declarations of the corresponding variables. I.e. it was _immediately_
obvious as to what type they are and those long casts were only making
code bigger, nothing else. You will certainly find quite a large number of
places where those casts are still there -- this is not because I haven't
seen them but because I didn't think worth changing (probably for the very
reason you kindly explained to me, for this I thank you!)

> 
> Please change your mind.
> 
> Andries

I have changed my mind about one thing -- there is a common sense or
"sense of measure" about what should and what should not be cc'd to
linux-kernel and I certainly was neglecting such "sense of measure" if I
allowed a mail like yours to come into existence. Nevertheless, it is
gratefully noted and will be acted upon accordingly.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
