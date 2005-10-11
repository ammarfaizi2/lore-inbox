Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVJKAFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVJKAFM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 20:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVJKAFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 20:05:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:8582 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751246AbVJKAFK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 20:05:10 -0400
Date: Tue, 11 Oct 2005 01:05:03 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Glauber de Oliveira Costa <glommer@br.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Anton Altaparmakov <aia21@cam.ac.uk>,
       mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       hirofumi@mail.parknet.co.jp, linux-ntfs-dev@lists.sourceforge.net,
       aia21@cantab.net, hch@infradead.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] Use of getblk differs between locations
Message-ID: <20051011000503.GR7992@ftp.linux.org.uk>
References: <20051010204517.GA30867@br.ibm.com> <Pine.LNX.4.64.0510102217200.6247@hermes-1.csi.cam.ac.uk> <20051010214605.GA11427@br.ibm.com> <Pine.LNX.4.62.0510102347220.19021@artax.karlin.mff.cuni.cz> <20051010223636.GB11427@br.ibm.com> <Pine.LNX.4.64.0510102328110.6247@hermes-1.csi.cam.ac.uk> <20051010163648.3e305b63.akpm@osdl.org> <20051011000734.GC13399@br.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051011000734.GC13399@br.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2005 at 09:07:34PM -0300, Glauber de Oliveira Costa wrote:
>  	if (!bh)
>  		return -EIO;
>  	new = sb_getblk(sb, to);
> +	if (!new)
> +		return -EIO;

You've just introduced a leak here, obviously.

Please, read the code before "fixing" that stuff; slapping returns at random
and hoping that it will help is not a good way to deal with that - the only
thing you achieve is hiding the problem.

The same goes for the rest of patch - in each case it's not obvious that your
changes are correct.
