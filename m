Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266198AbUGJJcP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266198AbUGJJcP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 05:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266147AbUGJJcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 05:32:15 -0400
Received: from CPE-203-51-26-230.nsw.bigpond.net.au ([203.51.26.230]:60923
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S266198AbUGJJbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 05:31:40 -0400
Message-ID: <40EFB775.8020408@eyal.emu.id.au>
Date: Sat, 10 Jul 2004 19:31:33 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
References: <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au>	<Pine.LNX.4.58.0407072214590.1764@ppc970.osdl.org> <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1fz80c406.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Executive summary:
	It is not about the law (ANSI). It is about best practices
	that improve code quality. And transparency in the
	programmer's expression should always be welcome.

This thread can easily degrade into a religious argument
(an oxymoron, can't argue about religion so just don't do
it). I hope the below addresses the issues raised here
and gives reason for my opinions.

Eric W. Biederman wrote:
> Does this mean constructs like:
> ``if (pointer)'' and ``if (!pointer)'' are also outlawed.

Very much yes. I will go further and say that only boolean
variables should use the above syntax. Using
	if (i)
where 'i' is a non-boolean integer instead of
	if (0 != i)
makes me question what the programmer wanted. Since integers
do not have clear names for true/false logic (booleans usually
will be called something like 'have_brain" etc.) the simple
'if (i)' may just as well be a miswritten 'if (!i)' - and I
caught a few of these bugs in my time.

The whole point is not about "does the blind law of ANSI accepts
this" because ANSI is written to be as permissible as possible
so as not to invalidate deprecated bad style.

The whole point is about writing code that has a clear meaning, and
using different forms for a zero integer and a generic empty pointer
is a good way to force the writer to think and do the right thing.

Fact is that some code I can read as I see the snippet and without
having to resort to too much header checking etc, while other code
is a pain to go through (and don't even start me on consistent
indentation).

And just to be clear. ANSI says this is valid
	char 	*p;
	int	i;
	...
	i[p] = 1;
Do you encourage this too? See what I mean? OK, so we all read
the reference to the obfuscation competition...

> And do we then need to initialize static pointers to NULL instead
> of letting them be implicitly 0.

I surely insist on this. Implicit is just not good enough to show
that you gave it enough thought.

> Is doing memset(&(struct with_embeded_pointers), 0, sizeof(struct))
> also wrong?

You probably think that 'calloc' is enough for initializing an
object. I fixed enough problems from this. You declare a struct
- write a struct_clear function right away. It is worth it's
wordcount in gold.

> I don't see that 0 is WRONG.  I do agree that ``((void *)0)'' is
> slightly more typesafe than ``0'', but since we don't have a lot of
> (void *) pointers in the kernel that is still the WRONG pointer type.
> 
> I do see that NULL has superior readability and maintainability and so
> should be encouraged by Documentation/CodingStyle.
> 
> The B and K&R roots of a simple single type language are what give C
> most of it's simplicity flexibility and power.  Please don't be so
> eager to throw those out.

Yes, it was simple and flexible. It was a damn great improvement
over assembly. However, by now it is clear that stronger typing
is a good thing. Kernel code, where bugs have a high cost, is a good
place to apply stricter rules than usual.

> You want to be so typesafe it sounds like you want to recode the
> kernel in Pascal.  You've written sparse, so it should be just a little
> more work to write a Pascal backend.  After that the kernel will be so
> typesafe the compiler won't let us poor programmers get it wrong.

Did we forget the smiley?

--
Eyal Lebedinsky		(eyal@eyal.emu.id.au)
