Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129716AbQLKUGg>; Mon, 11 Dec 2000 15:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130095AbQLKUG0>; Mon, 11 Dec 2000 15:06:26 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:64273 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S129716AbQLKUGI>;
	Mon, 11 Dec 2000 15:06:08 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200012111935.WAA11862@ms2.inr.ac.ru>
Subject: Re: Bad behavior of recv on already closed sockets.
To: dyp@perchine.COM (Denis Perchine)
Date: Mon, 11 Dec 2000 22:35:21 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <0012111103060F.18833@dyp.perchine.com> from "Denis Perchine" at Dec 11, 0 08:15:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Looks like it tries to read on socket which is already closed from other
> side. And it seems like recv did not return in this case. Is this OK, or
> kernel bug?

This smells like an unknown bug in kernel.

It is unknown, hence there is no workaround (but upgrading to 2.4).

It would be better to understand the issue f.e. trying to restore
the history of this descriptor.


> On the other side I see entries like this:
> httpd      4260          root    4u  IPv4 12173018       TCP
> 127.0.0.1:3994->127.0.0.1:5432 (CLOSE_WAIT)
> 
> And again. There is no any corresponding postmaster process. Does anyone has
> such expirience before? And what can be the reason of such strange things.

And this is bug in the application, which forgot to close file.
Descriptor leakage in httpd or it is blocked at some another job.

But remembering about the first case, I am not so sure.
What does httpd make this time?

Alexey
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
