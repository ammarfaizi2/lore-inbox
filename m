Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUDVONO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUDVONO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264062AbUDVONO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 10:13:14 -0400
Received: from [80.72.36.106] ([80.72.36.106]:59094 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S264045AbUDVONI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 10:13:08 -0400
Date: Thu, 22 Apr 2004 16:13:02 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Guennadi Liakhovetski <gl@dsa-ac.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [somewhat OT] binary modules agaaaain
In-Reply-To: <200404210224.i3L2OAHl020208@eeyore.valparaiso.cl>
Message-ID: <Pine.LNX.4.58.0404221546110.15590@alpha.polcom.net>
References: <200404210224.i3L2OAHl020208@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Horst von Brand wrote:

> Guennadi Liakhovetski <gl@dsa-ac.de> said:
> > On Tue, 20 Apr 2004, Bartlomiej Zolnierkiewicz wrote:
> > > > A binary module is "considered good" if
> 
> > > This is a false assumption IMO no binary only modules can be "good".
> 
> > I agree! That was just an idea to make Linux life easier __if__ it
> > __must__ live with binary modules.
> 
> Then call it "tolerable", not "good". ("Barely tolerable" comes to mind,
> but might be a bit harsh...).
> 
> In any case, one of the biggest advantages of Linux is that in-kernel
> interfaces aren't set in stone. They are extremely efficient because they
> are expressed in terms of access to data structures and inline functions
> and macros. The kernel is extremely flexible because it can be configured
> in hundreds of different ways. All of this is lost through a fixed
> binary-only interface to the binary blob inside the module.

Hi,

Maybe I am totally wrong, but I think that binary modules should (if they 
must exists) be divided into source (better opensource) interface and 
binary only part. But I think that majority of binary only drivers could 
be moved to user space in the great part. Some of them for example are in 
kernel only to allow to create new device and "bind" to it. The rest can 
be probably moved to userspace. Yes, there is performance issue, but only 
in some very rare cases: video cards and maybe something more. But modem 
drivers, vlan drivers, most raid drivers, archiving and versioning 
filesystem implementations, network filesystems (LUFS?), and probably more 
can be removed from kernel.

So I think that there should be some kind of special user-space processes 
that are userspace, have separate adress space, have some special 
scheduling rules (to make them more important than normal processes) and 
can interface with kernel better than normal processes (maybe they will 
have more special syscalls and some kind of callback functionality...).

The interface should allow create and "bind" to device, allocate memory 
region, dma, interrupt, port range, etc. This interface can be considered 
unstable and change with the kernel. There should be way to allow some 
process to do something and disallow to do everything else (to protect
from hidden secret code or simply broken driver). And the interface can be 
not very portable but should be highly extendable by vendors to allow them 
add other functionality to it (if vendor will make this functionality gpl 
and if it will be good it can be included into mainline kernel). This way 
vendors can cooperate with kernel developers.

What do you think?


Grzegorz Kulewski

