Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271931AbRIIJZC>; Sun, 9 Sep 2001 05:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271934AbRIIJYw>; Sun, 9 Sep 2001 05:24:52 -0400
Received: from colorfullife.com ([216.156.138.34]:30987 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S271931AbRIIJYu>;
	Sun, 9 Sep 2001 05:24:50 -0400
Message-ID: <002801c13911$59930880$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: "Francis Galiegue" <fg@mandrakesoft.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.9-ac10 but not only, locks_alloc_lock()
Date: Sun, 9 Sep 2001 11:25:15 +0200
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

> Not sure about one thing, though: what error code to return for
> locks_mandatory_area() on failure. It's invoked from some of the
> {do,sys}_*{read,write}*() routines and nowhere else AFAICT. I set it
to
> -ENOMEM, maybe this is not the right thing to do.

I'd put the file_lock structure on the stack. It's ~ 90 bytes long, not
too large.
Returning -ENOMEM is imho not acceptable: -ENOMEM is not listed in
SusV2, and locks_alloc_lock() internally checks for rlimits (setting
RLIM_NLIMITS to 0 and execing another app might have dangerous
sideeffects).

--
    Manfred




