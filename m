Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315277AbSE2NrB>; Wed, 29 May 2002 09:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315276AbSE2NrA>; Wed, 29 May 2002 09:47:00 -0400
Received: from buffy.commerce.uk.net ([213.219.35.201]:24770 "EHLO
	buffy.commerce.uk.net") by vger.kernel.org with ESMTP
	id <S315267AbSE2Nq7>; Wed, 29 May 2002 09:46:59 -0400
Date: Wed, 29 May 2002 14:46:51 +0100 (BST)
From: Corin Hartland-Swann <cdhs@commerce.uk.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Dave Jones <davej@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bluesmoke, machine check exception, reboot
In-Reply-To: <Pine.LNX.4.33L2.0205280810240.1840-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33L2.0205291414210.19118-100000@buffy.commerce.uk.net>
Organization: Commerce Internet Ltd
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Randy/Dave,

On Tue, 28 May 2002, Randy.Dunlap wrote:
> On Tue, 28 May 2002, Corin Hartland-Swann wrote:
> | On 28 May 2002, Alan Cox wrote:
> | > On Tue, 2002-05-28 at 13:19, Corin Hartland-Swann wrote:
> | > > I have a Dual PIII-1000 running 2.4.18, and am occasionally getting the
> | > > following error:
> | > >
> | > > > CPU 1: Machine Check Exception: 0000000000000004
> | > > > Bank 1: f200000000000115
> | > > > Kernel panic: CPU context corrupt
> |
> | I just found another set of messages in the logs as well:
> |
> | CPU 1: Machine Check Exception: 0000000000000004
> | Bank 1: b200000000000115
> | Kernel panic: CPU context corrupt
> |
> | > > This results in a hard lock (unable to use magic SysRQ key to sync or
> | > > reboot, etc). I located these errors in arch/i386/kernel/bluesmoke.c in
> | > > the function intel_machine_check(). From what I have read on lkml it is
> | > > probably a result of the processor overheating and causing errors.
> | >
> | > It may even be a faulty processor. If you are running the processor to
> | > spec and your heatsink/fan/voltage all check out you may want to see
> | > about getting the CPU replaced. Thats a data cache l1 read error it
> | > appears
> |
> | How do you work out what the numbers mean? Is there some kind of reference
> | to it, or are you just Alan "decodes machine check exceptions in his head"
> | Cox :) From the code it seems to be some kind of MCG status and MC0 status
> | - but of course, I have no idea what that means...
>
> Appendix E of
> "IA-32 Intel Architecture Software Developer's Manual
> Volume 3 : System Programming Guide" is
> "INTERPRETING MACHINE-CHECK ERROR CODES".
> You can download it from developer.intel.com website.
>
> Dave Jones has also begun a program called "parsemce".
> You can get it at
> http://www.codemonkey.org.uk/cruft/parsemce.c and
> compile/run it.

I ran it through parsemce as suggested (thanks Randy), and got the
following output:

Status: (4) Machine Check in progress.
Restart IP invalid.
parsebank(4): b200000000040151 @ 0
	External tag parity error
	Uncorrectable ECC error
	Correctable ECC error
	Address in addr register valid
	MISC register information valid
	Error overflow
	Memory heirarchy error
	Request: Generic error
	Transaction type : Instruction
	Memory/IO : Reserved

A question for Dave mainly - is this output valid considering that I am
running stock 2.4.18 (I hadn't applied the patch you've done to fix typos
in this - and now I've lost the damn thing).

Does this output give any more information about possible causes?

Also http://marc.theaimsgroup.com/?l=linux-kernel&m=101338603328639&w=2
mentions a tool decodemca - is that a previous name for parsemce?

Thanks again,

Corin

/------------------------+-------------------------------------\
| Corin Hartland-Swann   |    Tel: +44 (0) 20 7491 2000        |
| Commerce Internet Ltd  |    Fax: +44 (0) 20 7491 2010        |
| 22 Cavendish Buildings | Mobile: +44 (0) 79 5854 0027        |
| Gilbert Street         |                                     |
| Mayfair                |    Web: http://www.commerce.uk.net/ |
| London W1K 5HJ         | E-Mail: cdhs@commerce.uk.net        |
\------------------------+-------------------------------------/

