Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751300AbWGJJ6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751300AbWGJJ6f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGJJ6f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:58:35 -0400
Received: from canuck.infradead.org ([205.233.218.70]:43455 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S1751300AbWGJJ6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:58:34 -0400
Subject: Re: AVR32 architecture patch against Linux 2.6.18-rc1 available
From: David Woodhouse <dwmw2@infradead.org>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Thomas Gleixner <tglx@linutronix.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, drepper@redhat.com
In-Reply-To: <20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
References: <20060706105227.220565f8@cad-250-152.norway.atmel.com>
	 <20060706021906.1af7ffa3.akpm@osdl.org>
	 <20060706120319.26b35798@cad-250-152.norway.atmel.com>
	 <20060706031416.33415696.akpm@osdl.org>
	 <20060710110325.3b9a8270@cad-250-152.norway.atmel.com>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jul 2006 10:57:33 +0100
Message-Id: <1152525453.3373.9.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.6.dwmw2.1) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-07-10 at 11:03 +0200, Haavard Skinnemoen wrote:
+	.global	__sys_pselect6
+	.type	__sys_pselect6,@function
+__sys_pselect6:
+	pushm	lr
+	st.w	--sp, ARG6
+	rcall	sys_pselect6
+	sub	sp, -4
+	popm	pc


sys_pselect6() is just a hackish workaround for the fact that most
architectures don't allow seven-argument syscalls. Having your own
workaround in assembly, which then calls sys_pselect6(), seems a little
odd -- why not call sys_pselect7() directly instead from your assembly
wrapper?

Stop a moment and work out precisely what the best way to pass the
arguments _is_ if you have only 5 registers and the stack, perhaps.

-- 
dwmw2

¹ Note that I'm just _asking_ -- the answer "Uli doesn't want to support
anything but the basic 6-argument sys_pselect6() in glibc" is an
acceptable answer on your part.


