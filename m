Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbVLOQ1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbVLOQ1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 11:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVLOQ1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 11:27:40 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:40381 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1750799AbVLOQ1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 11:27:39 -0500
Date: Thu, 15 Dec 2005 17:27:18 +0100
From: Pavel Machek <pavel@suse.cz>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrea Arcangeli <andrea@suse.de>,
       linux-kernel@vger.kernel.org, Sridhar Samudrala <sri@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [RFC][PATCH 0/6] Critical Page Pool
Message-ID: <20051215162717.GK2904@elf.ucw.cz>
References: <439FCECA.3060909@us.ibm.com> <20051214100841.GA18381@elf.ucw.cz> <20051214120152.GB5270@opteron.random> <1134565436.25663.24.camel@localhost.localdomain> <43A04A38.6020403@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A04A38.6020403@us.ibm.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > The whole extra critical level seems dubious in itself. In 2.0/2.2 days
> > there were a set of patches that just dropped incoming memory on sockets
> > when the memory was tight unless they were marked as critical (ie NFS
> > swap). It worked rather well. The rest of the changes beyond that seem
> > excessive.
> 
> Actually, Sridhar's code (mentioned earlier in this thread) *does* drop
> incoming packets that are not 'critical', but unfortunately you need to
> completely copy the packet into kernel memory before you can do any
> processing on it to determine whether or not it's 'critical', and thus
> accept or reject it.  If network traffic is coming in at a good clip and
> the system is already under memory pressure, it's going to be difficult to
> receive all these packets, which was the inspiration for this patchset.

You should be able to do all this with single, MTU-sized buffer.

Receive packet into buffer. If it is nice, pass it up, otherwise drop
it. Yes, it may drop some "important" packets, but that's okay, packet
loss is expected on networks.
								Pavel
-- 
Thanks, Sharp!
