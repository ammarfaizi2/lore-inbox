Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268831AbUILTmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268831AbUILTmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 15:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268832AbUILTmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 15:42:38 -0400
Received: from outbound01.telus.net ([199.185.220.220]:58831 "EHLO
	priv-edtnes57.telusplanet.net") by vger.kernel.org with ESMTP
	id S268831AbUILTmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 15:42:22 -0400
From: "Wolfpaw - Dale Corse" <admin@wolfpaw.net>
To: <toon@hout.vanvergehaald.nl>
Cc: <kaukasoi@elektroni.ee.tut.fi>, <linux-kernel@vger.kernel.org>,
       <alan@lxorguk.ukuu.org.uk>
Subject: RE: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Date: Sun, 12 Sep 2004 13:42:26 -0600
Message-ID: <002c01c49900$a20df550$0200a8c0@wolf>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Importance: Normal
In-Reply-To: <02bf01c498ff$b6512470$0300a8c0@s>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

 I'm not Alan, just trying to save him some typing :) The 
issue being referenced is that BGP4 as you know uses TCP 
communication to check link status. If the TCP session is 
severed in any way, BGP assumes the link down, and drops 
the advertisements, or the table depending which side 
(at least in Cisco's implementation).

This basically leaves you dead in the water for a few
seconds while the BGP session is re-established, and
the advertisements are send out, and table rebuilt. It
can also cause other routers on the net to see you as
"flapping", and dampen your routes.. Which again leaves
you dead in the water (at least from things behind them).

This is accomplished by guessing the correct TCP Sequence
number, and sending RST packets to drop the TCP connection.

BGP does not actually check the layer 2 status of the
connection to make sure the link is still UP before
it assumes you have dropped. I believe this is the
poor implementation he is referring to.

MD5 encryption was added to the sessions between
routers to make hijacking the stream more difficult
(if not next to impossible)

D.

> -----Original Message-----
> From: Dale Corse [mailto:admin@wolfpaw.net] 
> Sent: Sunday, September 12, 2004 1:36 PM
> To: 'Dale'
> Subject: FW: Linux 2.4.27 SECURITY BUG - TCP Local and 
> REMOTE(verified) Denial of Service Attack
> 
> 
> 
> 
> -----Original Message-----
> From: Toon van der Pas [mailto:toon@hout.vanvergehaald.nl] 
> Sent: Sunday, September 12, 2004 1:24 PM
> To: Alan Cox
> Cc: Wolfpaw - Dale Corse; kaukasoi@elektroni.ee.tut.fi; Linux 
> Kernel Mailing List
> Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and 
> REMOTE(verified) Denial of Service Attack
> 
> 
> On Sun, Sep 12, 2004 at 06:04:53PM +0100, Alan Cox wrote:
> > 
> > This is not a TCP flaw, its a combination of poor design by certain
> > vendors, poor BGP implementation and a lack of 
> understanding of what 
> > TCP does and does not do. See IPSec. TCP gets stuff from A to B in 
> > order and knowing to a resonable degree what arrived. TCP does not 
> > proide a security service.
> > 
> > (The core of this problem arises because certain people treat TCP
> > connection down on the peering session as link down)
> 
> Alan, could you please elaborate on this last statement?
> I don't understand what you mean, and am very interested.
> 
> Thanks,
> Toon.
> -- 
> "Debugging is twice as hard as writing the code in the first 
> place. Therefore, if you write the code as cleverly as 
> possible, you are, by definition, not smart enough to debug 
> it." - Brian W. Kernighan
> 
> --------------------------------------------------------------
> --------------
> -
> This message has been scanned for Spam and Viruses by ClamAV 
> and SpamAssassin
> --------------------------------------------------------------
> --------------
> -
> 
> 
> 
> 

