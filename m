Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWCTRH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWCTRH1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 12:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWCTRH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 12:07:27 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23690 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932253AbWCTRHZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 12:07:25 -0500
Subject: Re: ext3_ordered_writepage() questions
From: "Stephen C. Tweedie" <sct@redhat.com>
To: cmm@us.ibm.com
Cc: Badari Pulavarty <pbadari@us.ibm.com>,
       Andreas Dilger <adilger@clusterfs.com>, Jan Kara <jack@suse.cz>,
       "Theodore Ts'o" <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <1142637789.4802.34.camel@dyn9047017067.beaverton.ibm.com>
References: <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com>
	 <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com>
	 <20060316180904.GA29275@thunk.org>
	 <1142533360.21442.153.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316210424.GD29275@thunk.org>
	 <1142546275.21442.172.camel@dyn9047017100.beaverton.ibm.com>
	 <20060316220545.GB18753@atrey.karlin.mff.cuni.cz>
	 <1142552722.21442.180.camel@dyn9047017100.beaverton.ibm.com>
	 <20060317005418.GY30801@schatzie.adilger.int>
	 <1142615110.3641.8.camel@orbit.scot.redhat.com>
	 <1142631141.15257.40.camel@dyn9047017100.beaverton.ibm.com>
	 <1142634134.3641.56.camel@orbit.scot.redhat.com>
	 <1142635097.15257.49.camel@dyn9047017100.beaverton.ibm.com>
	 <1142637789.4802.34.camel@dyn9047017067.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 12:05:53 -0500
Message-Id: <1142874353.3414.18.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2006-03-17 at 15:23 -0800, Mingming Cao wrote:

> > > There is one other perspective to be aware of, though: the current
> > > behaviour means that by default ext3 generally starts flushing pending
> > > writeback data within 5 seconds of a write.  Without that, we may end up
> > > accumulating a lot more dirty data in memory, shifting the task of write
> > > throttling from the filesystem to the VM.  

> Current data=writeback mode already behaves like this, so the VM
> subsystem should be tested for a certain extent, isn't?

Yes, but there are repeated reports that for many workloads,
data=writeback is actually slower than data=ordered.  So there are
probably some interactions like this which may be hurting us already.

--Stephen


