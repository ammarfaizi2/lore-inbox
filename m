Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbREXPbJ>; Thu, 24 May 2001 11:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbREXPa7>; Thu, 24 May 2001 11:30:59 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:18450 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S262100AbREXPam>; Thu, 24 May 2001 11:30:42 -0400
From: rjd@xyzzy.clara.co.uk
Message-Id: <200105241530.f4OFUdw27786@xyzzy.clara.co.uk>
Subject: Re: SyncPPP IPCP/LCP loop problem and patch
To: paulkf@microgate.com (Paul Fulghum)
Date: Thu, 24 May 2001 16:30:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, paulus@samba.org
In-Reply-To: <01a801c0e2ea$dfffc5c0$0c00a8c0@diemos> from "Paul Fulghum" at May 22, 2001 06:27:34 
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Fulghum wrote:
> 
> RFC1661 state table shows a transition to req-sent
> from opened when a (properly formated with 
> correct sequence ID) cfg-ack is received.
> 
> Syncppp does not do this (from sppp_lcp_input):
...
> Maybe adding:
> 
>   case LCP_STATE_OPENED:
>    sppp_lcp_open (sp);
>    sp->ipcp.state = IPCP_STATE_CLOSED;
>    sp->lcp.state = LCP_STATE_REQ_SENT;
>    break;

Thanks for the suggestion. I tried it and found that Linux syncppp does not
have a LCP_STATE_REQ_SENT the nearest alternate being LCP_STATE_CLOSED.
Looking at the RFC these are by no means compatable. Adding the extra state
and coding the transitions would not be difficult but as I've looked at it
I've seen more and more ommissions in the code. The magic number is not
randomised very well, jiffies is not a great random number :-)  Parameter
negotiation only takes place for the magic number plus dummys for MRU and
ACCM, I'm not even sure that enforcing and ACCM of all zeros is required.
If the remote end sends us a config request without a magic number we end
up testing an uninitialised variable, and so on.

Who's the owner for syncppp.c ?  I might be able to put some time in on
it, but would hate to be sending patches into empty space.

-- 
        Bob Dunlop                      FarSite Communications
        rjd@xyzzy.clara.co.uk           bob.dunlop@farsite.co.uk
        www.xyzzy.clara.co.uk           www.farsite.co.uk
