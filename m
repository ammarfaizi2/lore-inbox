Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266826AbUGVH2F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266826AbUGVH2F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 03:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUGVH2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 03:28:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.190]:15852 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S266826AbUGVH1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 03:27:52 -0400
From: Amon Ott <ao@rsbac.org>
Organization: RSBAC
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 4K stack kernel get Oops in Filesystem stress test
Date: Thu, 22 Jul 2004 09:27:44 +0200
User-Agent: KMail/1.6.2
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org> <40FD2E99.20707@mnsu.edu>
In-Reply-To: <40FD2E99.20707@mnsu.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407220927.45201.ao@rsbac.org>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:e784f4497a7e52bfc8179ee7209408c3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 20. Juli 2004 16:39, Jeffrey E. Hundstad wrote:
> Steve Lord wrote:
> > Don't use 4K stacks and XFS. What you hit here is a path where the
> > filesystem is getting full and it needs to free some reserved space
> > by flushing cached data which is using reserved extents. Reserved
> > extents do not yet have an on disk address and they include a
> > reservation for the worst case metadata usage. Flushing them will
> > get you room back.
> >
> > As you can see, it is a pretty deep call stack, most of XFS is going
> > to work just fine with a 4K stack, but there are end cases like
> > this one which will just not fit.
> 
> If this is a known truth with XFS maybe it would be a good idea to have 
> 4K stacks and XFS be an impossible combination using the config tool.

It would be good if there was some warning in the 4K stack option help, 
there have been quite many cases already where the kernel broke with odd 
symptoms because of this switch.

E.g.
Warning: Use this option with care, as it might break your system under 
load. If you experience weird crashes or oopses, please retry with this 
option turned off.

Amon.
-- 
http://www.rsbac.org - GnuPG: 2048g/5DEAAA30 2002-10-22
