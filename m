Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTC0X7v>; Thu, 27 Mar 2003 18:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261736AbTC0X7v>; Thu, 27 Mar 2003 18:59:51 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:44778 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261732AbTC0X7u>; Thu, 27 Mar 2003 18:59:50 -0500
Date: Fri, 28 Mar 2003 00:10:15 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Larry McVoy <lm@work.bitmover.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: ECC error in 2.5.64 + some patches
Message-ID: <20030328001015.GA19146@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Larry McVoy <lm@work.bitmover.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <20030324212813.GA6310@osiris.silug.org> <20030324180107.A14746@vger.timpanogas.org> <20030324234410.GB10520@work.bitmover.com> <20030324182508.A15039@vger.timpanogas.org> <20030327160220.GA29195@work.bitmover.com> <20030327082212.252159e0.rddunlap@osdl.org> <20030327163120.GC29195@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327163120.GC29195@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 08:31:20AM -0800, Larry McVoy wrote:
 > > | Message from syslogd@slovax at Thu Mar 27 05:53:49 2003 ...
 > > | slovax kernel: Bank 1: 9000000000000151
 > > You can try the Dave Jones "parsemce" tool on it, from
 > >   http://www.codemonkey.org.uk/cruft/parsemce.c/
 > 
 > slovax /tmp a.out -b 1 -e 9000000000000151
 > Status: (-8070450532247928495) Restart IP valid.
 > 
 > What does that mean?

It means Dave sucks and hasn't done a good enough job on the parser.
parsemce is really really unintuitive to use.

There's some bits missing from your dump. Usually, MCEs look like..

 Sep  4 21:43:41 hamlet kernel: CPU 0: Machine Check Exception: 0000000000000004
 Sep  4 21:43:41 hamlet kernel: Bank 1: f600200000000152 at 7600200000000152

All we have to go on in your example is the bank status code.
(which is -s, not -e. -e would be the 00000000000000004 in the example above. [*])

So, without the missing bits, we have to fake it..

(davej@deviant:davej)$ ./a.out -b 1 -e 1 -s 9000000000000151 -a 0
Status: (1) Restart IP valid.
parsebank(1): 9000000000000151 @ 0
	External tag parity error
	Error enabled in control register
	Memory heirarchy error
	Request: Generic error
	Transaction type : Instruction
	Memory/IO : Reserved

Ignore the Status: line, thats decoded from the (faked) -e 1.

Any the wiser ? 8-)  [*]

		Dave

[*] See, unintuitive, evil and nasty.
    Given the time, I'd start over from scratch.

