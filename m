Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310164AbSCET1s>; Tue, 5 Mar 2002 14:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310159AbSCET1i>; Tue, 5 Mar 2002 14:27:38 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:18674 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S310153AbSCET1X>;
	Tue, 5 Mar 2002 14:27:23 -0500
Date: Tue, 5 Mar 2002 11:27:22 -0800
To: James Carlson <carlson@workingcode.com>
Cc: Maksim Krasnyanskiy <maxk@qualcomm.com>, Paul Mackerras <paulus@samba.org>,
        linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
Message-ID: <20020305112722.D898@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <15492.21937.402798.688693@argo.ozlabs.ibm.com> <20020304144200.A32397@bougret.hpl.hp.com> <15492.13788.572953.6546@argo.ozlabs.ibm.com> <20020304191947.A32730@bougret.hpl.hp.com> <20020305094535.A792@bougret.hpl.hp.com> <5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com> <20020305102835.B847@bougret.hpl.hp.com> <15493.6511.657146.472391@h006008986325.ne.mediaone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15493.6511.657146.472391@h006008986325.ne.mediaone.net>; from carlson@workingcode.com on Tue, Mar 05, 2002 at 02:15:59PM -0500
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2002 at 02:15:59PM -0500, James Carlson wrote:
> Jean Tourrilhes writes:
> > 	If what you say is true, I should *increase* the buffering
> > below PPP to make sure that packet don't get dropped above PPP.
> 
> No.  Decreasing the buffering below PPP is the right path.

	Yes, that's what I want to do it. But with regards to TCP,
there is no difference if packets are buffered within PPP or below
PPP. So, reducing buffering in PPP is also a win.

>  In
> general, if you have link-layer ARQ, you need to have the time
> constant be *much* shorter than any RTT estimate that TCP is likely to
> see, or you get oscillatory behavior out of TCP.

	Yep.

> Running one retransmit-based reliable protocol atop another is usually
> a recipe for disaster (as you've found; as others have found by trying
> to run PPP over TELNET over the general Internet).

	Not true. It all depend of the timeframe of those
retransmissions, and how they are triggered. That's why TCP works
properly on 802.11b. Of course, this assume that the link
retransmissions are designed properly.

> The transport layer (most often TCP) assumes that the network layer
> (IP) has minimal (and slowly varying) latency, but is lossy, and thus
> that it has minimal buffering and little error control.

	Not true. Try running TCP on links with 20% packet losses.
	Also, any ethernet driver flow control the stack through
netif_stop/start_queue() to avoid local overruns.

>  Anything that
> you do that breaks these assumptions is probably the wrong thing to
> do.  Think "packets" not "streams" below PPP.
> 
> http://www.ietf.org/internet-drafts/draft-ietf-pilc-link-arq-issues-03.txt
> http://www.ietf.org/rfc/rfc3150.txt
> http://www.ietf.org/rfc/rfc3155.txt

	Already read those. Guess what, my name is event in the
acknowledgments ! How bizzare ;-)

> James Carlson

	Jean
