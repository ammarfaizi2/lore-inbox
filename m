Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261413AbREVMcO>; Tue, 22 May 2001 08:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261417AbREVMcE>; Tue, 22 May 2001 08:32:04 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:36104 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S261413AbREVMbz>;
	Tue, 22 May 2001 08:31:55 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15114.23570.934599.543352@tango.paulus.ozlabs.org>
Date: Tue, 22 May 2001 22:31:14 +1000 (EST)
To: rjd@xyzzy.clara.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: SyncPPP IPCP/LCP loop problem and patch
In-Reply-To: <200105221051.f4MApxE22279@xyzzy.clara.co.uk>
In-Reply-To: <200105221051.f4MApxE22279@xyzzy.clara.co.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rjd@xyzzy.clara.co.uk writes:

> I've hit a problem with the syncPPP module within Linux.
> 
> Under certain conditions (hard to quantify exactly, but try several 8Mbps
> streams hitting a relatively slow, say 200MHz processor) the LCP/IPCP
> negotiation hits the following loop.

[snip]

> My solution in the patch that follows is to detect the flip-flop using a
> counter and then after three occurrences with no genuine IPCP traffic to
> modify behavior on receipt of the LCP conf REQ. After three attempts we
> acknowledge the LCP conf REQ but stay in the opened state rather than
> dropping back and restarting our own LCP negotiation. This is non-RFC1661
> behavior unless you consider it part of the general loop avoidance directive.

Seems to me that when you get the conf-request in opened state, you
should send your conf-request before sending the conf-ack to the
peer's conf-request.  I think this would short-circuit the loop (I
could be wrong though, it's getting late).

That behaviour would be in line with the FSM in rfc1661, where the
action for event RCR+ in Opened state is "tld,scr,sca/8", i.e. the one
action involves sending both the conf-request and the conf-ack.  It is
debatable to what extent that specifies the order of the messages but
it does list the conf-request first FWIW.

Paul.
