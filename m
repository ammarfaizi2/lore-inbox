Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbUCZK5j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbUCZK5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:57:38 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:35596 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264009AbUCZK5g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:57:36 -0500
Date: Fri, 26 Mar 2004 10:57:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Robin Holt <holt@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large memory application exhuasts buffers during write.
Message-ID: <20040326105735.A4613@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Robin Holt <holt@sgi.com>, linux-kernel@vger.kernel.org
References: <20040326012056.GB19152@lnx-holt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040326012056.GB19152@lnx-holt>; from holt@sgi.com on Thu, Mar 25, 2004 at 07:20:56PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 25, 2004 at 07:20:56PM -0600, Robin Holt wrote:
> This is a 2.4 based kernel with many of the redhat patches applied.
> Before the application is started, there is approx 350GB of memory
> free according to top.  When the app starts, it mallocs a 300GB
> buffer, initializes it, does computations into it, and then starts
> to write it to a disk file.
> 
> What we see happen is the first approx 30GBs gets written and then
> swap starts getting utilized.  Once swap has been heavily utilized,
> the OOM killer kicks in and kills the job.

Buffered writes or O_DIRECT?  I guess you're doing the former and
actually want the latter.  Try preloading a tiny library stub that
adds O_DIRECT to open for the interesting fds.

