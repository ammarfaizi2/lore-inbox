Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269178AbTGJKfI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 06:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269185AbTGJKfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 06:35:08 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:59531 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S269178AbTGJKfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 06:35:02 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.5.74-mm3 - apm_save_cpus() Macro still bombs out
Date: Thu, 10 Jul 2003 12:49:27 +0200
User-Agent: KMail/1.5.9
Cc: Piet Delaney <piet@www.piet.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030708223548.791247f5.akpm@osdl.org> <200307101159.51175.schlicht@uni-mannheim.de> <20030710103022.GV15452@holomorphy.com>
In-Reply-To: <20030710103022.GV15452@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307101249.28618.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 12:30, William Lee Irwin III wrote:
> On Thu, Jul 10, 2003 at 11:59:49AM +0200, Thomas Schlichter wrote:
> > And I don't know why everybody hates my patches... ;-(

That was just fun, but OK, I forgot the 'fun' tags... ;-)

> It's not that anyone hates them, it's that
> pass 1: the semantics (0 == empty cpu set) needed preserving

Well the original code already had 2 different semantics:
In the MP case it returned the mask of currently allowed CPUs which should 
have been 1 for UP but was 0...

So as the value returned by apm_save_cpus() was only used for apm_restore_cpus
() I optimized it away. Which was just an other change of the semantics...ACK

> pass 2: remove code instead of changing redundant stuff

ACK

> NFI YTF gcc doesn't optimize out the whole shebang.
>
> At any rate, if we're pounding APM BIOS calls or apm_power_off()
> like wild monkeys there's something far more disturbing going wrong
> than 64B of code gcc couldn't optimize (it's probably due to some
> jump target being aligned to death or some such nonsense).

OK, I see you're right and your actual patch looks better to me because it 
makes the semantics consistent! So come on and let's take it into the 
tree...!

  Thomas
