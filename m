Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267403AbUHXKik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267403AbUHXKik (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUHXKik
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:38:40 -0400
Received: from verein.lst.de ([213.95.11.210]:36506 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S267403AbUHXKii (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:38:38 -0400
Date: Tue, 24 Aug 2004 12:38:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bob Gilligan <gilligan@intransa.com>
Cc: linux-iscsi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: [linux-iscsi-devel] Crash running XFS over iSCSI volume
Message-ID: <20040824103824.GB15616@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	Bob Gilligan <gilligan@intransa.com>,
	linux-iscsi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
References: <412A40D6.3070408@intransa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412A40D6.3070408@intransa.com>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2004 at 12:09:10PM -0700, Bob Gilligan wrote:
> Hi Folks -- I'm running Linux kernel 2.6.8.1 and version 4.0.1.8 of the 
> Linux initiator.  I mounted an XFS filesystem over a 900 GB iSCSI 
> volume, then ran "bonnie" with the args "-v 5 -o_direct".   Within about 
> 30 seconds, the kernel started spewing printks from bad_page().  The 
> first few were:

Kown issues.  XFS uses slab pages (as you noticed below), networking
code doesn't like that.  DRBD has been tripping the same issue.  We need
to come up with a consensus about what type of pages can be used in
block I/O requests.  The drbd folks promised to get this discussed on
lkml but I haven't seen a discussion yet - so let's do it now.

