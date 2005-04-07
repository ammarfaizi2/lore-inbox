Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVDGP2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVDGP2i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbVDGP2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:28:38 -0400
Received: from unthought.net ([212.97.129.88]:19587 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S262487AbVDGP2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:28:33 -0400
Date: Thu, 7 Apr 2005 17:28:32 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bdflush/rpciod high CPU utilization, profile does not make sense
Message-ID: <20050407152831.GM347@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-kernel@vger.kernel.org
References: <20050406160123.GH347@unthought.net> <1112822936.13304.44.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112822936.13304.44.camel@lade.trondhjem.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2005 at 05:28:56PM -0400, Trond Myklebust wrote:
...
> A look at "nfsstat" might help, as might "netstat -s".
> 
> In particular, I suggest looking at the "retrans" counter in nfsstat.

When doing a 'cp largefile1 largefile2' on the client, I see approx. 10
retransmissions per second in nfsstat.

I don't really know if this is a lot...

I also see packets dropped in ifconfig - approx. 10 per second...  I
wonder if these two are related.

Client has an intel e1000 card - I just set the RX ring buffer to the
max. of 4096 (up from the default of 256), but this doesn't seem to help
a lot (I see the 10 drops/sec with the large RX buffer).

I use NAPI - is there anything else I can do to make the card not drop
packets?   I'm just assuming that this might at least be a part of the
problem, but with large RX ring and NAPI I don't know how much else I
can do to not make the box drop incoming data...

> When you say that TCP did not help, please note that if retrans is high,
> then using TCP with a large value for timeo (for instance -otimeo=600)
> is a good idea. It is IMHO a bug for the "mount" program to be setting
> default timeout values of less than 30 seconds when using TCP.

I can try that.

Thanks!

-- 

 / jakob

