Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271219AbTGWS6A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:58:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271217AbTGWS5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:57:18 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:57098 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S271219AbTGWS4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:56:43 -0400
Date: Wed, 23 Jul 2003 12:11:45 -0700
From: jw schultz <jw@pegasys.ws>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: ICMP REQUEST
Message-ID: <20030723191145.GC15719@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <E04CF3F88ACBD5119EFE00508BBB212104BCD649@exch-01.noida.hcltech.com> <20030723181212.GB15719@pegasys.ws> <Pine.LNX.4.53.0307231422010.15818@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0307231422010.15818@chaos>
User-Agent: Mutt/1.3.27i
X-Message-Flag: This Outlook installation has been found to be susceptible to misuse.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 02:26:41PM -0400, Richard B. Johnson wrote:
> On Wed, 23 Jul 2003, jw schultz wrote:
> 
> > On Wed, Jul 23, 2003 at 12:53:35PM +0530, Hemanshu Kanji Bhadra, Noida wrote:
> > > Hi, All
> > >
> > > i am developing a  ping program, through my program I get ECHO_REPLY..but I
> > > dont get ECHO_REQUEST.
> > >
> > > is that the ECHO_REQUEST is handled by kernel.?
> > >
> > > please respond as it is urgent.
> >
> > In most cases ICMP ECHO_REQUEST is handled by the NIC.  The
> > kernel doesn't even see it.  That is why you can ping a
> > crashed system; the NIC is still configured.
> >
> 
> No. It may be handled entirely in an interrupt service routine, but
> never by the hardware alone, even the "smart" hardware that does
> IP checksumming. There isn't enough information available. The
> echo request contains the IP that the caller seeks to respond.
> The responder needs to know, not only its IP address, but also the
> IP address of all the IPs it's going to ARP (proxy ARP).

Thanks for the correction although i wouldn't say "never".

I did have experience with some minis where the NIC did
handle ICMP internally for anything on the local subnet for
which it already had an arp entry.  But these NICs had
68000s as embedded processors, did bi-directional DMA and
offloaded part of the network stack.  The NIC would continue
to respond even while a new kernel was being booted,
glitching only when the NIC was reset.  Back when CPU clocks
were 16MHz this kind of offloading made sense.  My
experience seems to have clouded current expectations.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
