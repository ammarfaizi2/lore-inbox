Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289434AbSAJMve>; Thu, 10 Jan 2002 07:51:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289432AbSAJMvQ>; Thu, 10 Jan 2002 07:51:16 -0500
Received: from smtp03.wxs.nl ([195.121.6.37]:16090 "EHLO smtp03.wxs.nl")
	by vger.kernel.org with ESMTP id <S289428AbSAJMvC>;
	Thu, 10 Jan 2002 07:51:02 -0500
Subject: Re: [PATCH] Combined APM patch
From: Thomas Hood <jdthood@mail.com>
To: linux-laptop@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20020107155226.5c6409b6.sfr@canb.auug.org.au>
In-Reply-To: <20020107155226.5c6409b6.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 10 Jan 2002 07:51:05 -0500
Message-Id: <1010667066.12688.41.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just browsing the diff between my patch and Stephen's, I have
a couple of questions.

< static int			suspends_pending; /* = 0 */
---
> static int			suspends_pending;

Is it not good practice to note when the code _assumes_ zero-
initialization?  I have seen comments like these elsewhere in
the kernel sources.

< 	static int use_apm_idle; /* = 0 */
< 	static unsigned int last_jiffies; /* = 0 */
< 	static unsigned int last_stime; /* = 0 */
---
> 	static int use_apm_idle = 0;
> 	static unsigned int last_jiffies = 0;
> 	static unsigned int last_stime = 0;

Are static variables defined within functions not initialized
to zero at load time, as global static variables are?

< 			ignore_sys_suspend = 0;
---
> 			waiting_for_resume = 0;

Don't you think "ignore_sys_suspend" is a name more consistent
with the other "ignore_yadda_yadda" variable names?  Minor issue.

Everything else looks good to me.

On Sun, 2002-01-06 at 23:52, Stephen Rothwell wrote:
> This is my version of the combined APM patches;
> 
> 	Change notification order so that user mode is notified
> 		before drivers of impending suspends.
> 	Move the idling back into the idle loop.
> 	A couple of small tidy ups.
> 
> See header comments for attributions.
> 
> This works for me (including as a module).
> 
> Please test and let me know - it seems to lower my power requirements
> by about 10% on my Thinkpad (over stock 2.4.17).
> 
> http://www.canb.auug.org.au/~sfr/2.4.17-APM.1.diff

The kernel compiles fine with your patch; I'll test over the
next few days.

Thanks
Thomas




