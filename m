Return-Path: <linux-kernel-owner+w=401wt.eu-S1422671AbWLUDkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422671AbWLUDkV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422673AbWLUDkV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:40:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34580 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422671AbWLUDkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:40:20 -0500
Date: Wed, 20 Dec 2006 19:40:03 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Markus Rechberger" <mrechberger@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [solved] Yenta Cardbus allocation failure
Message-Id: <20061220194003.b0db1844.akpm@osdl.org>
In-Reply-To: <d9def9db0612181612v657197ees925609243fc1ef65@mail.gmail.com>
References: <d9def9db0612120004r45fa1b1dx270a2e9e5be57246@mail.gmail.com>
	<d9def9db0612181612v657197ees925609243fc1ef65@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Dec 2006 01:12:07 +0100
"Markus Rechberger" <mrechberger@gmail.com> wrote:

> I went on with investigating that problem and found the problem,
> though I'm not sure if that solution is acceptable..
> 
> seems like the memory range gets preallocated in setup-bus.c, and
> CARDBUS_MEM_SIZE defines that size.
> 
> I changed
> #define CARDBUS_MEM_SIZE        (32*1024*1024)
> to
> #define CARDBUS_MEM_SIZE        (48*1024*1024)
> 
> and now the system is able to allocate the resources for the 3rd
> pci/pcmcia function.
> 
> Can anyone please have a closer look at it too? I think the whole
> implementation isn't really good there..
> 
> so this is the new output of iomem:
> $ cat /proc/iomem
> ...
> 30000000-35ffffff : PCI Bus #02
>   30000000-32ffffff : PCI CardBus #03
> 36000000-360003ff : 0000:00:1f.1
> 39000000-3bffffff : PCI CardBus #03
>   39000000-39ffffff : 0000:03:00.0
>   3a000000-3affffff : 0000:03:00.1
>   3b000000-3bffffff : 0000:03:00.2 <- this one failed to allocate previously
> 3c000000-3effffff : PCI CardBus #07
> 41000000-43ffffff : PCI CardBus #07
> ...

This keeps happening.  Is there no way in which we can put this to bed
permanently, or does it require prior knowledge about what cardbus cards
the user owns?

Does the cardbus spec set an upper limit on these resource sizes?

Linus has wondered "how much does Windows use"?  How might we determine
that?
