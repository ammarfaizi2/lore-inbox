Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285059AbRL0AJf>; Wed, 26 Dec 2001 19:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285060AbRL0AJZ>; Wed, 26 Dec 2001 19:09:25 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:51227 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S285059AbRL0AJI>; Wed, 26 Dec 2001 19:09:08 -0500
Posted-Date: Thu, 27 Dec 2001 00:08:59 GMT
Date: Thu, 27 Dec 2001 00:08:58 +0000 (GMT)
From: Riley Williams <rhw@MemAlpha.cx>
Reply-To: Riley Williams <rhw@MemAlpha.cx>
To: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
cc: "Theodore Y. Ts'o" <tytso@MIT.Edu>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Configure.help editorial policy
In-Reply-To: <20011226233413.GA17037@msp-150.man.olsztyn.pl>
Message-ID: <Pine.LNX.4.21.0112262355110.3044-100000@Consulate.UFP.CX>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik.

>>>>> I take it this is your way of volunteering to always keep all
>>>>> kernel documentation accurate as well as answer questions from
>>>>> newbies who've never seen 'KiB' before ? ;)

>>>> One of the arguments for the KiB declaration, despite the ugliness
>>>> of "kibibytes", is that a newbie seeing "32KiB" is quite likely to
>>>> deduce what's meant from context.  Let's not exaggerate the
>>>> difficulties here.

>>> Alternatively, deal with this problem the same way the "This may
>>> also be built as a module..." comment is - either include it several
>>> thousand times in Configure.help or (better still) have the
>>> configuration tools spit it out automatically every time the need
>>> for it crops up. The following ruleset could easily be implemented
>>> even in the `make config` and `make menuconfig` parsers, and should
>>> be just as easy in CML2. Applying rule (1) will result in a
>>> considerable reduction in the size of the file
>>> Documentation/Configure.help as it currently stands.
>>>
>>> Comments, anybody?

>> I like this!

> I second this. Being a translator of the file in question, I have to
> deal with ten slightly different versions of "You may also compile
> this as a module...". So I have ten slighlty different translations
> of this text, too, in the name of accuracy.

I have to admit that I hadn't considered translators, but perhaps it
could be made even simpler for you. How about having the help file start
with a set of standard definitions, such as the following...

===8<=== CUT ===>8===

DEFINE_MODULAR
  This driver is also available as a module ( = code which can be
  inserted in and removed from the running kernel whenever you
  want). If you want to compile it as a module, say M here and
  read Documentation/modules.txt in the kernel source.

DEFINE_UNITS
  Differing standards are used for the numeric designators in the
  computing and engineering worlds. For the purposes of this document,
  the following designators are used with the stated values:

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

  This difference has arisen as a direct consequence of the fact
  that computers naturally talk in a binary (base 2) number system
  rather than the decimal (base 10) system preferred by mere mortals.

===8<=== CUT ===>8===

The rules would then reduce to "If the relevant condition applies,
append the text associated with the relevant DEFINE_ symbol to the help
text to be issued" and this could be done with an additional call to the
routine to extract the appropriate help text from the file. In addition,
your translation efforts would be restricted to just the COnfigure.help
file, and you wouldn't have to tweak the various configuration scripts
at the same time - and this would also ensure that the various config
scripts all used exactly the same help text.

> Although I thought there was an agreement that decimal kilobyte is
> kB, and binary kilobyte is KiB, decimal megabyte is MB, binary
> megabyte is MiB and so on, wasn't there?

That's the standard that the IEC has defined, and what this thread is
all about. Whether it'll get anywhere remains to be seen - ask Ted T'so
about the dangers of early adoption of proposed standards, and he'll
probably explain where his surname came from...

Best wishes from Riley.

