Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132842AbRDIUcX>; Mon, 9 Apr 2001 16:32:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132841AbRDIUcO>; Mon, 9 Apr 2001 16:32:14 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:65028 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S132840AbRDIUcD>;
	Mon, 9 Apr 2001 16:32:03 -0400
Date: Sat, 7 Apr 2001 21:29:32 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] __init functions called by non-__init
Message-ID: <20010407212932.A34@(none)>
In-Reply-To: <200104050649.XAA22384@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200104050649.XAA22384@csl.Stanford.EDU>; from engler@csl.Stanford.EDU on Wed, Apr 04, 2001 at 11:49:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> 	1. The best case: an init function calls a non-init, which in
> 	turn calls an init:
> 
> 		void __init probe() { a(); }
> 		void a() { b(); }
> 		void __init b() { ... }

> 	in this case, is the missing __init on 'a' only a performance
> 	bug in that a's code won't be freed up?

...not neccesarily an error. If a() is being used to do stuff needed at
runtime, and only calls b() at initialzation.

> On the other hand, if I understood the rules right, this next one looks like
> a more exciting error, since an __exit routine is calling an __init routine:

Actually, it is right for subtle reasons:

__exit is only used in module case. And in module case __init functions are
not freed.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

