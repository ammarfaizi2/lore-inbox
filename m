Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbVIICaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbVIICaT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 22:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751395AbVIICaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 22:30:19 -0400
Received: from koto.vergenet.net ([210.128.90.7]:4830 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751393AbVIICaS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 22:30:18 -0400
Date: Fri, 9 Sep 2005 11:19:48 +0900
From: Horms <horms@verge.net.au>
To: Brian Gerst <bgerst@didntduck.org>
Cc: andy@wolfsinger.com, 326494@bugs.debian.org,
       Marcel Holtmann <marcel@holtmann.org>,
       Maxim Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.ne,
       linux-kernel@vger.kernel.org
Subject: Re: Problems Building Bluetooth with K6 and CONFIG_REGPARM
Message-ID: <20050909021948.GI7236@verge.net.au>
References: <E1EBc9E-0001jo-RU@localhost> <20050908101207.GA7236@verge.net.au> <43206B8D.5020908@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43206B8D.5020908@didntduck.org>
X-Cluestick: seven
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 12:49:17PM -0400, Brian Gerst wrote:
> Horms wrote:
> >Hi Andy,
> >
> >that does indeed seem to be a problem. I have narrowed it down to
> >a combination of using K6 and CONFIG_REGPARM. Hunting around a bit
> >I found this http://my.execpc.com/~geezer/osd/gotchas/, which
> >suggests the problem is that the asm in question tries to add a register
> >to the clobber list which is not available. This makes sense,
> >I guess REGPARM is using edx, so inline assembly can't.
> >
> >I've CCed the bluetooth maintainers and lkml, hopefully someone there
> >will have some input on how to resolve this problem, as inline assembly
> >isn't my strong point and the problem seems to manifest in Linus' current
> >git tree. 
> >
> >The relevant code is the following call to BUILDIO(b,b,char) towards the
> >bottom of include/asm/io.h
> >
> >BUILDIO is as follows, and I am guessing it is the "Nd"(port) and
> >possibley "d"(port) portions that are problematic.
> 
> Sounds like a compiler bug, especially since changing the CPU type fixes 
> it.  What version of GCC?

I definately think it is compiler related, 
I was using Debian's GCC 4.0.1-6. I could try 
with 3.3 or soemthing like that if you like.

The problem was easily reproducable with
4.0.1 and a K6+CONFIG_REGPARM config.

-- 
Horms
