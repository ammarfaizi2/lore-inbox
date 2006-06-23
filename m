Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWFWOpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWFWOpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 10:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWFWOpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 10:45:38 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:433 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750801AbWFWOpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 10:45:38 -0400
Date: Fri, 23 Jun 2006 15:45:30 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060623144530.GA32291@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Teigland <teigland@redhat.com>,
	Patrick Caulfield <pcaulfie@redhat.com>,
	Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <4497EAC6.3050003@yahoo.com.au> <1150807630.3856.1372.camel@quoit.chygwyn.com> <44980064.6040306@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44980064.6040306@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The part where you needed file_read_actor looks like pretty much a stright
> cut and paste from __generic_file_aio_read, which indicates that you might
> be exporting at the wrong level.

A definitive NACK to this export.  All other filesystems manage to use
the generic file read code so GFS should do so aswell.  And there's a technical
reason for not exporting aswell as the generic file read interface is far
too complicated already.

> Not sure about the tty_ export. Would it be better to make a generic
> printfish interface on top of it and also replace the interesting dquot.c
> gymnastics? (I don't know)

In fact neither gfs nor dquot should use it at all.  The xfs quota code
is fine without this nonsense.
