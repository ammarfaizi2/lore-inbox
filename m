Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVATTTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVATTTJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 14:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVATTSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 14:18:55 -0500
Received: from sccrmhc13.comcast.net ([204.127.202.64]:63688 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261822AbVATTRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 14:17:41 -0500
Message-ID: <41F003E7.60904@comcast.net>
Date: Thu, 20 Jan 2005 14:17:59 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
References: <Pine.LNX.4.58.0501122025140.2310@ppc970.osdl.org>	 <20050113082320.GB18685@infradead.org>	 <Pine.LNX.4.58.0501130822280.2310@ppc970.osdl.org>	 <1105635662.6031.35.camel@laptopd505.fenrus.org>	 <Pine.LNX.4.58.0501130909270.2310@ppc970.osdl.org>	 <41E6BE6B.6050400@comcast.net> <20050119103020.GA4417@elte.hu>	 <41EE96E7.3000004@comcast.net> <20050119174709.GA19520@elte.hu>	 <41EEA86D.7020108@comcast.net> <20050120104451.GE12665@elte.hu>	 <41EFF581.6050108@comcast.net> <1106247305.6742.87.camel@laptopd505.fenrus.org>
In-Reply-To: <1106247305.6742.87.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1



Arjan van de Ven wrote:
> On Thu, 2005-01-20 at 13:16 -0500, John Richard Moser wrote:
> 
>>Even when the tagging is all automatic, to really deploy a competantly
>>formed system you have to review the results of the automated tagging.
>>It's a bit easier in most cases to automate-and-review, but it still has
>>to be done.  I think in the case of PaX markings, the maintenance
>>overhead of manually marking binaries is minimal enough that looking for
>>mistakes would be more work than working from an already known and
>>familiar base.
> 
> 
> 
> well, marking with PT_GNU_STACK is similar, execstack tool (part of the
> prelink package) both shows and can change the existing marking of
> binaries/libs.
> 
> How is that much different to what pax provides?
> 
> 

The point was more that it's easier to avoid embarasments like "What?
Plug-ins are marked PT_GNU_STACK, but don't need it?  Firefox is a high
risk application and we're giving it an executable stack needlessly?!
SOMEBODY TOLD WIRED THIS?!  *IT'S ON SLASHDOT?!!?!!?*" when you do ALL
of the marking manually, so that you know who has what.

The reason for this is that rather than check every marking on every
program (and library in the ES case), you just run each program.  You do
run each program right?  Or is your distribution's QA shit?  I'd hope
you test each program carefully to make sure it actually works.  So this
should be normal anyway.  When you run into an ES or PaX problem, you
know to track it down and mark it.  No accidental mismarking setting
things less secure than they have to be.

I usually encourage deploying a new security system like SSP, PaX, or
the use of PIE binaries across everything on the development boxes, and
then cleaning up the breakage.  The reason for this is that you
quickly--without having to second-guess an automatic marking system or
specifically examine each program in testing separated from your normal
QA--locate ALL breakage in your normal QA testing routine AND come out
with the tightest security settings possible.  (On the same note, never
ever make a release with protections you haven't actually tested.)

> 
> 
> 

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB8APmhDd4aOud5P8RAgQmAJ9f/Li0fj1+w1RH2bpCmIurZWidBACfbpvN
ITRMox6SIRt1qLsRP3ykUF0=
=Q22O
-----END PGP SIGNATURE-----
