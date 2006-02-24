Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751004AbWBXNg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbWBXNg4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 08:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751007AbWBXNg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 08:36:56 -0500
Received: from pat.uio.no ([129.240.130.16]:14293 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1750919AbWBXNgz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 08:36:55 -0500
Subject: Re: NFS Still broken in 2.6.x?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andrew Morton <akpm@osdl.org>
Cc: bfink@eventmonitor.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060224041435.733b4f0d.akpm@osdl.org>
References: <43FE1CAD.3050806@eventmonitor.com>
	 <1140734824.7963.38.camel@lade.trondhjem.org>
	 <20060224041435.733b4f0d.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 24 Feb 2006 08:36:38 -0500
Message-Id: <1140788198.3615.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.712, required 12,
	autolearn=disabled, AWL 1.10, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-24 at 04:14 -0800, Andrew Morton wrote:
> Trond Myklebust <trond.myklebust@fys.uio.no> wrote:
> >
> > On Thu, 2006-02-23 at 15:35 -0500, Bryan Fink wrote:
> >  > Hi All.  I'm running into a bit of trouble with NFS on 2.6.  I see that
> >  > at least Trond thought, mid-January, that "The readahead algorithm has
> >  > been broken in 2.6.x for at least the past 6 months." (
> >  > http://www.ussg.iu.edu/hypermail/linux/kernel/0601.2/0559.html) Anyone
> >  > know if that has been fixed?
> > 
> >  No it hasn't been fixed. ...and no, this is not a problem that only
> >  affects NFS: it just happens to give a more noticeable performance
> >  impact due to the larger latency of NFS over a 100Mbps link.
> 
> iirc, last time we went round this loop Ram and I were unable to reproduce it.
> 
> Does anyone have a testcase?

Yes. A dead simple one

run iozone in sequential read mode on a tcp link w/ rsize == 32k

Monitor the traffic using tcpdump. Pretty soon you will see the size of
the NFS read requests drop from 32k to 4k, which indicates that there is
no readahead at all.

Cheers,
  Trond

