Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964776AbVLMI4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbVLMI4H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbVLMI4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:56:07 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:30640 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932555AbVLMI4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:56:05 -0500
Message-ID: <439E8CB4.2020509@jp.fujitsu.com>
Date: Tue, 13 Dec 2005 17:56:20 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add mem_nmi_panic enable system to panic on hard error
References: <439E6C58.6050301@jp.fujitsu.com> <20051213064800.GB7401@redhat.com>
In-Reply-To: <20051213064800.GB7401@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Dave,

Dave Jones wrote:
> Hmm, are you sure this isn't a bios error misconfiguring
> some northbridge register perhaps ?  Some chipsets offer
> such reporting as a feature. Could be your server has this
> on by default.

I had PCI-clipping tests on our servers.
On injected error, I confirmed that some of them actually
asserts NMI with the reason bit, and logs PCI parity error
to its SEL. (And rests, some having old chipsets, also logs
to SEL but asserts NMI with no reason bits, aka unknown NMI.)
Yes, it's true that not all server support the NMI reporting.

> (I believe the EDAC code has also triggered similar cases
>  on certain cards which is why it too disables this checking
>  by default).

I'm not sure but there could be a special card and card driver
that triggers such NMI but can handle/recover the error.
Also I'm not sure why linux had not have "nmi_panic" but only
"unknown_nmi_panic" that have no effects on reasoned NMI.
...Would someone let me know?

> Why not make this automatic based on dmi strings, instead of
> making the user guess that he needs to pass obscure command
> line options?
> 
> The sysctl seems pointless too. If this is needed at all,
> why would you ever want to turn it off ?

Frankly, this is a kind of port from RHEL3.
Maybe as you know, RHEL3 has "mem_nmi_panic" sysctl.
Of course it is useful for me. That's why the patch is here.

I agree that some server will require this on by default.
However this will not be work with oprofile, and I think this is
not the time to concrete NMI handling.
So now mem_nmi_panic I suggest is just duplicated one of existing
unknown_nmi_panic.

H.Seto

