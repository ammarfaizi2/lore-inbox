Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbTFFHv0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264703AbTFFHv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:51:26 -0400
Received: from dp.samba.org ([66.70.73.150]:9128 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264668AbTFFHvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:51:22 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: __check_region in ide code?
Date: Fri, 06 Jun 2003 17:34:24 +1000
Message-Id: <20030606080454.89EC12C018@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

	I notice that drivers/ide/ide-probe.c's hwif_check_region()
still uses check_region().  If it really does want to use it to probe
and not reserve, I think we should stop it warning there.

	There's nothing inherently *wrong* with check_region, it's
just deprecated to trap the old (now racy) idiom of "if
(check_region(xx)) reserve_region(xx)".  There's no reason not to
introduce a probe_region if IDE really wants it.

Of course, some people will start "fixing" drivers by
s/check_region/probe_region/ when we do this, but that's the risk we
take.

It should also allow us to easily get rid of that stupid warning in
ksyms.c...

Thoughts?
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
