Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422671AbWJLBfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWJLBfX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWJLBfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:35:23 -0400
Received: from mx2.netapp.com ([216.240.18.37]:28981 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S932488AbWJLBfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:35:22 -0400
X-IronPort-AV: i="4.09,297,1157353200"; 
   d="scan'208"; a="417199975:sNHT86718040"
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC
	traffic
From: Trond Myklebust <Trond.Myklebust@netapp.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <1160615547.20611.0.camel@localhost.localdomain>
References: <20061010165621.394703368@quad.kroah.org>
	 <20061010171429.GD6339@kroah.com>
	 <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr>
	 <1160610353.7015.8.camel@lade.trondhjem.org>
	 <1160615547.20611.0.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Network Appliance Inc
Date: Wed, 11 Oct 2006 18:35:05 -0700
Message-Id: <1160616905.6596.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
X-OriginalArrivalTime: 12 Oct 2006 01:35:22.0374 (UTC) FILETIME=[AF073A60:01C6ED9E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 02:12 +0100, Alan Cox wrote:
> Ar Mer, 2006-10-11 am 19:45 -0400, ysgrifennodd Trond Myklebust:
> > Feel free to tell the board manufacturers that they are idiots, and
> > should not design boards that hijack specific ports without providing
> > the O/S with any means of detecting this, but in the meantime, it _is_
> > the case that they are doing this.
> 
> Then their hardware is faulty and should be specifically blacklisted not
> make everyone have to deal with silly unmaintainable hacks.

They are not hacks. The actual range of ports used by the RPC client is
set using /proc/sys/sunrpc/(min|max)_resvport. People that don't have
broken motherboards can override the default range, which is all that we
are changing here.

To be fair, the motherboard manufacturers have actually registered these
ports with IANA:

asf-rmcp        623/tcp    ASF Remote Management and Control Protocol
asf-rmcp        623/udp    ASF Remote Management and Control Protocol

asf-secure-rmcp 664/tcp    ASF Secure Remote Management and Control Protocol
asf-secure-rmcp 664/udp    ASF Secure Remote Management and Control Protocol

but the problem remains that we have no way to actually detect a
motherboard that uses those ports.

Interestingly, Linux is not the only OS that has been hit by this
problem:

  http://blogs.sun.com/shepler/entry/port_623_or_the_mount

Cheers,
  Trond
