Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVF0SFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVF0SFU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 14:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVF0SFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 14:05:20 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:14281 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261393AbVF0SFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 14:05:14 -0400
Date: Mon, 27 Jun 2005 20:05:08 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ray Bryant <raybry@engr.sgi.com>
Cc: Kirill Korotaev <dev@sw.ru>, Christoph Lameter <christoph@lameter.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [RFC] Fix SMP brokenness for PF_FREEZE and make freezing usable for other purposes
Message-ID: <20050627180507.GA28815@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.62.0506241316370.30503@graphe.net> <1104805430.20050625113534@sw.ru> <42BFA591.1070503@engr.sgi.com> <20050627131709.GA30467@atrey.karlin.mff.cuni.cz> <42C01455.7020803@engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C01455.7020803@engr.sgi.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Should be very easy to solve with one semaphore. Simply make swsusp
> >wait until all migrations are done.  
> 
> This may not be needed.  If I understand things correctly, the system
> won't suspsend until all tasks have returned from system calls and end
> up in the refrigerator.  So if a memory migration is  running when
> someone tries to suspend the system, the suspend won't
> occur until the memory migration system call returns.
> 
> Is that correct?

No, because now migration tries to using same freezer
mechanism. Oops. Semaphore solves it nicely....

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
