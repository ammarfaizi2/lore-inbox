Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284755AbRLZSLE>; Wed, 26 Dec 2001 13:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284736AbRLZSKz>; Wed, 26 Dec 2001 13:10:55 -0500
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:34685 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S284731AbRLZSKj>; Wed, 26 Dec 2001 13:10:39 -0500
Posted-Date: Wed, 26 Dec 2001 17:44:37 GMT
Date: Wed, 26 Dec 2001 17:44:36 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: Rik van Riel <riel@conectiva.com.br>, Cameron Simpson <cs@zip.com.au>,
        David Garfield <garfield@irving.iisd.sra.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <20011223174608.A25335@thyrsus.com>
Message-ID: <Pine.LNX.4.21.0112261718150.32161-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric, Rik.

>> I take it this is your way of volunteering to always keep all
>> kernel documentation accurate as well as answer questions from
>> newbies who've never seen 'KiB' before ? ;)

> One of the arguments for the KiB declaration, despite the ugliness
> of "kibibytes", is that a newbie seeing "32KiB" is quite likely to
> deduce what's meant from context.  Let's not exaggerate the
> difficulties here.

Alternatively, deal with this problem the same way the "This may also be
built as a module..." comment is - either include it several thousand
times in Configure.help or (better still) have the configuration tools
spit it out automatically every time the need for it crops up. The
following ruleset could easily be implemented even in the `make config`
and `make menuconfig` parsers, and should be just as easy in CML2.
Applying rule (1) will result in a considerable reduction in the size of
the file Documentation/Configure.help as it currently stands.

Comments, anybody?

Best wishes from Riley.

===============8<=============== CUT ===============>8===============

RULE 1: If a particular symbol is defined using a command that
	allows it to be selected as "Modular", then tack the
	following to the end of the help description for that
	symbol when a user requests help:

		This driver is also available as a module( = code
		which can be inserted in and removed from the
		running kernel whenever you want). If you want to
		compile it as a module, say M here and read
		Documentation/modules.txt in the kernel source.

RULE 2: If the help text for a particular symbol includes a word
	matching either of the egrep patterns '[KkMmGgTt][Bb]' or
	'[KkMmGgTt]i[Bb]' then tack the following to the end of
	the help description for that symbol when a user requests
	help:

		Differing standards are used for the numeric
		designators in the computing and engineering
		worlds. For the purposes of this document, the
		following designators are used with the stated
		values:

			Symbol	Designation	  Number of Bytes
			~~~~~~	~~~~~~~~~~~~~~~~  ~~~~~~~~~~~~~~~~~
			KiB	Decimal Kilobyte  1,000
			KB	Binary Kilobyte   1,024

			MiB	Decimal Megabyte  1,000,000
			MB	Binary Megabyte   1,048,576

			GiB	Decimal Gigabyte  1,000,000,000
			GB	Binary Gigabyte   1,073,741,824

			TiB	Decimal Terabyte  1,000,000,000,000
			TB	Binary Terabyte   1,099,511,627,776

		This difference has arisen as a direct consequence of
		the fact that computers naturally talk in a binary
		(base 2) number system rather than the decimal (base
		10) system preferred by mere mortals.

RULE 3: If more than one of the above rules apply, all configuration
	systems shall agree on a common order in which to apply them.

