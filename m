Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964836AbVJMA1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964836AbVJMA1p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 20:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbVJMA1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 20:27:45 -0400
Received: from mail.shareable.org ([81.29.64.88]:5602 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S964835AbVJMA1o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 20:27:44 -0400
Date: Thu, 13 Oct 2005 01:27:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Jeff Mahoney <jeffm@suse.com>, Anton Altaparmakov <aia21@cam.ac.uk>,
       Glauber de Oliveira Costa <glommer@br.ibm.com>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051013002726.GG23770@mail.shareable.org>
References: <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <Pine.LNX.4.64.0510102319100.6247@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.62.0510110035110.19021@artax.karlin.mff.cuni.cz> <1129017155.12336.4.camel@imp.csi.cam.ac.uk> <434D6932.1040703@suse.com> <Pine.LNX.4.62.0510122155390.9881@artax.karlin.mff.cuni.cz> <434D6CFA.4080802@suse.com> <Pine.LNX.4.62.0510122208210.11573@artax.karlin.mff.cuni.cz> <20051013000921.GD23770@mail.shareable.org> <Pine.LNX.4.62.0510130217050.15206@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0510130217050.15206@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikulas Patocka wrote:
> That is possible ... you must also make sure that you do not hold an 
> important semaphore while waiting for some removable device (auditing VFS 
> for this will be a bit harder...)

If any filesystem is holding any _global_ semaphores while waiting for
an I/O to complete - that's a major bug already.

Activity which may take a long time due to slow I/O on one filesystem
shouldn't block activity on other, unrelated filesystems, apart from
global resource competition such as numbers of dirty pages...

-- Jamie
