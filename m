Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289046AbSCKTZS>; Mon, 11 Mar 2002 14:25:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289226AbSCKTZI>; Mon, 11 Mar 2002 14:25:08 -0500
Received: from [195.63.194.11] ([195.63.194.11]:26635 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S289114AbSCKTY4>; Mon, 11 Mar 2002 14:24:56 -0500
Message-ID: <3C8D0447.2030404@evision-ventures.com>
Date: Mon, 11 Mar 2002 20:23:51 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Gunther Mayer <gunther.mayer@gmx.net>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19, return of taskfile
In-Reply-To: <Pine.LNX.4.10.10203110945480.10583-100000@master.linux-ide.org> <3C8CFF64.1B55CDBB@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunther Mayer wrote:

> Currently your taskfile access is hardcoded in tables in your ide patches and this is
> 
> inflexible (e.g. cannot support future commands, unknown at the time of your writing)

And vendor specific commands which they don't wan't the world to know
about and the list would be complete. Anyway thank you for this
well done clarification.

> Your "case" structures and accompanying code are considered kernel bloat, because
> it can be done in user code (with a "generic ioctl" and a "generic task file state
> machine" which surely
> can be extracted from your patch).

The worsest thing about them is that they are translating
the plain commands to some obscure internal values and vice
versa. This is making it a bit tedious to remove them directly.
And it's in esp. error prone.

The fortunate thing is that the state machine points can
be really easly identifyed. The unfortunate thing is
that there is simple that much plain poor C coding in the
drivers code that it will just take time until one can get
at this. Please see the notes inside my patches about
buffer overruns... methods called twice and modularization as well
as comments about functions passing timeout pointers, which are
taken by reusing the IRQ code path and so on...

