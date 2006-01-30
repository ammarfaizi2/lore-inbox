Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWA3T0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWA3T0E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWA3T0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:26:04 -0500
Received: from host27-37.discord.birch.net ([65.16.27.37]:40399 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S932381AbWA3T0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:26:02 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Trond Myklebust'" <trond.myklebust@fys.uio.no>,
       "'Nix'" <nix@esperi.org.uk>
Cc: <linux-kernel@vger.kernel.org>, <thockin@hockin.org>
Subject: RE: 2.6.15.1: persistent nasty hang in sync_page killing NFS(ne2k-pci / DP83815-related?), i686/PIII
Date: Mon, 30 Jan 2006 13:36:17 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1138499957.8770.91.camel@lade.trondhjem.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYkdrxEcijFEgICQBC2FMGzUcgvgABXHsxg
Message-ID: <EXCHG2003dMJOtd3rOE000010a2@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 30 Jan 2006 19:19:22.0390 (UTC) FILETIME=[134E5B60:01C625D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Trond Myklebust
> Sent: Saturday, January 28, 2006 7:59 PM
> To: Nix
> Cc: linux-kernel@vger.kernel.org; thockin@hockin.org
> Subject: Re: 2.6.15.1: persistent nasty hang in sync_page 
> killing NFS(ne2k-pci / DP83815-related?), i686/PIII
> 
> On Sat, 2006-01-28 at 22:52 +0000, Nix wrote:
> 
> > tcpdumps and the kernel's packet counters on both sides show NFS 
> > packets flowing, and being retried, over and over again:
> 
> Are you using an Intel motherboard? If so, it could be the IPMI bug
> 
> http://blogs.sun.com/roller/page/shepler?entry=port_623_or_the_mount
> 
> Cheers,
>   Trond

Trond, Nix,

There is a *WORSE* bug with the Broadcom network chip based boards
around IPMI if IPMI and linux are using the same ip and mac address.

The broadcom firmware will collect all packets destined for the IPMI
port (which should be fine-except that the broadcom firmware does not
understand IP fragments and collects any fragments whose value where 
the port would normally be matches the IPMI port-even though it is an
ip fragment and does not have an associated port number).

I have only so far seen it affect UDP and not TCP, but I have a
nice simple program (supplied by a customer) that will nicely duplicate
the problem (every time), I lose the same single fragment out of a 
32k NFS packet each and every time.

I have reported the problem to Broadcom, the only real response out
of anyone is to use separate ip/mac address for IPMI.

                                  Roger

