Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932397AbWHGXai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932397AbWHGXai (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 19:30:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWHGXai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 19:30:38 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23252 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932397AbWHGXah (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 19:30:37 -0400
Date: Tue, 8 Aug 2006 01:30:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>,
       Shem Multinymous <multinymous@gmail.com>, Robert Love <rlove@rlove.org>,
       Jean Delvare <khali@linux-fr.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, torvalds@osdl.org
Subject: timeout nonsense [was Re: [PATCH 04/12] hdaps: Correct readout and remove nonsensical attributes]
Message-ID: <20060807233020.GH2759@elf.ucw.cz>
References: <11548492171301-git-send-email-multinymous@gmail.com> <11548492543835-git-send-email-multinymous@gmail.com> <20060807140721.GH4032@ucw.cz> <41840b750608070930p59a250a4l99c07260229dda8e@mail.gmail.com> <20060807182047.GC26224@atjola.homenet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060807182047.GC26224@atjola.homenet>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> > >> +     int total, ret;
> > >> +     for (total=READ_TIMEOUT_MSECS; total>0; total-=RETRY_MSECS) {
> > >
> > >Could we go from 0 to timeout, not the other way around?
> > 
> > Sure.
> > (That's actually vanilla hdapsd code, moved around...)
> 
> Maybe you could convert that to sth. like this along the way?
> 
> int ret;
> unsigned long timeout = jiffies + msec_to_jiffies(READ_TIMEOUT_MSECS);
> for (;;) {
> 	ret = thinkpad_ec_lock();
> 	if (ret)
> 		return ret;
> 	ret = __hdaps_update(0);
> 	thinkpad_ec_unlock();
> 
> 	if (ret != -EBUSY)
> 		return ret;

[imagine TIMEOUT_MSEC pause here, SMM does its job?]

> 	if (time_after(timeout, jiffies))
> 		break;
> 	msleep(RETRY_MSECS);
> }
> return ret;
> 
> Rationale: http://lkml.org/lkml/2005/7/14/133 - it's also listed on the
> kerneljanitors todo list.

Please don't. New variant is _wrong_. Someone should tell
kerneljanitors :-) ... aha, and Linus.

Minimal fix would be to run one more iteration after timeout.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
