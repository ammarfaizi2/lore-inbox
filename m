Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbREVNfJ>; Tue, 22 May 2001 09:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbREVNfA>; Tue, 22 May 2001 09:35:00 -0400
Received: from finch-post-11.mail.demon.net ([194.217.242.39]:47889 "EHLO
	finch-post-11.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261692AbREVNe5>; Tue, 22 May 2001 09:34:57 -0400
From: rjd@xyzzy.clara.co.uk
Message-Id: <200105221334.f4MDYsc22597@xyzzy.clara.co.uk>
Subject: Re: SyncPPP IPCP/LCP loop problem and patch
To: paulus@samba.org
Date: Tue, 22 May 2001 14:34:54 +0100 (BST)
Cc: rjd@xyzzy.clara.co.uk, linux-kernel@vger.kernel.org
In-Reply-To: <15114.23570.934599.543352@tango.paulus.ozlabs.org> from "Paul Mackerras" at May 22, 2001 10:31:14 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:
> 
> rjd@xyzzy.clara.co.uk writes:
> > I've hit a problem with the syncPPP module within Linux.
> 
> Seems to me that when you get the conf-request in opened state, you
> should send your conf-request before sending the conf-ack to the
> peer's conf-request.  I think this would short-circuit the loop (I
> could be wrong though, it's getting late).

Thanks but I've already tried that. You get a slightly different pattern
to the loop but it still loops.

> That behaviour would be in line with the FSM in rfc1661, where the
> action for event RCR+ in Opened state is "tld,scr,sca/8", i.e. the one
> action involves sending both the conf-request and the conf-ack.  It is
> debatable to what extent that specifies the order of the messages but
> it does list the conf-request first FWIW.

RFC1661 states: multiple actions may be implemented in any convenient order.
So if it had worked we'd still have been conformant.


I've also tried dropping selected packets when I see the condition, simulating
a noisy line or buggy driver whilst keeping the PPP state machine conformant.
Problem is you need to generate the conf-ack to get the remote end into the
LCP opened state whilst not dropping out of it yourself.

-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
