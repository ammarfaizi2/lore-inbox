Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263172AbTDBV67>; Wed, 2 Apr 2003 16:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263173AbTDBV67>; Wed, 2 Apr 2003 16:58:59 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33028
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263172AbTDBV66>; Wed, 2 Apr 2003 16:58:58 -0500
Subject: Re: fairsched + O(1) process scheduler
From: Robert Love <rml@tech9.net>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030402220734.GC13168@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com>
	 <20030401164126.GA993@holomorphy.com>
	 <20030401221927.GA8904@wind.cocodriloo.com>
	 <20030402124643.GA13168@wind.cocodriloo.com>
	 <20030402163512.GC993@holomorphy.com>
	 <20030402213629.GB13168@wind.cocodriloo.com>
	 <1049319300.2872.21.camel@localhost>
	 <20030402220734.GC13168@wind.cocodriloo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049321427.2872.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 02 Apr 2003 17:10:27 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 17:07, Antonio Vargas wrote:

> Hmmm, we had some way for executing code just after an interrupt,
> but outside interrupt scope... was it a bottom half? Can you
> point me to some place where it's done?

Unfortunately uidhash_lock cannot be used from a bottom half either.

You can push it into a work queue.  See schedule_work() and the default
events queue.

> Ok, I did know m68k can do it, but wasn't sure about all other arches :)

Yep.  Everyone architecture I know of - and certainly all that Linux
support - can do atomic read/writes to a word.  Thinking about it, it
would be odd if not (two writes to a single word interleaving?).  There
are places this assumption is used.

Anything more complicated, of course, needs atomic operations or locks.

	Robert Love

