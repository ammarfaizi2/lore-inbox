Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261346AbTDQPxn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 11:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261413AbTDQPxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 11:53:42 -0400
Received: from waste.org ([209.173.204.2]:18564 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261346AbTDQPxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 11:53:39 -0400
Date: Thu, 17 Apr 2003 11:05:30 -0500
From: Matt Mackall <mpm@selenic.com>
To: Timothy Miller <miller@techsource.com>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] only use 48-bit lba when necessary
Message-ID: <20030417160530.GD23277@waste.org>
References: <200304041203_MC3-1-3302-C615@compuserve.com> <20030417142020.GB23277@waste.org> <3E9EC71B.5000901@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9EC71B.5000901@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 17, 2003 at 11:24:11AM -0400, Timothy Miller wrote:
> 
> >>Yes, but:
> >>
> >>  if (expr1 && expr2)
> >>     var = true;
> >>  else
> >>     var = false;
> >>
> >>is usually better turned into something that avoids jumps
> >>when it's safe to evaluate both parts unconditionally:
> >>
> >>  var = (expr1 != 0) & (expr2 != 0);
> >>
> >>or (if you can stand it):
> >>
> >>  var = !!expr1 & !!expr2;
> >
> >Such ugly transformations are a job for compiler writers and may
> >occassionally be acceptable in some critical paths. The IO path, which
> >is literally dozens of function calls deep from read()/write() to
> >driver methods, does not qualify.
> 
> What's ugly about them? 

It doesn't pass the test of "would I use it if I didn't think it was
faster?"

As I pointed out, your variant is not faster with a reasonable
compiler, only less obvious. And none of this sort of optimization
will ever be measurably better in the IO path anyway. But every one of
these false optimizations is a barrier to the understanding that will
allow real cleanups to make fundamental improvements.

-- 
Matt Mackall : http://www.selenic.com : of or relating to the moon
