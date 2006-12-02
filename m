Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423807AbWLBMnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423807AbWLBMnA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 07:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162990AbWLBMm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 07:42:59 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24965 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1162991AbWLBMm7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 07:42:59 -0500
Date: Sat, 2 Dec 2006 12:42:51 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org, gcc@gcc.gnu.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061202124251.GI3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk> <6911A3DA-83C4-4BE9-8553-3E960026BF51@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6911A3DA-83C4-4BE9-8553-3E960026BF51@mac.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 04:23:32AM -0500, Kyle Moffett wrote:
> On Dec 01, 2006, at 12:21:49, Al Viro wrote:
> >And that's where it gets interesting.  It would be very nice to get to
> >the following situation:
> > * callbacks are void (*)(void *)
> > * data is void *
> > * instances can take void * or pointer to object type
> > * a macro SETUP_TIMER(timer, func, data) sets callback and data  
> >and checks if func(data) would be valid.
> 
> This is where a very limited form of C++ templates would do nicely;  
> you could define something like the following:
> 
> template <typename T>
> static inline void setup_timer(struct timer_list *timer,
> 		void (*function)(T *), T *data)
> {
> 	timer->function = (void (*)(void *))function;
> 	timer->data = (void *)data;
> 	init_timer(timer);
> }
> 
> Any attempts to call it with mismatched "function" and "data"  
> arguments would display an "Unable to find matching template" error  
> from the compiler.
> 
> Unfortunately you can't get simple templated functions without  
> opening the whole barrel of monkeys involved with C++ support;  

Fortunately, you can get all checks done by gcc without involving C++ (or
related flamewars).  See original post for a way to do it in a macro
and for fsck sake, leave gcc@gcc.gnu.org out of it.

Folks, please trim the Cc.  My apologies for cross-posting in the first place,
should've double-posted instead and manually forwarded relevant followups...
