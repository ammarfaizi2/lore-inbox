Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293751AbSCETQr>; Tue, 5 Mar 2002 14:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293742AbSCETQj>; Tue, 5 Mar 2002 14:16:39 -0500
Received: from h006008986325.ne.mediaone.net ([24.61.201.13]:35342 "EHLO
	workingcode.com") by vger.kernel.org with ESMTP id <S293736AbSCETQW>;
	Tue, 5 Mar 2002 14:16:22 -0500
From: James Carlson <carlson@workingcode.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15493.6511.657146.472391@h006008986325.ne.mediaone.net>
Date: Tue, 5 Mar 2002 14:15:59 -0500 (EST)
To: jt@hpl.hp.com
Cc: Maksim Krasnyanskiy <maxk@qualcomm.com>, Paul Mackerras <paulus@samba.org>,
        linux-ppp@vger.kernel.org,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: PPP feature request (Tx queue len + close)
In-Reply-To: Jean Tourrilhes's message of 5 March 2002 10:28:35
In-Reply-To: <15492.21937.402798.688693@argo.ozlabs.ibm.com>
	<20020304144200.A32397@bougret.hpl.hp.com>
	<15492.13788.572953.6546@argo.ozlabs.ibm.com>
	<20020304191947.A32730@bougret.hpl.hp.com>
	<20020305094535.A792@bougret.hpl.hp.com>
	<5.1.0.14.2.20020305095825.01b61fd8@mail1.qualcomm.com>
	<20020305102835.B847@bougret.hpl.hp.com>
X-Mailer: VM 6.75 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes writes:
> 	If what you say is true, I should *increase* the buffering
> below PPP to make sure that packet don't get dropped above PPP.

No.  Decreasing the buffering below PPP is the right path.  In
general, if you have link-layer ARQ, you need to have the time
constant be *much* shorter than any RTT estimate that TCP is likely to
see, or you get oscillatory behavior out of TCP.

Running one retransmit-based reliable protocol atop another is usually
a recipe for disaster (as you've found; as others have found by trying
to run PPP over TELNET over the general Internet).

The transport layer (most often TCP) assumes that the network layer
(IP) has minimal (and slowly varying) latency, but is lossy, and thus
that it has minimal buffering and little error control.  Anything that
you do that breaks these assumptions is probably the wrong thing to
do.  Think "packets" not "streams" below PPP.

http://www.ietf.org/internet-drafts/draft-ietf-pilc-link-arq-issues-03.txt
http://www.ietf.org/rfc/rfc3150.txt
http://www.ietf.org/rfc/rfc3155.txt

-- 
James Carlson                                  <carlson@workingcode.com>
