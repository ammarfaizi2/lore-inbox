Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272011AbTHOWLr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 18:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272052AbTHOWLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 18:11:46 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:63240 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S272011AbTHOWLp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 18:11:45 -0400
Date: Fri, 15 Aug 2003 23:11:41 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Ed L Cashin <ecashin@uga.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] do_wp_page: BUG on invalid pfn
Message-ID: <20030815231141.F21529@flint.arm.linux.org.uk>
Mail-Followup-To: Ed L Cashin <ecashin@uga.edu>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Rusty Russell <rusty@rustcorp.com.au>
References: <20030815184720.A4D482CE79@lists.samba.org> <877k5e8vwe.fsf@uga.edu> <20030815223912.E21529@flint.arm.linux.org.uk> <87smo27fqq.fsf@uga.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <87smo27fqq.fsf@uga.edu>; from ecashin@uga.edu on Fri, Aug 15, 2003 at 05:50:05PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 05:50:05PM -0400, Ed L Cashin wrote:
> On i386 WARN_ON calls dump_stack, but BUG just prints some minimal
> helpful info on the console, like this:
> 
> ------------[ cut here ]------------
> kernel BUG at kernel/any.c:36!
> invalid operand: 0000 [#1]

BUG causes an exception, which calls die(), which in turn calls
handle_BUG(), and this indeed does print the first two lines of the
above.  die() goes on to print the 3rd line, but it also goes on
to call show_registers() which should print the registers and
calltrace as well.

Maybe you've found a bug in show_registers() ?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

