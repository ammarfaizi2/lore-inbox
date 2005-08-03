Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVHCJTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVHCJTy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 05:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262178AbVHCJSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 05:18:06 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10987 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262175AbVHCJRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 05:17:32 -0400
Subject: Re: [PATCH 00/14] GFS
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
In-Reply-To: <20050803035618.GB9812@redhat.com>
References: <20050802071828.GA11217@redhat.com>
	 <1122968724.3247.22.camel@laptopd505.fenrus.org>
	 <20050803035618.GB9812@redhat.com>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 11:17:09 +0200
Message-Id: <1123060630.3363.10.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-03 at 11:56 +0800, David Teigland wrote:
> The point is you can define GFS2_ENDIAN_BIG to compile gfs to be BE
> on-disk instead of LE which is another useful way to verify endian
> correctness.

that sounds wrong to be a compile option. If you really want to deal
with dual disk endianness it really ought to be a runtime one (see jffs2
for example).



> > * Why use your own journalling layer and not say ... jbd ?
> 
> Here's an analysis of three approaches to cluster-fs journaling and their
> pros/cons (including using jbd):  http://tinyurl.com/7sbqq
> 
> > * +	while (!kthread_should_stop()) {
> > +		gfs2_scand_internal(sdp);
> > +
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +		schedule_timeout(gfs2_tune_get(sdp, gt_scand_secs) * HZ);
> > +	}
> > 
> > you probably really want to check for signals if you do interruptible sleeps
> 
> I don't know why we'd be interested in signals here.

well.. because if you don't your schedule_timeout becomes a nop when you
get one, which makes your loop a busy waiting one.



