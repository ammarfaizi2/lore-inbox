Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWFZSqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWFZSqr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 14:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932643AbWFZSqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 14:46:47 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:2519 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932642AbWFZSqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 14:46:47 -0400
Date: Mon, 26 Jun 2006 11:46:37 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: Ravikiran G Thirumalai <kiran@scalex86.org>, akpm@osdl.org,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: remove __read_mostly?
In-Reply-To: <20060626113950.571d3e4c.pj@sgi.com>
Message-ID: <Pine.LNX.4.64.0606261142560.32190@schroedinger.engr.sgi.com>
References: <20060625115736.d90e1241.akpm@osdl.org> <20060625211929.GA3865@localhost.localdomain>
 <20060626113950.571d3e4c.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jun 2006, Paul Jackson wrote:

> In other words, the name __read_mostly is a little misleading, in my
> book.  That name only suggests read much more than written.  In your
> words:
> 
>     something like 99:1 read


99:1 may be too small a ratio. 

A read_mostly marked variable should be changed rarely (meaning is 
is extremely unlikely that his is going to change) but read frequently.

F.e. configuration data for timer operations, number of possible 
processors and stuff like that.

If we would make the operation to write to the read_mostly section more 
expensive (by f.e. replicating the data per node) then this would hold off 
the uses that are changing too frequently.
