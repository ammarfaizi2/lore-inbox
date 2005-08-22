Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751264AbVHVVlv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264AbVHVVlv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 17:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbVHVVlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 17:41:51 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:4738 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751264AbVHVVlu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 17:41:50 -0400
Date: Mon, 22 Aug 2005 15:06:18 +0200
From: Andi Kleen <ak@suse.de>
To: Howard Chu <hyc@symas.com>
Cc: Florian Weimer <fw@deneb.enyo.de>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: sched_yield() makes OpenLDAP slow
Message-ID: <20050822130618.GA19007@wotan.suse.de>
References: <43057641.70700@symas.com.suse.lists.linux.kernel> <17157.45712.877795.437505@gargle.gargle.HOWL.suse.lists.linux.kernel> <430666DB.70802@symas.com.suse.lists.linux.kernel> <p73oe7syb1h.fsf@verdi.suse.de> <87fyt3vzq0.fsf@mid.deneb.enyo.de> <43095E10.3010003@symas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43095E10.3010003@symas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> processes (PTHREAD_SCOPE_SYSTEM). The previous comment about slapd only 
> needing to yield within a single process is inaccurate; since we allow 
> slapcat to run concurrently with slapd (to allow hot backups) we need 
> BerkeleyDB's locking/yield functions to work in System scope.

That's broken by design - it means you can be arbitarily starved 
by other processes running in parallel. You are basically assuming
your application is the only thing running on the system
which is wrong. Also there are enough synchronization primitives
that can synchronize multiple processes without making
such broken assumptions.

-Andi

