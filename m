Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030543AbVKPWmU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030543AbVKPWmU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 17:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030544AbVKPWmU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 17:42:20 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:16042 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S1030543AbVKPWmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 17:42:20 -0500
Date: Wed, 16 Nov 2005 22:42:08 +0000 (GMT)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Max Krasnyansky <maxk@qualcomm.com>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, hugh@veritas.com
Subject: Re: 2.6.14 X spinning in the kernel
In-Reply-To: <1132177953.24066.80.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0511162238480.24969@skynet>
References: <1132012281.24066.36.camel@localhost.localdomain> 
 <20051114161704.5b918e67.akpm@osdl.org>  <1132015952.24066.45.camel@localhost.localdomain>
  <20051114173037.286db0d4.akpm@osdl.org> <437A6609.4050803@us.ibm.com> 
 <437B9FAC.4090809@qualcomm.com> <1132177953.24066.80.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>
> I traced it little further.
>
> It looks like radeon_freelist_get() is always returning NULL.
> Which seem to have 2 loops
> 	- top loop is for for 10000 times (usec_timeout).
> 	- second one for length of the list ?
>
> 	for (t = 0; t < dev_priv->usec_timeout; t++)
> 		..
> 		for (i = start; i < dma->buf_count; i++) {
>
> 		..
> 		}
> 	}
>
> Which is making it even worse.
>
> And also, radeon_cp_get_buffers() is getting called repeatedly.

Again I say this is a chip hang, the chip isn't consuming any more data,
so we run out of buffers...

Can you send me lspci -v, /var/log/Xorg.0.log, xorg.conf

If you are running a PCI Radeon you are screwed with the latest Fedora X
packages, roll back a few to find the ones that work, the FC people took a
really hacky patch from ATI and thought it was a good idea, and now it is
in X.org, or turn off DRI...

Dave.

-- David Airlie, Software Engineer http://www.skynet.ie/~airlied / airlied
at skynet.ie Linux kernel - DRI, VAX / pam_smb / ILUG
