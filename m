Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263197AbUCYPfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 10:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUCYPfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 10:35:37 -0500
Received: from speech.braille.uwo.ca ([129.100.109.30]:32961 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id S263197AbUCYPf2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 10:35:28 -0500
To: linux-kernel@vger.kernel.org
Subject: help needed with acquire/release_console_sem() problem.
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: Thu, 25 Mar 2004 10:35:28 -0500
Message-ID: <x74qsddjnj.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks:  I am hoping someone may be able to help me with a
problem I have been experiencing since the release of 2.6.3.  It
appears that because of the likeliness of race conditions occuring
while accessing console services acquire_console_sem() and
release_console_sem() were placed around sections of code which could
lead to these races.

In my speakup console code I tried to put the same functions around
possible problem code with the result that it locks up the computer to
the point of a hardware reset being necessary.  I have placed the code
in my functions for cutting and pasting portions of screen memory
which is where the new changes address the problem to some extent in
the kernel code.  The comments to release_console_sem() state that the
functions are safe and may be called from any context but either that
isn't true or because I am in kernelspace I cannot schedule() off.  I
am not exactly sure what the reasoning is or how to get around the
situation so if anyone has any suggestions I'd love to hear about it.

What I currently do is mark portions of screen memory and then call
set_selection and paste_selection with the marked region of memory
which is what other functions seem to do to provide copy and paste
facilities.  I cannot just ignore the situation because the acquire
and release_console_sem() calls have been placed around portions of
that code as well such as clear_selection and paste_selection().

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
