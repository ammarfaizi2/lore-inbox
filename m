Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751008AbVJJXXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbVJJXXd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbVJJXXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:23:33 -0400
Received: from tux06.ltc.ic.unicamp.br ([143.106.24.50]:41381 "EHLO
	tux06.ltc.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S1750996AbVJJXXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:23:33 -0400
Date: Mon, 10 Oct 2005 20:33:44 -0300
From: Glauber de Oliveira Costa <glommer@br.ibm.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: glommer@br.ibm.com, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051010233344.GA13399@br.ibm.com>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <20051010231242.GC11427@br.ibm.com> <Pine.LNX.4.62.0510110112310.27454@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510110112310.27454@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2005 at 01:16:59AM +0200, Mikulas Patocka wrote:
> 
> 
> On Mon, 10 Oct 2005, Glauber de Oliveira Costa wrote:
> 
> >
> >>What should a filesystem driver do if it can't suddenly read or write any
> >>blocks on media?
> >
> >Maybe stopping gracefully, warn about what happened, and let the system
> >keep going. You may be right about your main filesystem, but in the case
> >I'm running, for example, my system in an ext3 filesystem, and have a
> >vfat from a usb key. Should my system really hang because I'm not able
> >to read/write to the device?
> 
> getblk won't fail because of I/O error --- it can fail only because of 
> memory management bugs. I think it's right to stop the system in that case 
> --- it's better than silently corrupting data on any device.
> 
> Mikulas
> 
In the code, we see:

if (unlikely(size & (bdev_hardsect_size(bdev)-1) ||
                        (size < 512 || size > PAGE_SIZE))) {

This is where __getblk_slow, and thus, __getblk fails, and it does not
seem to be due to any memory management bug.

-- 
=====================================
Glauber de Oliveira Costa
IBM Linux Technology Center - Brazil
glommer@br.ibm.com
=====================================
