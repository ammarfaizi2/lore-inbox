Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbVIHQsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbVIHQsI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 12:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964908AbVIHQsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 12:48:07 -0400
Received: from quark.didntduck.org ([69.55.226.66]:51343 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S964858AbVIHQsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 12:48:07 -0400
Message-ID: <43206B8D.5020908@didntduck.org>
Date: Thu, 08 Sep 2005 12:49:17 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Horms <horms@verge.net.au>
CC: andy@wolfsinger.com, 326494@bugs.debian.org,
       Marcel Holtmann <marcel@holtmann.org>,
       Maxim Krasnyansky <maxk@qualcomm.com>, bluez-devel@lists.sf.ne,
       linux-kernel@vger.kernel.org
Subject: Re: Problems Building Bluetooth with K6 and CONFIG_REGPARM
References: <E1EBc9E-0001jo-RU@localhost> <20050908101207.GA7236@verge.net.au>
In-Reply-To: <20050908101207.GA7236@verge.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms wrote:
> Hi Andy,
> 
> that does indeed seem to be a problem. I have narrowed it down to
> a combination of using K6 and CONFIG_REGPARM. Hunting around a bit
> I found this http://my.execpc.com/~geezer/osd/gotchas/, which
> suggests the problem is that the asm in question tries to add a register
> to the clobber list which is not available. This makes sense,
> I guess REGPARM is using edx, so inline assembly can't.
> 
> I've CCed the bluetooth maintainers and lkml, hopefully someone there
> will have some input on how to resolve this problem, as inline assembly
> isn't my strong point and the problem seems to manifest in Linus' current
> git tree. 
> 
> The relevant code is the following call to BUILDIO(b,b,char) towards the
> bottom of include/asm/io.h
> 
> BUILDIO is as follows, and I am guessing it is the "Nd"(port) and
> possibley "d"(port) portions that are problematic.

Sounds like a compiler bug, especially since changing the CPU type fixes 
it.  What version of GCC?

--
				Brian Gerst
