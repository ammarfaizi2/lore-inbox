Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbUA0JOd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 04:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262745AbUA0JOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 04:14:33 -0500
Received: from ozlabs.org ([203.10.76.45]:38784 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262569AbUA0JOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 04:14:30 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16406.10170.911012.262682@cargo.ozlabs.ibm.com>
Date: Tue, 27 Jan 2004 19:56:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: davidm@hpl.hp.com
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@trained-monkey.org>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: [patch] 2.6.1-mm5 compile do not use shared extable code for
 ia64
In-Reply-To: <16405.41953.344071.456754@napali.hpl.hp.com>
References: <E1Aiuv7-0001cS-00@jaguar.mkp.net>
	<20040120090004.48995f2a.akpm@osdl.org>
	<16401.57298.175645.749468@napali.hpl.hp.com>
	<16402.19894.686335.695215@cargo.ozlabs.ibm.com>
	<16405.41953.344071.456754@napali.hpl.hp.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger writes:

> How about the attached one?  It will touch memory more when moving an
> element down, but we're talking about exception tables here, and I
> don't think module loading time would be affected in any noticable
> fashion.

Hmmm...  Stylistically I much prefer to pick up the new element,
move the others up and just drop the new element in where it should
go, rather than doing swap, swap, swap down the list.

Also, I don't think there is enough code there to be worth the bother
of trying to abstract the generic routine so you can plug in different
compare and move-element routines.  The whole sort routine is only 16
lines of code, after all.  Why not just have an ia64-specific version
of sort_extable?  That's what I thought you would do.

Regards,
Paul.
