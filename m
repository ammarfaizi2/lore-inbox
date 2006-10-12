Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422690AbWJLBxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422690AbWJLBxI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 21:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422693AbWJLBxH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 21:53:07 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:20534 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S1422690AbWJLBxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 21:53:04 -0400
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=MtUKacEIA1rRMb8RNiBIwEk5XQVN1uhzBJdD7MIg2lEKxams0e+E3OtqYfOEth8mdiMFsL2t8tPQc5v9cDXuSxKH7ObCE/3rneebMQ4by24AM9r8khdmyBbPtQCnSezo;
X-IronPort-AV: i="4.09,297,1157346000"; 
   d="scan'208"; a="99170998:sNHT20170332"
Date: Wed, 11 Oct 2006 20:53:06 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Trond Myklebust <Trond.Myklebust@netapp.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Greg KH <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [patch 03/19] SUNRPC: avoid choosing an IPMI port for RPC traffic
Message-ID: <20061012015306.GB27693@lists.us.dell.com>
References: <20061010165621.394703368@quad.kroah.org> <20061010171429.GD6339@kroah.com> <Pine.LNX.4.61.0610102056290.17718@yvahk01.tjqt.qr> <1160610353.7015.8.camel@lade.trondhjem.org> <1160615547.20611.0.camel@localhost.localdomain> <1160616905.6596.14.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160616905.6596.14.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 06:35:05PM -0700, Trond Myklebust wrote:
> On Thu, 2006-10-12 at 02:12 +0100, Alan Cox wrote:
> > Ar Mer, 2006-10-11 am 19:45 -0400, ysgrifennodd Trond Myklebust:
> > > Feel free to tell the board manufacturers that they are idiots, and
> > > should not design boards that hijack specific ports without providing
> > > the O/S with any means of detecting this, but in the meantime, it _is_
> > > the case that they are doing this.
> > 
> > Then their hardware is faulty and should be specifically blacklisted not
> > make everyone have to deal with silly unmaintainable hacks.
> 
> They are not hacks. The actual range of ports used by the RPC client is
> set using /proc/sys/sunrpc/(min|max)_resvport. People that don't have
> broken motherboards can override the default range, which is all that we
> are changing here.
> 
> To be fair, the motherboard manufacturers have actually registered these
> ports with IANA:
> 
> asf-rmcp        623/tcp    ASF Remote Management and Control Protocol
> asf-rmcp        623/udp    ASF Remote Management and Control Protocol
> 
> asf-secure-rmcp 664/tcp    ASF Secure Remote Management and Control Protocol
> asf-secure-rmcp 664/udp    ASF Secure Remote Management and Control Protocol
> 
> but the problem remains that we have no way to actually detect a
> motherboard that uses those ports.

My hackish solution was to create a fake xinetd service listening on
those ports.

http://lists.us.dell.com/pipermail/linux-poweredge/2005-November/023606.html

For the one Dell server affected, we could DMI list
it; likewise for others.


-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
