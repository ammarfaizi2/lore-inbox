Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311731AbSCTHuD>; Wed, 20 Mar 2002 02:50:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311733AbSCTHty>; Wed, 20 Mar 2002 02:49:54 -0500
Received: from naxos.pdb.sbs.de ([192.109.3.5]:23484 "EHLO naxos.pdb.sbs.de")
	by vger.kernel.org with ESMTP id <S311731AbSCTHtj>;
	Wed, 20 Mar 2002 02:49:39 -0500
Date: Wed, 20 Mar 2002 08:52:06 +0100 (CET)
From: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
To: Pavel Machek <pavel@suse.cz>
cc: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>,
        "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Ingo Molnar <mingo@elte.hu>,
        Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Severe IRQ problems on Foster (P4 Xeon) system
In-Reply-To: <20020319232836.GB1758@elf.ucw.cz>
Message-ID: <Pine.LNX.4.33.0203200844000.9609-100000@biker.pdb.fsc.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Pavel Machek wrote:

> > This would get us rid of our problem (although the BIOS hack may
> > suffice). However, more than that, it also spares ~2 us on each timer
> > interrupt for CPUs which do not need do_slow_gettimeoffset.
> >
> > What do you think?
>
> Well, you should get your bios fixed.

Whatever's wrong with our BIOS is not the focus of the patch.
There are two sides to this, and the Linux side is that the
IO-operations to port 20 are completely superfluous on modern CPUs.

> Then... Those ifdefs are not neccessary, right? You only need ...
[ snip ]
> ... these lines.

There is no point in keeping the timer_ack variable in the kernel's
symbol table if it's compiled for CPUS with TSC only, and no need
to test it in every timer interrupt if we know it's going to be 0
anyway.

Please note that do_slow_timeoffset is completely #ifdef'ed out in
time.c for CPUs with TSC.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





