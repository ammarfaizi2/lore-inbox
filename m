Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265429AbTIJSMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 14:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265473AbTIJSMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 14:12:49 -0400
Received: from www.erfrakon.de ([193.197.159.57]:4359 "EHLO www.erfrakon.de")
	by vger.kernel.org with ESMTP id S265429AbTIJSMD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 14:12:03 -0400
From: Martin Konold <martin.konold@erfrakon.de>
Organization: erfrakon
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: Efficient IPC mechanism on Linux
Date: Wed, 10 Sep 2003 20:05:36 +0200
User-Agent: KMail/kroupware-RC2
Cc: Luca Veraldi <luca.veraldi@katamail.com>, linux-kernel@vger.kernel.org
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <200309101939.17967.martin.konold@erfrakon.de> <20030910180128.GP21086@dualathlon.random>
In-Reply-To: <20030910180128.GP21086@dualathlon.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309102005.36383.martin.konold@erfrakon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Wednesday 10 September 2003 08:01 pm schrieb Andrea Arcangeli:

Hi Andreas,

> > The idea is while DMA has much higher bandwidth than PIO DMA is more
> > expensive to initiate than PIO. So DMA is only useful for large messages.
>
> agreed.
>
> > In the local SMP case there do exist userspace APIs like MPI which can do
>
> btw, so far we were only discussing IPC in a local box (UP or SMP or
> NUMA) w/o networking involved. Luca's currnet implementation as well was
> only working locally.

Yes, and I claim that the best you can get for large messages is a plain 
single copy userspace implementation as already implemented by some people 
using the MPI API.

> > True zero copy has unlimited (sigh!) bandwidth within an SMP and does not
> > really make sense in contrast to a network.
>
> if you can avoid to enter kernel, you'd better do that, because entering
> kernel will take much more time than the copy itself.

Yes, doing HPC the kernel may only be used to intialize the intial 
communication channels (e.g. handling permissions etc.). The kernel must be 
avoided for the actual communication by any means.

> with the shm/futex approch you can also have a ring buffer to handle
> parallelism better while it's at the same time zerocopy

How fast will you get? I think you will get the bandwidth of a memcpy for 
large chunks?!

This is imho not really zerocopy. The data has to travel over the memory bus 
involving the CPU so I would call this single copy ;-)

> and enterely
> userspace based in the best case (thought that's not the common case).

Yes a userspace library using the standard MPI API is the proven best approach 
and freely downloadable from 

http://www.pccluster.org/score/dist/pub/score-5.4.0/source/score-5.4.0.mpi.tar.gz

Regards,
-- martin

Dipl.-Phys. Martin Konold
e r f r a k o n
Erlewein, Frank, Konold & Partner - Beratende Ingenieure und Physiker
Nobelstrasse 15, 70569 Stuttgart, Germany
fon: 0711 67400963, fax: 0711 67400959
email: martin.konold@erfrakon.de
