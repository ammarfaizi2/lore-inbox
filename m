Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277966AbRJIU7M>; Tue, 9 Oct 2001 16:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277968AbRJIU7C>; Tue, 9 Oct 2001 16:59:02 -0400
Received: from colorfullife.com ([216.156.138.34]:28178 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S277966AbRJIU67>;
	Tue, 9 Oct 2001 16:58:59 -0400
Message-ID: <001401c15105$544ea0d0$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "\"Kitwor\"" <kitwor@kki.net.pl>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: old exploit works!!!
Date: Tue, 9 Oct 2001 22:59:40 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Old exploit which works on kernels up to 2.2.18 (itr doesn't work on 2.2.19)
> works on 2.4.9!!
> I attach that exploit.
> [snip]
> if (check_execve(victim, filename))
> 	goto exit;
>
>  (void)waitpid(victim, NULL, WUNTRACED);
>  if (ptrace(PTRACE_CONT, victim, 0, 0)) {

It doesn't work, only the behaviour changed:
Linux now ignores the setuid bit if you try to ptrace a setuid app (idea from FreeBSD).
Up to 2.2.18 [and 2.4.0-pre?], it tried to return an error message if you try to ptrace a setuid app, and there was a race window
between the test (must be early, since it tries to return an error code) and the actual uid change. I haven't checked how it was
fixed in 2.2.19.

--
    Manfred



