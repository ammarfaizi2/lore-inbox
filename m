Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWHXMc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWHXMc6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 08:32:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbWHXMc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 08:32:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:55962 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751199AbWHXMc4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 08:32:56 -0400
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] dubious process system time.
References: <20060824121825.GA4425@skybase>
From: Andi Kleen <ak@suse.de>
Date: 24 Aug 2006 14:32:55 +0200
In-Reply-To: <20060824121825.GA4425@skybase>
Message-ID: <p731wr6fh54.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky <schwidefsky@de.ibm.com> writes:

> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> [patch] dubious process system time.
> 
> The system time that is accounted to a process includes the time spent
> in three different contexts: normal system time, hardirq time and
> softirq time. To account hardirq time and sortirq time to a process
> seems wrong, because the process could just happen to run when the
> interrupt arrives that was caused by an i/o for a completly different
> process. And the sum over stime and cstime of all processes won't
> match cputstat->system either. 
> The following patch changes the accounting of system time so that
> hardirq and softirq time are not accounted to a process anymore.

So where does it get accounted then? It has to be accounted somewhere.
Sounds like a quite radical change to me, might break a lot of 
existing assumptions.

-Andi
