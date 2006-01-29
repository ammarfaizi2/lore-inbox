Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbWA2VyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbWA2VyX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 16:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWA2VyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 16:54:22 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:24843 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751162AbWA2VyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 16:54:22 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, thockin@hockin.org
Subject: Re: 2.6.15.1: persistent nasty hang in sync_page killing NFS
 (ne2k-pci / DP83815-related?), i686/PIII
References: <87fyn8artm.fsf@amaterasu.srvr.nix>
	<1138499957.8770.91.camel@lade.trondhjem.org>
	<87slr79knc.fsf@amaterasu.srvr.nix>
	<8764o23j0s.fsf@amaterasu.srvr.nix>
	<1138566075.8711.39.camel@lade.trondhjem.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: impress your (remaining) friends and neighbors.
Date: Sun, 29 Jan 2006 21:54:00 +0000
In-Reply-To: <1138566075.8711.39.camel@lade.trondhjem.org> (Trond
 Myklebust's message of "Sun, 29 Jan 2006 15:21:15 -0500")
Message-ID: <871wyq3dl3.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Jan 2006, Trond Myklebust uttered the following:
> On Sun, 2006-01-29 at 19:56 +0000, Nix wrote:
>> Further info, possibly in support of your suggestion, possibly not: the
>> problem does *not* occur with NFS-over-TCP. So it's specific to UDP,
>> this hardware (perhaps motherboard or network card, see the .config
>> diff), *and* NFS. Other UDP stuff (e.g. DNS) gets through fine in both
>> directions; NFS works with TCP; and the whole lot worked before the
>> hardware was changed.
> 
> If it works with TCP but not UDP, then the problem is usually either a
> NIC driver issue, or a lossy network.

Not a lossy network; it's switched, there are only three machines on it
(discounting UML instances), and all the links are far from saturation.

I was seeing this with under 30 packets per second inbound to the
failing machine.

I suspected network driver problems from the start, hence my copying Tim
:) the kernel used on this box is non-preempted, which rules out locking
problems, I'd think. I'll hack up a test that sends and receives huge
UDP packets, and see how it does.

(netcat should do the trick.)


... well, netcatting this file around via UDP yields such wildly
divergent values, even on an unsaturated network, that I'm inclined to
disregard it entirely: transfers to *localhost* of a 3Mb file yield <90K
at the other end, and I doubt the localhost link should be lossy!

Anyone know a reliable way to test this?

(and surely if it was just packet loss, we wouldn't see *every* packet
getting lost, for *hours*, as we saw here? I left five UDP NFS sessions
frozen on Saturday night, and they were still frozen on Sunday morning,
several NFS servers sending the same data to the failing client over and
over every two seconds without fail, and the client seemingly
disregarding all of it.)

> Comparing with DNS is not really useful, because NFS over UDP uses much
> larger packet sizes (32k usually) which causes heavy use of
> fragmentation.

Indeed.

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
