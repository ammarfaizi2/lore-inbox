Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTH1LTp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 07:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTH1LTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 07:19:45 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:52100 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263918AbTH1LTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 07:19:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16205.58701.762150.49446@gargle.gargle.HOWL>
Date: Thu, 28 Aug 2003 13:19:41 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] floppy driver cleanup
In-Reply-To: <20030827224135.75f344dd.rddunlap@osdl.org>
References: <20030827224135.75f344dd.rddunlap@osdl.org>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap writes:
 > -static void schedule_bh( void (*handler)(void*) )
 > +static void schedule_bh(void (*handler) (void *))
...
 > -		schedule_bh( (void *)(void *) handler);
 > +		schedule_bh((void *) handler);
...
 > -	schedule_bh((void *)(void *)handler);
 > +	schedule_bh((void *) handler);
...
 > -		schedule_bh( (void *)(void *) floppy_start);
 > +		schedule_bh((void *) floppy_start);
...
 > -	schedule_bh( (void *)(void *) redo_fd_request);
 > +	schedule_bh((void *) redo_fd_request);

Am I the only one having problems with code like this?
(Not Randy's, the original.)

1. void* and function pointers are not interchangeable.
   The casts should be to (void(*)(void*)) not (void*).

2. If shedule_bh() causes handler to be invoked as a
   (void(*)(void*)), then handler had better point to a
   function with exactly that prototype and nothing else.
   Fixing this also eliminates the need for the casts.

IMO changing whitespace while these issues remain is just
a waste of time.

/Mikael
