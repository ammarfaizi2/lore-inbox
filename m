Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291110AbSAaPj5>; Thu, 31 Jan 2002 10:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291111AbSAaPjr>; Thu, 31 Jan 2002 10:39:47 -0500
Received: from gw.sp.op.dlr.de ([129.247.188.16]:52112 "EHLO n13.sp.op.dlr.de")
	by vger.kernel.org with ESMTP id <S291110AbSAaPjm>;
	Thu, 31 Jan 2002 10:39:42 -0500
Message-ID: <3C596533.488F1470@dlr.de>
Date: Thu, 31 Jan 2002 16:39:31 +0100
From: Martin Wirth <Martin.Wirth@dlr.de>
X-Mailer: Mozilla 4.77 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5: push BKL out of llseek
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 2002, Martin Wirth wrote:
>
>void combi_mutex_lock(struct combilock *x)
.....
>       } else <---
>              x->owner=current;  
>       spin_unlock(&x->wait.lock);

Uugh, the else is wrong of course. The owner has to be set in any
case.(Just deleted some debugging code and reformatted a bit to quick
:))

A further note: Although the combilock shares some advantages with a
spin-lock (no unnecessary scheduling for short time locking) it may
behave like a semaphore on entry also if you call combi_spin_lock.
For example

       spin_lock(&slock);
       combi_spin_lock(&clock);

is a BUG because combi_spin_lock may sleep while holding slock!

Would be nice if there were some comments.

Martin Wirth
