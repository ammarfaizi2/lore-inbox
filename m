Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261623AbTDQOI1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 10:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbTDQOI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 10:08:27 -0400
Received: from waste.org ([209.173.204.2]:64997 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261623AbTDQOI0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 10:08:26 -0400
Date: Thu, 17 Apr 2003 09:20:21 -0500
From: Matt Mackall <mpm@selenic.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] only use 48-bit lba when necessary
Message-ID: <20030417142020.GB23277@waste.org>
References: <200304041203_MC3-1-3302-C615@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304041203_MC3-1-3302-C615@compuserve.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 12:02:00PM -0500, Chuck Ebbert wrote:
> Juan Quintela wrote:
> 
> 
> >Reason is that:
> >
> >if (expr)
> >   var = true;
> >else
> >   var = false;
> >
> >is always a bad construct.
> >
> >var = expr;
> >
> >is a better construct to express that meaning.
> 
> 
>  Yes, but:
> 
>    if (expr1 && expr2)
>       var = true;
>    else
>       var = false;
> 
> is usually better turned into something that avoids jumps
> when it's safe to evaluate both parts unconditionally:
> 
>    var = (expr1 != 0) & (expr2 != 0);
> 
> or (if you can stand it):
> 
>    var = !!expr1 & !!expr2;

Such ugly transformations are a job for compiler writers and may
occassionally be acceptable in some critical paths. The IO path, which
is literally dozens of function calls deep from read()/write() to
driver methods, does not qualify.

FYI, GCC as of 3.2.3 doesn't yet reduce the if(...) form to branchless code
but the & and && versions come out the same with -O2.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
