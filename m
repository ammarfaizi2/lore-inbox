Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751463AbWAKMv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751463AbWAKMv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWAKMv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:51:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:58573 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751472AbWAKMv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:51:57 -0500
Subject: Re: OT: fork(): parent or child should run first?
From: Arjan van de Ven <arjan@infradead.org>
To: lgb@lgb.hu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060111123745.GB30219@lgb.hu>
References: <20060111123745.GB30219@lgb.hu>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Jan 2006 13:51:50 +0100
Message-Id: <1136983910.2929.39.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 13:37 +0100, Gábor Lénárt wrote:
> Hello,
> 
> The following problem may be simple for you, so I hope someone can answer
> here. We've got a complex software using child processes and a table
> to keep data of them together, like this:
> 
> childs[n].pid=fork();
> 
> where "n" is an integer contains a free "slot" in the childs struct array.
> 
> I also handle SIGCHLD in the parent and signal handler  searches the childs
> array for the pid returned by waitpid(). However here is my problem. The
> child process can be fast, ie exits before scheduler of the kernel give
> chance the parent process to run, so storing pid into childs[n].pid in the
> parent context is not done yet. Child may exit, than scheduler gives control
> to the signal handler before doing the store of the pid (if child run for
> more time, eg 10 seconds it works of course). So it's impossible to store
> child pids and search by that information in eg the signal handler? It's
> quite problematic, since the code uses blocking I/O a lot, so other
> solutions (like searching in childs[] in the main program and not in signal
> handler) would require to recode the whole project. The problem can be
> avoided with having a fork() run the PARENT first, but I thing this is done
> by the scheduler so it's a kernel issue. Also the problem that source should
> be portable between Linux and Solaris ...

you just cannot depend on which would run first, child or parent. Even
if linux would do it the other way around, you have no guarantee. Think
SMP or Dual Core processors and time slices and cache misses... your
code just HAS to be able to cope with it. Even on solaris ;)


