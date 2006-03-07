Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWCGCMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWCGCMw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 21:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWCGCMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 21:12:52 -0500
Received: from kanga.kvack.org ([66.96.29.28]:50890 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S932304AbWCGCMv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 21:12:51 -0500
Date: Mon, 6 Mar 2006 21:07:36 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Dan Aloni <da-x@monatomic.org>
Cc: "David S. Miller" <davem@davemloft.net>, drepper@gmail.com,
       linux-kernel@vger.kernel.org
Subject: Re: Status of AIO
Message-ID: <20060307020736.GW20768@kvack.org>
References: <20060306233300.GR20768@kvack.org> <20060306.162444.107249907.davem@davemloft.net> <20060307004237.GT20768@kvack.org> <20060306.165129.62204114.davem@davemloft.net> <20060307013915.GU20768@kvack.org> <20060307020411.GA21626@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060307020411.GA21626@localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:04:11AM +0200, Dan Aloni wrote:
> This somehow resembles the scatter-gatter lists already used in some 
> subsystems such as the SCSI sg driver. 

None of the iovecs are particularly special.  What's special here is that 
particulars of the container make the fast path *cheap*.

> BTW you have to make these pages Copy-On-Write before this procedure 
> starts because you wouldn't want it to accidently fill the zero page, 
> i.e. the VM will have to supply a unique set of pages otherwise it 
> messes up.

No, that would be insanely expensive.  There's no way this would be done 
transparently to the user unless we know that we're blocking until the 
transmit is complete.

		-ben
-- 
"Time is of no importance, Mr. President, only life is important."
Don't Email: <dont@kvack.org>.
