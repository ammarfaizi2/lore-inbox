Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262746AbTKIVxZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 16:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTKIVxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 16:53:25 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:8714 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262746AbTKIVxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 16:53:21 -0500
Date: Sun, 9 Nov 2003 22:23:36 +0100
From: Jean Delvare <khali@linux-fr.org>
To: "Dr. Simon Vogl" <office@voxel.at>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: I2C parallel port adapters drivers
Message-Id: <20031109222336.29195149.khali@linux-fr.org>
In-Reply-To: <3FAE7BB1.3090007@voxel.at>
References: <20031102132342.79920c6f.khali@linux-fr.org>
	<3FAB6A8C.9070608@voxel.at>
	<20031107223611.173c82cc.khali@linux-fr.org>
	<3FAE7BB1.3090007@voxel.at>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When I wrote the parallel port drivers, the parport api was changing a
> lot. Therefore I did not make use of it. Blocking the parport might be
> a good idea, but it introduces another dependency.

I guess the parport api is stable now, so there should be no problem
using it. And yes, not everyone will enjoy the dependency over
parport.o, especially when it's ten times bigger than the module that
depends on it. Still this is the clean way of doing things, isn't it?

> Anyway, parport only makes real sense when you want to share your 
> parport between multiple devices, say a zip drive. Therefore, a
> question to the whole sensors list: Is anyone really using such a
> setup?

I have been, and could again for testing, but that's not my regular
configuration. Mind you, it looks like parallel port is a dying
technology. Most of the time it has been replaced by SCSI or USB, so
having one parallel port device is quite uncommon nowadays - more than
one must be really rare.

That said, the parport module has more than that. It has a procfs
interface, device detection, and probably workarounds for broken
systems. Also, Mark D. Studebaker pointed out that using the parport
module would probably help a lot on non-PC architectures over direct I/O
operations. Portability is something we would like in the new driver.

> It should at least be configurable as an option (also think of
> using it in embedded devices, where you wouldn't want to bloat the
> kernel with such things...)

If an option, it would have to be a compilation time one, since I
believe the dependencies are computed at compilation time. And it would
make the driver even bigger anyway, were it a run time option. I wasn't
thinking about that option, but you might be right, so I'll think of it.

Anyway, the driver will be bigger than each of the individual drivers we
had today, since it will support all known adapters. So I could also set
them all as compilation time options, so that people needing support for
a single adapter would only select this one. Having such a modular
driver will require some more work, but it should make it suitable for
everyone's specific use.

Having a unified driver could also let me add a preliminary
autodetection of the hardware. Providing i2c-algo-bit has been loaded
with the bit_test=1 option, we could try initializing all known modes in
a row, until one succeeds. Full autodetection is impossible though (some
adapters have their lines inverted and we have no way to detect that).

> As for the naming, i2c-parport would conflict with the old i2c-parport
> module that is still available in 2.4ish kernels in the v4l section -
> maybe i2c-parallel is an option.

Oh, interesting. I had missed that one. So there is a fifth Linux
i2c-over-parallel-port driver. Funny I missed the only one that has the
right name ;) But I wouldn't have looked for such a driver in
media/video, for sure. Why is it lost here?

That driver would be part of my unified driver anyway, so it wouldn't
hurt to keep the name, would it? (I could just pretend I am extending it
;))

> Also, have a look at the wealth of i2c drivers that are present in the
> 2.6 kernels :)

Not sure I get you here. What do you want me to pay attention to
exactly?

Thanks again Simon for the precious insightful remarks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
