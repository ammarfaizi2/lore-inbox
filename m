Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267933AbUHPULY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267933AbUHPULY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 16:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267935AbUHPULY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 16:11:24 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:25361 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S267933AbUHPULV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 16:11:21 -0400
Date: Mon, 16 Aug 2004 22:11:19 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Len Brown <len.brown@intel.com>
Cc: Oliver Feiler <kiza@gmx.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Marcelo Tosatti <marcelo@hera.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: eth*: transmit timed out since .27
In-Reply-To: <1092685109.23057.27.camel@dhcppc4>
Message-ID: <Pine.LNX.4.58L.0408162149440.18978@blysk.ds.pg.gda.pl>
References: <566B962EB122634D86E6EE29E83DD808182C3236@hdsmsx403.hd.intel.com>
  <1092678734.23057.18.camel@dhcppc4>  <41210098.4080904@gmx.net>
 <1092685109.23057.27.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Len Brown wrote:

> > MIS:         42
> 
> This is unusual.
> MIS is a hardware workaround and should normally be 0.

 Unfortunately these events seem to be triggerable for all systems using
serial APIC interrupt delivery.  All that is needed is a sufficiently high
load on interrupts, even a transient one.  Admittedly the definition of
"sufficient" here is very high, something like at least ten thousands of
interrupts per second.  E.g. I've been able to observe a few of them on my
system when a UDP NFS client was untarring an archive over a 100Mbps
network -- both the archive and the destination were located in an NFS
mounted filesystem and the size of the untarred data was around 300MB.  
The APIC hardware is rock-solid there -- after many years of operation I
have yet to see a single APIC error.

 One "reliable" way of triggering these events is configuring the PIT
timer interrupt input as level-triggered in the I/O APIC. ;-)  This is
actually how I did run-time testing of this code.

  Maciej
