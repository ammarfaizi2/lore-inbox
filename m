Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262636AbTD3XlD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbTD3XlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:41:03 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:57102
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262636AbTD3XlC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:41:02 -0400
Subject: Re: must-fix list for 2.6.0
From: Robert Love <rml@tech9.net>
To: Andrew Morton <akpm@digeo.com>
Cc: Rick Lindsley <ricklind@us.ibm.com>, solt@dns.toxicfilms.tv,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com
In-Reply-To: <20030430162108.09dbd019.akpm@digeo.com>
References: <20030430121105.454daee1.akpm@digeo.com>
	 <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
	 <20030430162108.09dbd019.akpm@digeo.com>
Content-Type: text/plain
Message-Id: <1051746805.17629.35.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2 (1.3.2-1) (Preview Release)
Date: 30 Apr 2003 19:53:25 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-30 at 19:21, Andrew Morton wrote:

> A few kernels ago, OpenOffice would take sixty seconds to just flop down a
> menu if there was a kernel build happening at the same time.  That is just
> utterly broken, so if we're going to leave the sched.c code as-is then we
> *require* that all applications be updated to not spin on sched_yield.

Just as a note (I know its not an excuse), Red Hat 9 has Open Office
with the dumb sched_yield() calls removed.  It runs quite nice.

> Has anyone looked at what Andrea did in -aa?  I assume some suitable
> compromise was achieved there.

Well, his base O(1) scheduler does not have 2.5's sched_yield()... but
he has a patch (I guess that he wrote) on top which changes the
semantics a bit.  It looks like he drops the task one priority level
each call, but if it is ever to-be-moved to a queue all by its lonesome,
the task is put on the expired array instead.

Also, he has a check at the start that, if it is in a queue all by
itself (even before it is moved) the call just returns.

Not sure what all these changes add up to...

	Robert Love

