Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263550AbTDCUYX 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 15:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263561AbTDCUYX 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 15:24:23 -0500
Received: from main.gmane.org ([80.91.224.249]:13996 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263550AbTDCUYW 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 15:24:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Dennis Cook" <cook@sandgate.com>
Subject: Re: Deactivating TCP checksumming
Date: Thu, 3 Apr 2003 15:34:59 -0500
Organization: Sandgate Technologies
Message-ID: <b6i5t1$h0t$1@main.gmane.org>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com> <20030401122824.GY29167@mea-ext.zmailer.org> <b6fda2$oec$1@main.gmane.org> <20030402203653.GA2503@gtf.org> <b6fi8m$j4g$1@main.gmane.org> <20030402205855.GA4125@gtf.org>
X-Complaints-To: usenet@main.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Cc: kernelnewbies@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Based on various feedback, on my RH Linux 2.4.18 kernel I tried the
following:

Set "features" bit NETIF_F_IP_CSUM set (the only feature bit set).
In my network driver start-transmit check for "CHECKSUM_HW" in ip_summed.
Using a small test program, use "sendfile" to copy a file to a network
socket FD.
Result is none of the packets presented to my network adapter driver have
ip_summed set to CHECKSUM_HW, so the SW IP stack has already
computed checksums.

Is this mechanism possibly broken on kernel 2.4?


"Jeff Garzik" <jgarzik@pobox.com> wrote in message
news:20030402205855.GA4125@gtf.org...
> On Wed, Apr 02, 2003 at 03:47:35PM -0500, Dennis Cook wrote:
> > What I was looking for is a general capability to keep the SW transport
> > stack from
> > computing outgoing TCP/UDP/IP checksums so that the HW can be allowed to
do
> > it,
> > similar to Windows checksum offload capability.
>
> If you are not using sendfile(2), it is _more expensive_ to offload
> checksums, because we already checksum and copy at the same time.
>
> Hardware checksum offload is only a win when a copy is eliminated.
>
> Therefore, _always_ offloading checksum is actually slower in some
> cases, because of the unneeded additional HW csum setup that would be
> performed.
>
> Jeff
>
>



