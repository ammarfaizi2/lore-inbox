Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280671AbRKBMjh>; Fri, 2 Nov 2001 07:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280675AbRKBMj1>; Fri, 2 Nov 2001 07:39:27 -0500
Received: from hermes.toad.net ([162.33.130.251]:45252 "EHLO hermes.toad.net")
	by vger.kernel.org with ESMTP id <S280671AbRKBMjM>;
	Fri, 2 Nov 2001 07:39:12 -0500
Subject: Re: apm suspend broken ?
From: Thomas Hood <jdthood@mail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15 (Preview Release)
Date: 02 Nov 2001 07:38:25 -0500
Message-Id: <1004704715.774.21.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Fn+Suspend (or launching "apm -s") does not ALWAYS suspend
> the laptop. Sometimes, it blanks the screen but leaves the
> lcd light on, the cpu fan is on also. Pressing Fn+D to turn
> off the lcd light completes the job and the laptop finaly
> suspends completely.

My guess is that what is happening is: apm receives the event
and notifies apmd an X.  X blanks the display and returns.
apmd processes the event and returns.  apm does suspend().
But then you hit some BIOS bug.  Or the BIOS expects the 
OS to turn off the LCD light before returning.

Does it make any difference if apmd and X are NOT running?

Stephen: Do you think it would be worth sticking a call to
apm_console_blank inside suspend() for this person to see
if it helps?

--
Thomas

P.S.  Stephen:  Should the line "ignore_normal_resume = 1;"
inside suspend() be put prior to the sti()?

