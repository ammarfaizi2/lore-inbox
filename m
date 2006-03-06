Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWCFURV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWCFURV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWCFURV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:17:21 -0500
Received: from mms3.broadcom.com ([216.31.210.19]:21515 "EHLO
	MMS3.broadcom.com") by vger.kernel.org with ESMTP id S1751363AbWCFURU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:17:20 -0500
X-Server-Uuid: B238DE4C-2139-4D32-96A8-DD564EF2313E
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
Date: Mon, 6 Mar 2006 12:16:51 -0800
Message-ID: <54AD0F12E08D1541B826BE97C98F99F12FBF33@NT-SJCA-0751.brcm.ad.broadcom.com>
Thread-Topic: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
Thread-Index: AcZBVpVoFhkFmvHgR0GwHpWRL1CSCAAA3xHw
From: "Caitlin Bestler" <caitlinb@broadcom.com>
To: "David Stevens" <dlstevens@us.ibm.com>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>
cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006030606; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230392E34343043393834362E303037342D412D;
 ENG=IBF; TS=20060306201858; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006030606_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 681246A736W4589265-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: netdev-owner@vger.kernel.org 
> [mailto:netdev-owner@vger.kernel.org] On Behalf Of David Stevens
> Sent: Monday, March 06, 2006 11:49 AM
> To: Michael S. Tsirkin
> Cc: Linux Kernel Mailing List; netdev@vger.kernel.org
> Subject: Re: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
> 
> I don't know any details about SDP, but if there are no 
> differences at the protocol layer, then neither the address 
> family nor the protocol is appropriate. If it's just an API 
> change, the socket type is the right selector. So, maybe 
> SOCK_DIRECT to go along with SOCK_STREAM, SOCK_DGRAM, etc.
>                                         +-DLS

That wouldn't work either. The whole point of SDP, or TOE,
is that the API is either totally unchanged or at least
essentially unchanged.

Whenever an IP Address is used (SDP/iWARP, TOE and potentially
SDP/IB) changing from AF_INET* is wrong.

For both SDP/iWARP and SDP/IB you could argue that a different
wire protocol is in use so IPPROTO_SDP is acceptable.
That's probably the best answer as long as we are stuck
under the restriction that the selection of an alternate
stack cannot be done in the exact manner that the consumer
wants it done (that is transparently to the application).

There are even some corner case scenarios where the 
application might care whether their SOCK_STREAM was
carried over SDP or plain TCP. So a protocol based
distinction is probably the least misleading of all
the explicit selection options.

