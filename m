Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932072AbVLHNDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072AbVLHNDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 08:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbVLHNDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 08:03:43 -0500
Received: from styx.suse.cz ([82.119.242.94]:31980 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932072AbVLHNDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 08:03:42 -0500
Date: Thu, 8 Dec 2005 14:03:40 +0100
From: Jiri Benc <jbenc@suse.cz>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joseph Jezak <josejx@gentoo.org>,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, NetDev <netdev@vger.kernel.org>,
       Jouni Malinen <jkmaline@cc.hut.fi>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051208140340.2be1f577@griffin.suse.cz>
In-Reply-To: <1134043965.2867.45.camel@laptopd505.fenrus.org>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
	<20051205190038.04b7b7c1@griffin.suse.cz>
	<4394892D.2090100@gentoo.org>
	<20051205195543.5a2e2a8d@griffin.suse.cz>
	<4394902C.8060100@pobox.com>
	<20051208130751.6586c59d@griffin.suse.cz>
	<1134043965.2867.45.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 08 Dec 2005 13:12:44 +0100, Arjan van de Ven wrote:
> this argument is analogue to the adaptec SAS driver one about the scsi
> host structure. ieee80211 should be a LIBRARY of functions that can do
> things,

Unfortunately, it is not possible to implement ieee80211 as a library,
because you need fragmentation, WDS and such funny stuff, which require
ieee80211 (or possibly "softmac") to be a layer between networking core
and a driver.

> the driver should be able to use the library or not at its own
> choice. forcibly making the ieee80211 layer deal with the WE's is the
> wrong way for this kind of thing, especially since several layers of the
> stack will be optional, so it has to be possible for drivers to go
> "until this layer I use the ieee80211 library functions, below that my
> own".

Making ieee80211 (not any possible layer on top of it, but ieee80211) to
handle part of WE for drivers and reexport (or whatever) the rest to
drivers will not take off the possibility to use WE by others. Where is
the problem?

The goal is to make life simpler for drivers. Dealing with WE is not
easy and even if everything which ieee80211 will do is allowing drivers
to register their handlers during allocation of ieee80211_device by
simply setting pointers to their functions (in ieee80211_device or
somewhere), it will be easier (see the thread at
http://oss.sgi.com/projects/netdev/archive/2004-06/msg00463.html to
understand what I mean).

But I agree this is something we can argue about. This is not the main
reason I gave in my mail, so if you still don't agree with me in this
point, please imagine I didn't mention it - it's not something I want to
argue about now and the explanation I gave is I think valid even without
this point.

Thanks,

-- 
Jiri Benc
SUSE Labs
