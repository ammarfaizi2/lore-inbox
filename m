Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129228AbQKYK4w>; Sat, 25 Nov 2000 05:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129295AbQKYK4c>; Sat, 25 Nov 2000 05:56:32 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:61700 "EHLO saturn.cs.uml.edu")
        by vger.kernel.org with ESMTP id <S129228AbQKYK4Y>;
        Sat, 25 Nov 2000 05:56:24 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200011251026.eAPAQKG210983@saturn.cs.uml.edu>
Subject: Re: silly [< >] and other excess
To: rmk@arm.linux.org.uk (Russell King)
Date: Sat, 25 Nov 2000 05:26:20 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan), Andries.Brouwer@cwi.nl,
        linux-kernel@vger.kernel.org
In-Reply-To: <200011250917.eAP9HGK18904@flint.arm.linux.org.uk> from "Russell King" at Nov 25, 2000 09:17:16 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:
> Albert D. Cahalan writes:

>> Symbols:
>> c000000a __start
>> c0105344 qfs_frob_directory
>> c01a4600 qfs_cleaner
>> c01a4b98 qfs_hash_file_record
...
>> Well, that first symbol (__start) was really "jump +10", but the
>> extra noise doesn't hurt anyone. You get what you need, no matter
>> how mangled the oops is. It can be word-wrapped, missing chunks...
>> The tool doesn't need to care.
>
> However, now rather than just reading the dump as you can with
> ksymoops or whatever, you have to look at the raw data and try
> to match it up with a symbol in the list.

Yes. Don't you look at the raw data anyway?

Um, maybe you just don't work the way I do. In response to one
of your other messages, most of the time I have two PowerPC books
open on my desk. I hadn't thought that was so odd.

If you are going to rely on a tool, you might as well add some
error correction bits to the oops, base-32 encode it, and chop
it up into 5-character words for ease of paper-and-pencil copy.

> So, with that ARM dump I gave you, we'd potentially end up with
> about 100 lines of symbols, where about 90 of them are useless.

In theory yes, but in practice no. Your kernel isn't a significant
portion of your address space, so the chance of random data being
looked up successfully is very low. Maybe a 1% chance on 32-bit
hardware, and far less on 64-bit hardware.

>  That would be a backwards step in the development of Linux IMHO.
> 
> PS, you're not going to convince me unless you can come up with something
> that produces ksymoops-like output, so there's no point continuing.

Damn.

Somebody else posted a reasonable hack for the [<>] problem.
His proposal involved letting multiple values share the same
markers, something like this:

[<c19a5cb4 c180234c c1801134 c1706550 c1800248 c1603310 c1934878 c1840324>]
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
