Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTFFLSG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 07:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbTFFLSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 07:18:06 -0400
Received: from holomorphy.com ([66.224.33.161]:6079 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261168AbTFFLSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 07:18:05 -0400
Date: Fri, 6 Jun 2003 04:31:28 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: __check_region in ide code?
Message-ID: <20030606113128.GC8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
	linux-kernel@vger.kernel.org
References: <20030606080454.89EC12C018@lists.samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606080454.89EC12C018@lists.samba.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 06, 2003 at 05:34:24PM +1000, Rusty Russell wrote:
> 	I notice that drivers/ide/ide-probe.c's hwif_check_region()
> still uses check_region().  If it really does want to use it to probe
> and not reserve, I think we should stop it warning there.
> 	There's nothing inherently *wrong* with check_region, it's
> just deprecated to trap the old (now racy) idiom of "if
> (check_region(xx)) reserve_region(xx)".  There's no reason not to
> introduce a probe_region if IDE really wants it.
> Of course, some people will start "fixing" drivers by
> s/check_region/probe_region/ when we do this, but that's the risk we
> take.
> It should also allow us to easily get rid of that stupid warning in
> ksyms.c...

I've actually seen IDE oops doing a racy check_region()/request_region()
on 2.4.x-test*. Either the fix I brewed up never hit mainline or there's
more than the one I hit.


-- wli
