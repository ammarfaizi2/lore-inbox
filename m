Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261681AbTKGWCZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263930AbTKGWB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 17:01:58 -0500
Received: from soft.uni-linz.ac.at ([140.78.95.99]:53138 "EHLO
	zeus.soft.uni-linz.ac.at") by vger.kernel.org with ESMTP
	id S264010AbTKGJtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 04:49:11 -0500
Message-ID: <3FAB6A8C.9070608@voxel.at>
Date: Fri, 07 Nov 2003 10:49:00 +0100
From: DI Dr Simon Vogl <simon@voxel.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Subject: Re: I2C parallel port adapters drivers
References: <20031102132342.79920c6f.khali@linux-fr.org>
In-Reply-To: <20031102132342.79920c6f.khali@linux-fr.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sorry for the late answer.
you're right, the drivers are very similar, and typically you will only
use one of them. It is of course possible to integrate them all into one
physical module, which you are free to do :) This is more or less grounded
on historic reasons far back in the development of the driver where I
introduced the different hardware access implementations to accomodate
the different implementations (and this went eventually into the kernel...).

So I'd say, go ahead and code :)

Jean Delvare wrote:
> Hi all,
> 
> I have been playing with I2C parallel port adapters drivers for the last
> few days and I believe that some cleanups would be welcome. I will
> expose the facts as I gathered and understood them, and then do some
> proposals about what I think should be made.
> 
> There are four different drivers that let you use the parallel port as
> an I2C bus.
> 
> i2c-philips-par
> i2c-elv
> i2c-velleman
> i2c-pport
> 
> The first three are already present in Linux 2.4 and have also been
> ported to Linux 2.6. The fourth is obviously newer (admittedly derived
> from i2c-velleman) and only present in i2c CVS.
> 
> The last three drivers are very, very similar. Take a look at them, and
> you'll see that they only differ in which pins are used for the I2C bus'
> SCL and SDA lines. They access the parallel port directly, without using
> the parport module.
> 
> The first one, i2c-philips-par, is different, since it relies on the
> parport module. That said, it is similar to the other ones in spirit,
> using the parallel port pins as an I2C bus. Only the access method
> differ.
> 
> My point is that we don't need four different modules for the very same
> purpose. We'd better have one single module, supporting all adapter
> types through a parameter. The i2c-philips-par module already has such a
> mechanism, allowing for two different pins configuration trough its type
> parameter.
> 
> I know have to understand why one module is using the parport module,
> while the other ones are bypassing it. Do we have a reason to prefer one
> method to the other? Using the hardware I have, I could check that both
> methods are working (at least for me), but I might be missing something
> the original modules authors had to mind when writing them. I guess that
> the kernel has policies about how drivers should rely on each other, I
> would want to learn about that.
> 
> I think we should merge the four drivers into a single one, or at least
> (if there is one good reason to access the parallel port using two
> different methods) the last three drivers into a single one. I volunteer
> to do so, but I want to ear opinions about the idea before going on.
> 
> Comments welcome (requested, even).
> 

-- 
Dipl.-Ing. Dr. Simon Vogl !  http://www.voxel.at/
VoXel Interaction Design  !  office@voxel.at
Breitwiesergutstr. 50     !  +43 650 2323 555
A-4020 Linz - Austria     !




