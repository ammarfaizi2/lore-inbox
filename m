Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264405AbUEIWSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264405AbUEIWSX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 18:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264402AbUEIWSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 18:18:23 -0400
Received: from ausmtp01.au.ibm.com ([202.81.18.186]:65471 "EHLO
	ausmtp01.au.ibm.com") by vger.kernel.org with ESMTP id S264405AbUEIWSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 18:18:11 -0400
Subject: Re: 2.6.6-rc3-mm2
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andi Kleen <ak@muc.de>
Cc: Andy Lutomirski <luto@myrealbox.com>, "R. J. Wysocki" <rjwysocki@sisk.pl>,
       Andrew Morton <akpm@osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040509133231.GA25195@colin2.muc.de>
References: <fa.gcf87gs.1sjkoj6@ifi.uio.no> <fa.freqmjk.11j6bhe@ifi.uio.no>
	 <409D3507.2030203@myrealbox.com>  <20040509133231.GA25195@colin2.muc.de>
Content-Type: text/plain
Message-Id: <1084141013.28220.8.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 10 May 2004 08:16:53 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-05-09 at 23:32, Andi Kleen wrote:
> It is all the fault of Move-saved_command_line-to-init-mainc.patch
> which unfortunately has been in -mm* for some time.
> 
> It simply breaks all boot arguments on x86-64.

How about debugging a known problem instead of whining how your arch was
broken by a simple change required to consolidate early parameter
parsing sanely?

I suspect that the problem is caused by x86_64 not saving the
commandline correctly, and this change has merely made the bug worse.

You copy the command line to saved_command_line twice: once in head64.c
and once in setup.c.  Why?  In head64.c you don't terminate it, in
setup.c you do.  Which is right?  There are printks of
saved_command_line in head64.c and main.c, what do they say?

I don't have an x86_64 box, and I ask *again* if someone who does can
take a look at the problem...

Rusty.
-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

