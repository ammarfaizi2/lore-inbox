Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312334AbSDCTGE>; Wed, 3 Apr 2002 14:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312332AbSDCTFz>; Wed, 3 Apr 2002 14:05:55 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:22303 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S312331AbSDCTFr>;
	Wed, 3 Apr 2002 14:05:47 -0500
Date: Wed, 3 Apr 2002 20:03:52 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
        Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <E16soms-0004Au-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204031947210.1163-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Alan Cox wrote:
> >  EXPORT_SYMBOL(vfree);
> >  EXPORT_SYMBOL(__vmalloc);
> > -EXPORT_SYMBOL_GPL(vmalloc_to_page);
> > +EXPORT_SYMBOL(vmalloc_to_page);
>
> The authors of that code made it GPL. You have no right to change that. Its
> exactly the same as someone taking all your code and making it binary only.

Dear Alan,

You know how much I respect you and your words so I don't need to write
long a apologetic introduction if I wish to correct your statement.

Namely, you are saying that Andrea changed some code from being GPL to
non-GPL. That is so obviously not true that I am even surprized that I
need to point this out explicitly (especially to you; as Jesus said to
Nicodemus, are you a teacher in Israel and knowest not these things?)

The line of code:

EXPORT_SYMBOL(vmalloc_to_page);

is just as much under GPL license as the line of code:

EXPORT_SYMBOL_GPL(vmalloc_to_page);

So, Andrea's patch is not changing any license of any line of Linux kernel
code. He is just correcting a _technical_ mistake. Authors are allowed to
make mistakes and others are allowed to fix them. I don't see any problem
with that (even the wicked US legal system won't jail anyone for it :)

Therefore your comparison to "taking all your code and make it binary
only" is not valid.

Now, of course, I understand that the above is trivial and do not pretend
to assume that you don't know this. Therefore, let's look a little bit
deeper, to understand your assumptions. In order for your statement to be
valid technically, you have to assume that some parts of Linux kernel are
under GPL and others are not, i.e. some entry points (allowed for modules)
differ from other entry points wrt to license. That would be a badly
broken design and I appeal to yours and Linus' common sense about it. What
I understood the intention of EXPORT_SYMBOL_GPL was (from your email
mentioning the internal helpers etc) is that it is for internal helper
functions used by some parts of the kernel which happen to be
modularizable, but not for general consumption of 3rd party modules.  So,
really, the name EXPORT_SYMBOL_GPL is a _misnomer_.

Let us therefore rename it to EXPORT_SYMBOL_INTERNAL and that would solve
all confusion and also prevent people who wish to make technically-wrong
decisions based on their personal dislike of binary-only modules (Arjan,
with all respect and sympathy to you, that is you).

I cc'd Linus because I do believe the above to be honest and correct. If I
am wrong, please say what is wrong.

Just my 2 pence.

Regards,
Tigran


