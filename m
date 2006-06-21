Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWFUVyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWFUVyw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWFUVyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:54:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65218 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030312AbWFUVyu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:54:50 -0400
Date: Wed, 21 Jun 2006 14:54:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: nagar@watson.ibm.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC]  Disabling per-tgid stats on task exit in
 taskstats
Message-Id: <20060621145443.b58daf31.akpm@osdl.org>
In-Reply-To: <4499BDDD.3010206@engr.sgi.com>
References: <44892610.6040001@watson.ibm.com>
	<20060609010057.e454a14f.akpm@osdl.org>
	<448952C2.1060708@in.ibm.com>
	<20060609042129.ae97018c.akpm@osdl.org>
	<4489EE7C.3080007@watson.ibm.com>
	<449999D1.7000403@engr.sgi.com>
	<20060621133838.12dfa9f8.akpm@osdl.org>
	<4499BAA9.3000707@watson.ibm.com>
	<4499BDDD.3010206@engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 14:45:01 -0700
Jay Lan <jlan@engr.sgi.com> wrote:

> > Won't it suffice to make delivery of these stats best effort, with
> > userspace dealing with missing data,
> 
> How do you recover the missed data?

I suspect the best we can do is to let userspace know that data was lost. 
Is the -ENOBUFS reliable?

> > rather than risk delaying exits ? The cases where exits are so
> > frequent as in this program should be
> 
> This is very true. However, it was a 2p IA64 machine. I am too frightened to
> speak "512p"...

If we have 511 CPUs generating data faster than one CPU can handle it,
something bad will happen.  We either throttle the 511 CPUs or drop data.

