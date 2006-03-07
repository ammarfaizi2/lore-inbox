Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932436AbWCGHbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932436AbWCGHbl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 02:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWCGHbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 02:31:41 -0500
Received: from noname.neutralserver.com ([70.84.186.210]:23010 "EHLO
	noname.neutralserver.com") by vger.kernel.org with ESMTP
	id S932436AbWCGHbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 02:31:41 -0500
Date: Tue, 7 Mar 2006 09:33:11 +0200
From: Dan Aloni <da-x@monatomic.org>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: "David S. Miller" <davem@davemloft.net>, drepper@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
Message-ID: <20060307073311.GA8350@localdomain>
References: <20060306233300.GR20768@kvack.org> <20060306.162444.107249907.davem@davemloft.net> <20060307004237.GT20768@kvack.org> <20060306.165129.62204114.davem@davemloft.net> <20060307013915.GU20768@kvack.org> <20060307020411.GA21626@localdomain> <20060307020736.GW20768@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307020736.GW20768@kvack.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - noname.neutralserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - monatomic.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 09:07:36PM -0500, Benjamin LaHaise wrote:
> On Tue, Mar 07, 2006 at 04:04:11AM +0200, Dan Aloni wrote:
> > This somehow resembles the scatter-gatter lists already used in some 
> > subsystems such as the SCSI sg driver. 
> 
> None of the iovecs are particularly special.  What's special here is that 
> particulars of the container make the fast path *cheap*.
> 
> > BTW you have to make these pages Copy-On-Write before this procedure 
> > starts because you wouldn't want it to accidently fill the zero page, 
> > i.e. the VM will have to supply a unique set of pages otherwise it 
> > messes up.
> 
> No, that would be insanely expensive.  There's no way this would be done 
> transparently to the user unless we know that we're blocking until the 
> transmit is complete.

Sure it can't be transparent to the user, but you can just require the user 
to perform mlock on the VMA and you get around this problem.

-- 
Dan Aloni
da-x@monatomic.org, da-x@colinux.org, da-x@gmx.net, dan@xiv.co.il
