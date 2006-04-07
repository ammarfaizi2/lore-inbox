Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWDGU23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWDGU23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 16:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbWDGU22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 16:28:28 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:49589
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964934AbWDGU21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 16:28:27 -0400
Date: Fri, 07 Apr 2006 13:27:53 -0700 (PDT)
Message-Id: <20060407.132753.50049697.davem@davemloft.net>
To: dan@debian.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/binfmt_elf.c:maydump()
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060407180243.GA27828@nevyn.them.org>
References: <20060406.153518.60508780.davem@davemloft.net>
	<20060406.221807.114721185.davem@davemloft.net>
	<20060407180243.GA27828@nevyn.them.org>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Jacobowitz <dan@debian.org>
Date: Fri, 7 Apr 2006 14:02:43 -0400

> On Thu, Apr 06, 2006 at 10:18:07PM -0700, David S. Miller wrote:
> > How about something like the following patch?  If it's executable
> > and not written to, skip it.  This would skip the main executable
> > image and all text segments of the shared libraries mapped in.
> 
> Will this dump text segments that have been COW'd for the purposes of
> inserting a breakpoint?

Yes, and it would also dump text segments that get written
by the dynamic linker such as the .plt, which we definitely
do want.

It would also dump impure text segment cases as well.
