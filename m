Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751085AbVIWPcZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbVIWPcZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 11:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVIWPcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 11:32:25 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:54607
	"EHLO x30.random") by vger.kernel.org with ESMTP id S1751085AbVIWPcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 11:32:24 -0400
Date: Fri, 23 Sep 2005 17:31:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Valdis.Kletnieks@vt.edu
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc2-mm1 - ext3 wedging up
Message-ID: <20050923153158.GA4548@x30.random>
References: <200509221959.j8MJxJsY010193@turing-police.cc.vt.edu> <200509231036.16921.kernel@kolivas.org> <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509230720.j8N7KYGX023826@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Can you try this updated patch? I believe the blk_congestion_wait is
just wrong there, since there may be just one page being flushed. That
sounds like a longstanding bug except it normally wouldn't trigger
because the dirty levels never goes down near zero during heavy writes.

	http://www.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.14-rc1/per-task-predictive-write-throttling-3
