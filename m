Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292238AbSBBJAD>; Sat, 2 Feb 2002 04:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292253AbSBBI7y>; Sat, 2 Feb 2002 03:59:54 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:42250 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S292238AbSBBI7l>;
	Sat, 2 Feb 2002 03:59:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Chris Wedgwood <cw@f00f.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
In-Reply-To: Your message of "Sat, 02 Feb 2002 08:40:11 -0000."
             <23050.1012639211@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Feb 2002 19:59:28 +1100
Message-ID: <26967.1012640368@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Feb 2002 08:40:11 +0000, 
David Woodhouse <dwmw2@infradead.org> wrote:
>kaos@ocs.com.au said:
>>  There is also a problem with exported symbols.  To ld, EXPORT_SYMBOL
>> looks like a reference to the symbol, 
>
>Er, surely that's not a problem at all? This is desired behaviour?
>
>>  but the export entry is irrelevant,  what really matters is if any module
>> refers to those symbols.
>
>Absolutely not.  If we mark a symbol EXPORT_SYMBOL, we want it exported. No 
>questions asked.

Does anything still use this symbol or is it dead?  Quite valid question.

>The export entry _is_ relevant; furthermore it's the _only_ thing that's
>relevant, and there is no way of knowing if there's a module that isn't in
>the tree, or maybe even a module that _is_ in the tree but not compiled
>today, that needs the symbol in question.

I said that you get false positives because the code that uses the
symbol might not be compiled in your kernel.  The script flags symbols
that are extern or exported and are not used in the current kernel.
Somebody then has to go through the report and decide if those symbols
are required under other config settings or by third party modules,
assuming that they care about third party modules.

The script is NOT an automatic list of what can be cleaned up.  I doubt
that such a list can be generated in the face of the kernel config
system and third party modules.  It is only a starting point for
symbols that need reviewing.

