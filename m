Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSA1WP1>; Mon, 28 Jan 2002 17:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286959AbSA1WPR>; Mon, 28 Jan 2002 17:15:17 -0500
Received: from smtp-out-2.wanadoo.fr ([193.252.19.254]:32702 "EHLO
	mel-rto2.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S286942AbSA1WPC>; Mon, 28 Jan 2002 17:15:02 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Daniel Jacobowitz <dan@debian.org>, Andrew Morton <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH?] Crash in 2.4.17/ptrace
Date: Mon, 28 Jan 2002 23:15:28 +0100
Message-Id: <20020128221529.24108@smtp.wanadoo.fr>
In-Reply-To: <3C55C2AB.AE73A75D@zip.com.au>
In-Reply-To: <3C55C2AB.AE73A75D@zip.com.au>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Well, get_user_pages is used by several parts of the kernel.
>In the O_DIRECT/map_user_kiobuf case, we could end up asking
>the disk controller to perform busmastering against the video
>PCI device, which will probably explode somewhere down the chain.

Well... not sure. I'd like this to be doable. I have worked
on some high-end broadcast video stuffs in the past, and we
did intensive use of direct bus master from the disk controller
to the framebuffer linear aperture. Actually, we even controlled
the scatter gather list to "sort" lines ;)

If the HW cause a fault, the disk controller should stop and
report an error, and the process should be signaled instead
of getting an oops, but I don't know these code path in linux
at all so...

>Also, just because the hardware is mapped into the process
>virtual address space, it's not necessarily all accessible.
>It is possible to get a bus fault against part of the mapping.
>And the kernel doesn't expect to get bus faults on the source
>of copy_to_user, I think.

Well. My point of view here is fix copy_to_user, but well...

>I'm sure Andrea will have a better notion than I.  Sometimes I
>just fling out random patches to get people thinking about
>things ;)

Ben.



