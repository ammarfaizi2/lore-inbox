Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbTDDEbG (for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 23:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTDDEbG (for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 23:31:06 -0500
Received: from ool-43524450.dyn.optonline.net ([67.82.68.80]:43526 "EHLO
	buggy.badula.org") by vger.kernel.org with ESMTP id S261533AbTDDEa7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 23:30:59 -0500
Date: Thu, 3 Apr 2003 23:41:40 -0500
Message-Id: <200304040441.h344feY30091@moisil.badula.org>
From: Ion Badulescu <ionut@badula.org>
To: "Dennis Cook" <cook@sandgate.com>
Cc: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Deactivating TCP checksumming
In-Reply-To: <b6i5t1$h0t$1@main.gmane.org>
User-Agent: tin/1.5.12-20020427 ("Sugar") (UNIX) (Linux/2.4.20 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003 15:34:59 -0500, Dennis Cook <cook@sandgate.com> wrote:
> Based on various feedback, on my RH Linux 2.4.18 kernel I tried the
> following:
> 
> Set "features" bit NETIF_F_IP_CSUM set (the only feature bit set).
> In my network driver start-transmit check for "CHECKSUM_HW" in ip_summed.
> Using a small test program, use "sendfile" to copy a file to a network
> socket FD.
> Result is none of the packets presented to my network adapter driver have
> ip_summed set to CHECKSUM_HW, so the SW IP stack has already
> computed checksums.
> 
> Is this mechanism possibly broken on kernel 2.4?

No, but you also need the scatter-gather bit to be set. Otherwise the 
network needs to perform at least one copy to linearize the skb, thus it 
will take the opportunity to checksum it at the same time so the 
hardware capability of the board is not used.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.
