Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129815AbQLLNIl>; Tue, 12 Dec 2000 08:08:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130551AbQLLNId>; Tue, 12 Dec 2000 08:08:33 -0500
Received: from [212.17.18.2] ([212.17.18.2]:57873 "EHLO technoart.net")
	by vger.kernel.org with ESMTP id <S129815AbQLLNIZ>;
	Tue, 12 Dec 2000 08:08:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
To: kuznet@ms2.inr.ac.ru
Subject: Re: Bad behavior of recv on already closed sockets.
Date: Tue, 12 Dec 2000 18:38:46 +0600
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200012111935.WAA11862@ms2.inr.ac.ru>
In-Reply-To: <200012111935.WAA11862@ms2.inr.ac.ru>
MIME-Version: 1.0
Message-Id: <0012121838460H.18833@dyp.perchine.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> > Looks like it tries to read on socket which is already closed from other
> > side. And it seems like recv did not return in this case. Is this OK, or
> > kernel bug?
>
> This smells like an unknown bug in kernel.
>
> It is unknown, hence there is no workaround (but upgrading to 2.4).
>
> It would be better to understand the issue f.e. trying to restore
> the history of this descriptor.

How to do this? I mean what should I do to provide you with more information?

> > On the other side I see entries like this:
> > httpd      4260          root    4u  IPv4 12173018       TCP
> > 127.0.0.1:3994->127.0.0.1:5432 (CLOSE_WAIT)
> >
> > And again. There is no any corresponding postmaster process. Does anyone
> > has such expirience before? And what can be the reason of such strange
> > things.
>
> And this is bug in the application, which forgot to close file.
> Descriptor leakage in httpd or it is blocked at some another job.
>
> But remembering about the first case, I am not so sure.
> What does httpd make this time?

Hmmm... It's like this. There is an apache with mod_perl. Actually this 
connection should be closed, if there was a failure, but somehow it is not. 
And possibly it is a fd in DBD::Pg code (or libpq code). I will think how to 
check this...

-- 
Sincerely Yours,
Denis Perchine

----------------------------------
E-Mail: dyp@perchine.com
HomePage: http://www.perchine.com/dyp/
FidoNet: 2:5000/120.5
----------------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
