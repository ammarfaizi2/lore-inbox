Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264207AbUDGUxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 16:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbUDGUxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 16:53:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:57780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264207AbUDGUxf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 16:53:35 -0400
Date: Wed, 7 Apr 2004 13:49:25 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Kirk Reiser <kirk@braille.uwo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: help needed with acquire/release_console_sem() problem.
Message-Id: <20040407134925.3ab67fba.rddunlap@osdl.org>
In-Reply-To: <x74qsddjnj.fsf@speech.braille.uwo.ca>
References: <x74qsddjnj.fsf@speech.braille.uwo.ca>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Mar 2004 10:35:28 -0500 Kirk Reiser wrote:

| Hello folks:  I am hoping someone may be able to help me with a
| problem I have been experiencing since the release of 2.6.3.  It
| appears that because of the likeliness of race conditions occuring
| while accessing console services acquire_console_sem() and
| release_console_sem() were placed around sections of code which could
| lead to these races.
| 
| In my speakup console code I tried to put the same functions around
| possible problem code with the result that it locks up the computer to
| the point of a hardware reset being necessary.  I have placed the code
| in my functions for cutting and pasting portions of screen memory
| which is where the new changes address the problem to some extent in
| the kernel code.  The comments to release_console_sem() state that the
| functions are safe and may be called from any context

release_console_sem() comment says that.  acquire() does not.

| but either that
| isn't true or because I am in kernelspace I cannot schedule() off.  I

Why do you want to call schedule()?

| am not exactly sure what the reasoning is or how to get around the
| situation so if anyone has any suggestions I'd love to hear about it.

Are you using preempt (CONFIG_PREEMPT)?  Would it cause any
scheduling or semaphore problems or differences?

| What I currently do is mark portions of screen memory and then call
| set_selection and paste_selection with the marked region of memory
| which is what other functions seem to do to provide copy and paste
| facilities.  I cannot just ignore the situation because the acquire
| and release_console_sem() calls have been placed around portions of
| that code as well such as clear_selection and paste_selection().

I suppose that you could post some real code to see if someone
sees any problems in it.

--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)
