Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbWDMW4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbWDMW4i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWDMW4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 18:56:38 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:42710 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751163AbWDMW4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 18:56:37 -0400
Subject: Re: PROBLEM: pthread-safety bug in write(2) on Linux 2.6.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Dan Bonachea <bonachead@comcast.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0604131531440.3701@g5.osdl.org>
References: <6.2.5.6.2.20060412173852.033dbb90@cs.berkeley.edu>
	 <20060412214613.404cf49f.akpm@osdl.org> <443DE2BD.1080103@yahoo.com.au>
	 <Pine.LNX.4.64.0604130750240.14565@g5.osdl.org>
	 <1144965022.12387.23.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0604131531440.3701@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 14 Apr 2006 00:05:49 +0100
Message-Id: <1144969549.12387.33.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-04-13 at 15:40 -0700, Linus Torvalds wrote:
> > Outside of O_APPEND the specification says only that
> > - The write starts at the file position
> > - The file position is updated before the syscall returns
> > 
> > It makes no other guarantee I can see.
> 
> Right. I think this is purely a "quality of implementation" issue. We 
> already follow the spec, the question is whether we want to be better than 
> that.

Quality for whom ? There is a measurable cost to all that extra locking
which will hurt everyone. Given existing kernels don't make the
guarantee and SuS v3 does not make the guarantee the apps that need it
will continue to do the extra work themselves anyway.

I'd say the existing approach is the best quality of implementation for
those needing performance and that the cost for those needing ordering
guarantees in Linux is already astoundingly low thanks to the excellent
work done on futex based posix locking in glibc. I can choose to pay the
costs today, if we do extra locking I cannot opt out.

And of course I too would like to know if anyone is hitting O_APPEND
examples of this problem and if so on what fs ....

Alan

