Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262315AbVAKTgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262315AbVAKTgm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 14:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVAKTgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 14:36:42 -0500
Received: from canuck.infradead.org ([205.233.218.70]:17159 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262315AbVAKTgc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 14:36:32 -0500
Subject: Re: make flock_lock_file_wait static
From: Arjan van de Ven <arjan@infradead.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: viro@zenII.uk.linux.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <1105471004.12005.46.camel@lade.trondhjem.org>
References: <20050109194209.GA7588@infradead.org>
	 <1105310650.11315.19.camel@lade.trondhjem.org>
	 <1105345168.4171.11.camel@laptopd505.fenrus.org>
	 <1105346324.4171.16.camel@laptopd505.fenrus.org>
	 <1105367014.11462.13.camel@lade.trondhjem.org>
	 <1105432299.3917.11.camel@laptopd505.fenrus.org>
	 <1105471004.12005.46.camel@lade.trondhjem.org>
Content-Type: text/plain
Date: Tue, 11 Jan 2005 20:36:22 +0100
Message-Id: <1105472182.3917.49.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-11 at 14:16 -0500, Trond Myklebust wrote:
> > (you may think "it's only 100 bytes", well, there are 700+ other such
> > functions, total that makes over at least 70Kb of unswappable, wasted
> > memory if not more.)
> 
> A list of these 700+ unused exported APIs would be very useful so that
> we can deprecate and/or get rid of them.

http://people.redhat.com/arjanv/unused

has the list of symbols that are unused on an i386 allmodconfig based on
the -bk tree 2 days ago.


> Concerning this case, though, and to make what I said in the earlier
> mails (a lot) more explicit.
> 
> If you unexport flock_lock_file_wait(), then you might as well back out
> the entire bloody ->flock() changeset instead because keeping the
> ->flock() VFS override support without the functionality to make
> implementation practical (which is what you appear to want to do) is a
> waste of more than 70 bytes of memory.
> 
> Now please go and figure out what it is you actually want to do here.

save space most of all, and reduce bloat that is not used.
Again if you're going to use it soon, fine. If not, as you say, the
entire thing should probably go because it's a bunch of unused code,
additions to data structures and conditional branches.


