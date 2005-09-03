Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161159AbVICGXq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbVICGXq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 02:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161160AbVICGXq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 02:23:46 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:7921 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161159AbVICGXq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 02:23:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YABH0a2rqslQUpoyJnBLB6je7UY8aA6bw/inby5a9rq1LPDfouxoF8vxWa/AFsZjKQt55EwNSfHb/u4kW8ppU/MYb72aXkW+EQYsvhLCwLxM/QsSaHaLReTm49NYJKN57z4uhLt6fIZ/cNusMCH5jwO+UY/g3O/U/Kxvf2VD9S0=
Message-ID: <355e5e5e05090223231726b94a@mail.gmail.com>
Date: Fri, 2 Sep 2005 23:23:41 -0700
From: Lukasz Kosewski <lkosewsk@gmail.com>
Reply-To: lkosewsk@gmail.com
To: Ravi Wijayaratne <ravi_wija@yahoo.com>
Subject: Re: Hotswap support for libata
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050902224418.78897.qmail@web32512.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050902224418.78897.qmail@web32512.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/05, Ravi Wijayaratne <ravi_wija@yahoo.com> wrote:
> I was wandering whether you could direct me to
> a place where I could find the most up to date
> patches for libata hotplug support you authored.
> 
> Has Jeff Garzik decided to integrate this code
> to 2.6 libata ?

Hey Ravi,

You are on the money in one way; it's September, and I promised
everyone I'd work on it come September.  However, this is a loose
timeline; specifically, I'll be available to work on them come the 6th
of this month.  So expect some more activity then :)

First of all let me clarify something though; these patches are two parts:
- a libata hotswap infrastructure that allows a driver which
understands and properly handles hotplug interrupts to hotswap drives.
- a specific implementation of this infrastructure in the Promise
SATA150 and SATAII150 line of controllers.

I've been getting quite a few emails offline from people excited with
being able to arbitrarily hotswap all Serial ATA drives, and I should
point out that unless people with the other controllers types (ie.
nForce controllers, Sil controllers, etc.) actually add support for
capturing hotswap interrupts and use the hotswap infrastructure, they
will still not support hotplug.  If you send me a controller and the
docs for it, I will add the support and test the b'jesus out of it,
but otherwise only the Promise controllers will have this support.

Here's the current status for all to see:
- I submitted initial patches near the end of July, which were heavily
tested on UP machines and Promise SATA150/SATAII150 Tx4/Tx2 Plus
controllers.  They mostly work.
- Jeff suggested some improvements that would make them work better,
and these improvements work better for a general infrastructure (as
opposed to a sata_promise-centric one).
- I sent in patches implementing the improvements on the 1st of
August.  They weren't tested at all because I didn't have access to
the hardware at that time, but I wanted some feedback.  Those patches
DO NOT WORK, however, they are very close to what I want (I need to
add a workqueue and streamline error-handling a bit more).
- Come the 6th, I'm going to a location where I'll have access to the
controller, as well as UP boxes and an SMP box.  So you can expect new
patches, say, by the 10th or 11th that should be well tested and
robust on UP and SMP machines for Jeff's perusal.

So, if you really want hotswap now now now, you'll have to download my
patches and fiddle with them.  They're available in the kernel mailing
list archives, if you search for 'hotswap libata', they will come up. 
Otherwise, I ask you to be patient for another wek or so and the good
stuff will fall from the sky.

Cheers,

Luke Kosewski
