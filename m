Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKWNJs>; Thu, 23 Nov 2000 08:09:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129859AbQKWNJj>; Thu, 23 Nov 2000 08:09:39 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:39697 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129153AbQKWNJ2>;
        Thu, 23 Nov 2000 08:09:28 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011231239.eANCd1S199359@saturn.cs.uml.edu>
Subject: Re: silly [< >] and other excess
To: kaos@ocs.com.au (Keith Owens)
Date: Thu, 23 Nov 2000 07:39:00 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        rmk@arm.linux.org.uk (Russell King), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <3870.974948601@kao2.melbourne.sgi.com> from "Keith Owens" at Nov 23, 2000 02:03:21 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens writes:
> "Albert D. Cahalan" <acahalan@cs.uml.edu> wrote:

>> The hard part of klogd/ksymoops is decoding the code bytes AFAIK.
>> The rest is a just a cross between grep and ps -- you search and
>> you do symbol lookups. I could throw it together in a few hours,
>> minus the disassembly part.
>
> Take a look at the code in ksymoops oops.c before you make rash
> statements like that.  It has to handle _all_ architecture messages,
> including cross arch debugging.

I looked. I'm sure that was hard to write, but I don't agree
that it is needed. If you miss one of the zillions of kernel
data formats, then you can't properly handle the data.

Also, cross-arch debugging is done by people who don't need tools
like ksymoops anyway. Most likely they have half the opcodes
memorized already, and they have the CPU manual open on their desk.
Tools are needed so that regular users don't have to send the
whole System.map file to linux-kernel.

I threw together a semi-working prototype in a few hours.
It is the worst code I ever wrote in my life, not even
excluding stuff I wrote in Atari BASIC. It slurps down log
files pretty well though, and proves "[<>]" is unneeded.

Nasty source:
http://www.cs.uml.edu/~acahalan/linux/ogrep.tar.gz

Compile:
gcc -O2 -DOGREP -o ogrep *.c

Example usage:
ogrep -v 2.2.11 parser-god-sacrifice your-log-file

Um, yeah, you have to sacrifice an argument to the parser gods.
The built-in usage message is thus wrong. The ksyms parser is
disabled, you get some extra blank lines, and invalid symbols
print as "?" (the ps WCHAN behavior) instead of being suppressed.
Non-i386 ought to work, provided that kernel pointers are not
wider than usespace pointers. Performance needs work too.

While the code is crap, it does prove that you don't need
kernel code to put silly [<>] brackets around anything.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
