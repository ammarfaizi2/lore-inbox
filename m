Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751225AbWFBGxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751225AbWFBGxS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 02:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWFBGxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 02:53:18 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:7617
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751225AbWFBGxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 02:53:18 -0400
Message-Id: <447FFCAC.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 02 Jun 2006 08:54:04 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <mingo@elte.hu>, <jeff@garzik.org>, <htejun@gmail.com>,
       <reuben-lkml@reub.net>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17-rc5-mm2
References: <20060601014806.e86b3cc0.akpm@osdl.org> <447EB4AD.4060101@reub.net> <20060601025632.6683041e.akpm@osdl.org> <447EBD46.7010607@reub.net> <20060601103315.GA1865@elte.hu> <20060601105300.GA2985@elte.hu> <447EF7A8.76E4.0078.0@novell.com> <20060601091927.3141
In-Reply-To: <20060601091927.3141
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>- Make the code robust and able to detect "unexpected" states at all
>  points through the process.  If at the end of the process we see that we
>  have encountered an unexpected state,

The problem is that the unwind is expected to end with an odd state (i.e. fail), at least until all possible root
points of execution (i.e. bottoms of call stacks) have a proper annotation forcing their parent program counter to zero
(which I don't expect to happen soon, if ever, because I think this is something difficult to prove). Thus the only
reasonable thing to do is to check whether the first level of unwinding failed.

>  - emit a diagnostic so Jan can work out if there's a way to improve
>    the unwinder in this situation

>  - do a traditional backtrace as well.

This might be a config or boot option (and might be forced on for a short while), but I generally don't think this is
helpful, given that the entire point of the added logic is to remove (useless) information (even more that if you have
to rely on the screen alone, you have to live with its limited size, and pushing out an old-style stack trace after the
unwound one would likely make part or all of it as well as the register information disappear).

Jan
