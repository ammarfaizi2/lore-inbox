Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUBRQkA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 11:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264446AbUBRQkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 11:40:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:56761 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266428AbUBRQj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 11:39:58 -0500
Date: Wed, 18 Feb 2004 08:39:34 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: viro@parcelfarce.linux.theplanet.co.uk, Dave Jones <davej@redhat.com>,
       Santiago Leon <santil@us.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
In-Reply-To: <1077080607.1078.109.camel@gaston>
Message-ID: <Pine.LNX.4.58.0402180834460.2686@home.osdl.org>
References: <40329A24.5070209@us.ibm.com> <1077065118.1082.83.camel@gaston>
  <20040218040130.GC26304@redhat.com>  <20040218042340.GW8858@parcelfarce.linux.theplanet.co.uk>
  <Pine.LNX.4.58.0402172044321.2686@home.osdl.org> <1077080607.1078.109.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Feb 2004, Benjamin Herrenschmidt wrote:
> 
> Well... I still think it's asking for trouble in the long term
> to rely on them .... It's definitely broken for drivers of devices
> that can be used on different archs (PCI cards for example) since
> the layout of the bitfields is different at least with gcc between
> big and little endian machines. But I've also been bitten by
> alignement issues within the bitfield in the past (not with gcc
> though) and other funny things like that...

I mostly agree. 

You _can_ get bitfields correct, but it takes some care. And btw, bit
endianness within a word does not necessarily match the byte endianness,
although they are usually connected. 

See for example <linux/tcp.h> for what you need to do to make bitfields 
work right across architectures.

> So overall, I just recommend to get rid of them.

In general, yes. You can make bitfields be more readable, but you need to 
be careful. And we all know how careful most driver writers tend to be.

		Linus
