Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbTFLQeW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 12:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTFLQeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 12:34:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32524 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264879AbTFLQeW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 12:34:22 -0400
Date: Thu, 12 Jun 2003 09:47:46 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
cc: John M Flinchbaugh <glynis@butterfly.hjsoft.com>,
       <linux-kernel@vger.kernel.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Maneesh Soni <maneesh@in.ibm.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.70-bk16: nfs crash
In-Reply-To: <20030612163527.GD1438@in.ibm.com>
Message-ID: <Pine.LNX.4.44.0306120945170.2742-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 12 Jun 2003, Dipankar Sarma wrote:
> 
> That should work. However, I do have once concern. At the generic
> list macro level, we don't know if the lockfree traversal is being
> done in forward or backward direction.

Sure we do. We do have backwards list traversal, but it's already not 
available for the RCU case (ie we have "list_for_each_entry_rcu()", but we 
don't have "list_for_each_entry_reverse_rcu()").

Of course, somebody may be using the non-RCU versions of the list 
traversal macros on a RCU list, but that would be a bug anyway.

		Linus

