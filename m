Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030727AbWKORWj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030727AbWKORWj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 12:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030728AbWKORWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 12:22:39 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:55464 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1030727AbWKORWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 12:22:38 -0500
Date: Wed, 15 Nov 2006 18:23:11 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: "Kay Sievers" <kay.sievers@vrfy.org>, "Greg KH" <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Subject: Re: [Patch -mm 2/5] driver core: Introduce device_move(): move a
 device to a new parent.
Message-ID: <20061115182311.70821c97@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <d120d5000611150844s16980cf3r2fca9a71d439cbed@mail.gmail.com>
References: <20061114113208.74ec12c4@gondolin.boeblingen.de.ibm.com>
	<20061115065052.GC23810@kroah.com>
	<20061115082856.195ca0ab@gondolin.boeblingen.de.ibm.com>
	<3ae72650611150044y8e0b57k681c478dca5c6cbf@mail.gmail.com>
	<20061115102409.6e6e5dc0@gondolin.boeblingen.de.ibm.com>
	<1163583119.4244.6.camel@pim.off.vrfy.org>
	<20061115111136.3542aca3@gondolin.boeblingen.de.ibm.com>
	<d120d5000611150844s16980cf3r2fca9a71d439cbed@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2006 11:44:36 -0500,
"Dmitry Torokhov" <dmitry.torokhov@gmail.com> wrote:

> Why do we need to have them at all? Devices should not "move" in the
> trees - it it moves we should just treat them as old devices going
> away and new devices appearing...

But unregistering and re-registering is exactly what we want to avoid
in our case. We have still the same ccw device, it's only now
operational via another subchannel (i. e. the topology changed, but not
the device). If we unregistered the device, we would also kill the
associated block device(s), and if it had been mounted, we go boom.
(This is what currently happens without this patchset, and it may be
triggered by a short hardware outage we'd otherwise survive without a
problem.)

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
