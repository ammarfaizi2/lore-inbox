Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263129AbTFGLow (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 07:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263150AbTFGLow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 07:44:52 -0400
Received: from dp.samba.org ([66.70.73.150]:26857 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263129AbTFGLov convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 07:44:51 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16097.53169.687777.155890@argo.ozlabs.ibm.com>
Date: Sat, 7 Jun 2003 21:42:41 +1000
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] 2.5.70-bk11 zlib merge #4 pure magic
In-Reply-To: <20030607100217.GB24694@wohnheim.fh-wedel.de>
References: <20030606183126.GA10487@wohnheim.fh-wedel.de>
	<20030606183247.GB10487@wohnheim.fh-wedel.de>
	<20030606183920.GC10487@wohnheim.fh-wedel.de>
	<20030606185210.GE10487@wohnheim.fh-wedel.de>
	<20030606192325.GG10487@wohnheim.fh-wedel.de>
	<20030606192814.GH10487@wohnheim.fh-wedel.de>
	<20030606200051.GI10487@wohnheim.fh-wedel.de>
	<20030606201306.GJ10487@wohnheim.fh-wedel.de>
	<16097.45833.384548.319399@argo.ozlabs.ibm.com>
	<20030607100217.GB24694@wohnheim.fh-wedel.de>
X-Mailer: VM 7.16 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel writes:

> On Sat, 7 June 2003 19:40:25 +1000, Paul Mackerras wrote:
> > 
> > Your change won't affect PPP, since pppd already refuses to use
> > windowBits == 8 (as a workaround for this bug).
> 
> Seems like I have misread the ppp code then.  In that case, please
> remove the ppp part from the previous patch or use this one instead,
> Linus.

I meant that pppd (i.e. the user-level part of PPP) would refuse to
negotiate windowBits == 8 with the peer, so from that point of view it
doesn't matter if the kernel driver accepts it or not, since it will
never be asked to accept it (by pppd).  It is better on the whole if
the kernel driver doesn't accept it since that is one less exploitable
thing in the kernel (although you would have to be root to exploit
it).  But if the zlib code also refuses to use windowBits == 8, it
then doesn't matter whether the ppp_deflate code accepts it, from
either point of view.

On the whole I would say that the change to ppp-comp.h should go in,
for now at least.

Paul.
