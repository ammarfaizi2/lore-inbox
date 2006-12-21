Return-Path: <linux-kernel-owner+w=401wt.eu-S1423122AbWLUVbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423122AbWLUVbO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 16:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423121AbWLUVbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 16:31:14 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:39418 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423118AbWLUVbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 16:31:13 -0500
To: jengelh@linux01.gwdg.de
CC: rmk+lkml@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-reply-to: <Pine.LNX.4.61.0612212203510.3720@yvahk01.tjqt.qr> (message from
	Jan Engelhardt on Thu, 21 Dec 2006 22:04:53 +0100 (MET))
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
 that again
References: <20061221152621.GB3958@flint.arm.linux.org.uk>
 <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu> <20061221165744.GD3958@flint.arm.linux.org.uk>
 <E1GxS4e-0000pb-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.61.0612212203510.3720@yvahk01.tjqt.qr>
Message-Id: <E1GxVV8-0001Jz-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 21 Dec 2006 22:30:54 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> >The root of the problem is that copy_to_user() may cause page faults
> >on the userspace buffer, and the page fault might (in case of a
> >maliciously crafted filesystem) recurse into the filesystem itself.
> 
> Would it be worthwhile to mlock the page? I know that needs root
> privs or some capability, but a static buffer could be put aside when
> fusermount is run.

And how would the kernel ensure, that the buffer supplied by userspace
is mlocked and stays mlocked during the memory copy?  I don't think
that would simplify the kerel side much, and would complicate the
userspace side considerably.

Miklos
