Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTKBMYe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Nov 2003 07:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTKBMYd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Nov 2003 07:24:33 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:4106 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261680AbTKBMYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Nov 2003 07:24:32 -0500
Date: Sun, 2 Nov 2003 13:23:42 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Simon Vogl <simon@voxel.at>, Daniel Smolik <marvin@sitour.cz>
Cc: Greg KH <greg@kroah.com>, sensors@stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: I2C parallel port adapters drivers
Message-Id: <20031102132342.79920c6f.khali@linux-fr.org>
Reply-To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I have been playing with I2C parallel port adapters drivers for the last
few days and I believe that some cleanups would be welcome. I will
expose the facts as I gathered and understood them, and then do some
proposals about what I think should be made.

There are four different drivers that let you use the parallel port as
an I2C bus.

i2c-philips-par
i2c-elv
i2c-velleman
i2c-pport

The first three are already present in Linux 2.4 and have also been
ported to Linux 2.6. The fourth is obviously newer (admittedly derived
from i2c-velleman) and only present in i2c CVS.

The last three drivers are very, very similar. Take a look at them, and
you'll see that they only differ in which pins are used for the I2C bus'
SCL and SDA lines. They access the parallel port directly, without using
the parport module.

The first one, i2c-philips-par, is different, since it relies on the
parport module. That said, it is similar to the other ones in spirit,
using the parallel port pins as an I2C bus. Only the access method
differ.

My point is that we don't need four different modules for the very same
purpose. We'd better have one single module, supporting all adapter
types through a parameter. The i2c-philips-par module already has such a
mechanism, allowing for two different pins configuration trough its type
parameter.

I know have to understand why one module is using the parport module,
while the other ones are bypassing it. Do we have a reason to prefer one
method to the other? Using the hardware I have, I could check that both
methods are working (at least for me), but I might be missing something
the original modules authors had to mind when writing them. I guess that
the kernel has policies about how drivers should rely on each other, I
would want to learn about that.

I think we should merge the four drivers into a single one, or at least
(if there is one good reason to access the parallel port using two
different methods) the last three drivers into a single one. I volunteer
to do so, but I want to ear opinions about the idea before going on.

Comments welcome (requested, even).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
