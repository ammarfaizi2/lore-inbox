Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNTsh>; Thu, 14 Dec 2000 14:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbQLNTsT>; Thu, 14 Dec 2000 14:48:19 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:58119 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S132638AbQLNTsA>;
	Thu, 14 Dec 2000 14:48:00 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012141917.WAA02918@ms2.inr.ac.ru>
Subject: Re: [PATCH] Fix poll bug
To: Guy_Bolton_King@non.agilent.COM (Guy Bolton King)
Date: Thu, 14 Dec 2000 22:17:15 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A3896B0.9567E7DA@non.agilent.com> from "Guy Bolton King" at Dec 14, 0 01:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I believe I've found an inconsistency between the behaviour of poll(2)
> and select(2); select() is restartable in the face of signals
> (sys_select() returns ERESTARTNOHAND if a signal is pending), whilst
> poll() is not (sys_poll() returns EINTR).

poll() cannot be restarted.

select() can, because state of timer is remembered.


> breaking code (or at least breaking code that expects BSD signal
> behaviour as the default,

BSD behaviour is never to restart select() (because BSD does
not update timer, it is the only possible behaviour there, otherwise
select can never terminate). Its restart in some rare cases
(when signal happens to be ignored) is small optimization,
specific only to Linux.


> which I believe is also the POSIX

Seems, POSIX behaviour is not to restart any syscall.

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
