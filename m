Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVERBCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVERBCM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 21:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262034AbVERBCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 21:02:12 -0400
Received: from [195.23.16.24] ([195.23.16.24]:7332 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262032AbVERBB5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 21:01:57 -0400
Message-ID: <1116377959.428a936770106@webmail.grupopie.com>
Date: Wed, 18 May 2005 01:59:19 +0100
From: "" <pmarques@grupopie.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "" <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_KALLSYMS_EXTRA_PASS
References: <1116365006.9737.42.camel@localhost.localdomain>  <1116372428.428a7dccec930@webmail.grupopie.com> <1116374451.9737.47.camel@localhost.localdomain>
In-Reply-To: <1116374451.9737.47.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Originating-IP: 82.154.142.236
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Steven Rostedt <rostedt@goodmis.org>:

> On Wed, 2005-05-18 at 00:27 +0100, pmarques@grupopie.com wrote:
> 
> > You can try the very crude (but effective) way to check if this is your
> problem
> > or not. Go to scripts/kallsyms.c and change:
> > 
> > #define WORKING_SET             1024
> > 
> > to:
> > 
> > #define WORKING_SET             65536
> > 
> 
> Yep, that did the trick. Thanks.  And just to make sure, I put it back
> to 1024, recompiled, and got the error again.
> 
> > This will force kallsyms to use *all* the symbols for the compression, and
> the
> > size of the result won't be affected by the symbol positions.
> > 
> > [...]
> 
> Your patch sounds too good to not be included even if this wasn't the
> case. How come it hasn't been applied before?

This is not really the patch, its just a quick fix. The problem with this fix is
that, not only it will take a lot more memory to build the kallsyms data, it
will take about 6 seconds on a P4 2.8GHz to compress 20000 symbols which is
about the number of symbols of a i386 defconfig, IIRC.

The actual patch must still use a small working set of symbols to improve
performance, but keep the token data from the first pass to use on the second.
This will actually decrease the time for the kallsyms calculation instead of
increasing it, as the previous solution did.

I've still not written the patch because I was waiting for some confirmation
that it would have some chance of acceptance. I guess I'll just write it and
send it upstream and see how that goes.

Thanks for taking the time to confirm the problem,

--
Paulo Marques
