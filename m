Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751068AbVJJXhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbVJJXhx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 19:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbVJJXhx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 19:37:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:5248 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751047AbVJJXhw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 19:37:52 -0400
Date: Mon, 10 Oct 2005 16:36:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: glommer@br.ibm.com, mikulas@artax.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, hirofumi@mail.parknet.co.jp,
       linux-ntfs-dev@lists.sourceforge.net, aia21@cantab.net,
       hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
Message-Id: <20051010163648.3e305b63.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>
References: <20051010204517.GA30867@br.ibm.com>
	<Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk>
	<20051010214605.GA11427@br.ibm.com>
	<Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz>
	<20051010223636.GB11427@br.ibm.com>
	<Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cam.ac.uk> wrote:
>
>  > Maybe the best solution is neither one nor another. Testing and failing
>  > gracefully seems better.
>  > 
>  > What do you think?
> 
>  I certainly agree with you there.  I neither want a deadlock nor 
>  corruption.  (-:

Yup.  In the present implementation __getblk_slow() "cannot fail".  It's
conceivable that at some future stage we'll change __getblk_slow() so that
it returns NULL on an out-of-memory condition.  Anyone making such a change
would have to audit all callers to make sure that they handle the NULL
correctly.

It is appropriate at this time to fix the callers so that they correctly
handle the NULL return.  However, it is non-trivial to actually _test_ such
changes, and such changes should be tested.  Or at least, they should be
done with considerable care and knowledge of the specific filesystems.  
