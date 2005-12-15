Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965162AbVLOHhP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965162AbVLOHhP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 02:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965163AbVLOHhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 02:37:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59349 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965162AbVLOHhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 02:37:12 -0500
Subject: Re: [patch 6/6] statistics infrastructure - exploitation: zfcp
From: Arjan van de Ven <arjan@infradead.org>
To: Martin Peschke <mp3@de.ibm.com>
Cc: linux-scsi@vger.kernel.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@infradead.org>
In-Reply-To: <43A0E8E7.1060706@de.ibm.com>
References: <43A044E6.7060403@de.ibm.com>
	 <20051214165900.GA26580@infradead.org>  <43A0E8E7.1060706@de.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Dec 2005 08:37:08 +0100
Message-Id: <1134632229.16486.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-15 at 04:54 +0100, Martin Peschke wrote:
> Christoph Hellwig wrote:
> 
> >>+	atomic_t		read_num;
> >>+	atomic_t		write_num;
> >>+	struct statistic_interface	*stat_if;
> >>+	struct statistic		*stat_sizes_scsi_write;
> >>+	struct statistic		*stat_sizes_scsi_read;
> >>+	struct statistic		*stat_sizes_scsi_nodata;
> >>+	struct statistic		*stat_sizes_scsi_nofit;
> >>+	struct statistic		*stat_sizes_scsi_nomem;
> >>+	struct statistic		*stat_sizes_timedout_write;
> >>+	struct statistic		*stat_sizes_timedout_read;
> >>+	struct statistic		*stat_sizes_timedout_nodata;
> >>+	struct statistic		*stat_latencies_scsi_write;
> >>+	struct statistic		*stat_latencies_scsi_read;
> >>+	struct statistic		*stat_latencies_scsi_nodata;
> >>+	struct statistic		*stat_pending_scsi_write;
> >>+	struct statistic		*stat_pending_scsi_read;
> >>+	struct statistic		*stat_erp;
> >>+	struct statistic		*stat_eh_reset;
> >>    
> >>
> >
> >NACK.  pretty much all of this is generic and doesn't belong into an LLDD.
> >We already had this statistics things with emulex and they added various
> >bits to the core in response.
> >
> >
> >  
> >
> Agreed. It's not necessarily up to LLDDs to keep track of request sizes, 
> request latencies, I/O queue utilization, and error recovery conditions 
> by means of statistics. This could or maybe should be done in a more 
> central spot.
> 
> With regard to latencies, it might make some difference, though, how 
> many layers are in between that cause additional delays. Then the 
> question is which latency one wants to measure.

even if the LLDD measures these, the stats belong a level up, so that
all LLDD's export the same. I think you got half of Christophs point,
but not this last bit: even when it's the LLDD that needs to measure the
stat, it still shouldn't be LLDD specific, and thus defined one if not
two layers up. 

