Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269248AbUIYGfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269248AbUIYGfX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 02:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269252AbUIYGfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 02:35:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:993 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269248AbUIYGfT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 02:35:19 -0400
Date: Sat, 25 Sep 2004 07:35:19 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [PATCH 6/10] Re: [2.6-BK-URL] NTFS: 2.1.19 sparse annotation, cleanups and a bugfix
Message-ID: <20040925063519.GQ23987@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.60.0409241707370.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241711400.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241712320.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241712490.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713070.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713220.19983@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0409241713380.19983@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2004 at 05:13:53PM +0100, Anton Altaparmakov wrote:
>  	/* Get the starting vcn of the index_block holding the child node. */
> -	vcn = sle64_to_cpup((u8*)ie + le16_to_cpu(ie->length) - 8);
> +	vcn = sle64_to_cpup((sle64*)((u8*)ie + le16_to_cpu(ie->length) - 8));

I don't like the look of that.  Are there any alignment warranties for that
pointer?  The same goes for other users of that function...
