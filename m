Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750711AbWINDjA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWINDjA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 23:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWINDjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 23:39:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56301 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750711AbWINDi6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 23:38:58 -0400
Date: Wed, 13 Sep 2006 20:38:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Badari Pulavarty <pbadari@us.ibm.com>,
       Anton Altaparmakov <aia21@cam.ac.uk>, sct@redhat.com,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, ext4 <linux-ext4@vger.kernel.org>
Subject: Re: [RFC][PATCH] set_page_buffer_dirty should skip unmapped buffers
Message-Id: <20060913203817.b6711381.akpm@osdl.org>
In-Reply-To: <1158179120.11112.2.camel@kleikamp.austin.ibm.com>
References: <20060901101801.7845bca2.akpm@osdl.org>
	<1157472702.23501.12.camel@dyn9047017100.beaverton.ibm.com>
	<20060906124719.GA11868@atrey.karlin.mff.cuni.cz>
	<1157555559.23501.25.camel@dyn9047017100.beaverton.ibm.com>
	<20060906153449.GC18281@atrey.karlin.mff.cuni.cz>
	<1157559545.23501.30.camel@dyn9047017100.beaverton.ibm.com>
	<20060906162723.GA14345@atrey.karlin.mff.cuni.cz>
	<1157563016.23501.39.camel@dyn9047017100.beaverton.ibm.com>
	<20060906172733.GC14345@atrey.karlin.mff.cuni.cz>
	<1157641877.7725.13.camel@dyn9047017100.beaverton.ibm.com>
	<20060907223048.GD22549@atrey.karlin.mff.cuni.cz>
	<1158179120.11112.2.camel@kleikamp.austin.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006 15:25:19 -0500
Dave Kleikamp <shaggy@austin.ibm.com> wrote:

> > +void journal_do_submit_data(struct buffer_head **wbuf, int bufs)
> 
> Is there any reason this couldn't be static?

Nope.

> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < bufs; i++) {
> > +               wbuf[i]->b_end_io = end_buffer_write_sync;
> > +               /* We use-up our safety reference in submit_bh() */
> > +               submit_bh(WRITE, wbuf[i]);
> > +       }
> > +} 
> 
> I'm rebasing the ext4 work on the latest -mm tree and would like to
> avoid renaming this function in the jbd2 clone.

<edits the diff>
