Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933199AbWKNIUk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933199AbWKNIUk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 03:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933211AbWKNIUk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 03:20:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:36001 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933199AbWKNIUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 03:20:39 -0500
Subject: Re: [patch] irq: do not mask interrupts by default
From: Arjan van de Ven <arjan@infradead.org>
To: Ingo Molnar <mingo@redhat.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@osdl.org>, Komuro <komurojun-mbn@nifty.com>,
       tglx@linutronix.de, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1163492040.28401.76.camel@earth>
References: <Pine.LNX.4.64.0611080749090.3667@g5.osdl.org>
	 <1162985578.8335.12.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org>
	 <20061108085235.GT4729@stusta.de>
	 <7813413.118221162987983254.komurojun-mbn@nifty.com>
	 <11940937.327381163162570124.komurojun-mbn@nifty.com>
	 <Pine.LNX.4.64.0611130742440.22714@g5.osdl.org>
	 <m13b8ns24j.fsf@ebiederm.dsl.xmission.com> <1163450677.7473.86.camel@earth>
	 <m1bqnboxv5.fsf@ebiederm.dsl.xmission.com>
	 <1163492040.28401.76.camel@earth>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 14 Nov 2006 09:20:23 +0100
Message-Id: <1163492423.15249.241.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> so my patch changes the default irq-disable logic of /all/ controllers
> to "delayed disable". (IRQ chips can still override this by providing a
> different chip->disable method that just clones their ->mask method, if
> it is absolutely sure that no IRQs can be lost while masked)
> 
> So this patch has the worst-case effect of getting at most one 'extra'
> interrupt after the IRQ line has been 'disabled' - at which point the
> line will be masked for real (by the flow handler). (I updated the
> fasteoi and the simple irq flow handlers to mask the IRQ for real if an
> IRQ triggers and the line was disabled.)

since disable_irq() is used as locking against interrupt context by
several drivers (*cough* ne2000 *cough*) I am not entirely convinced
this is a good idea....



