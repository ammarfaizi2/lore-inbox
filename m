Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSBSSvb>; Tue, 19 Feb 2002 13:51:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287344AbSBSSvW>; Tue, 19 Feb 2002 13:51:22 -0500
Received: from maile.telia.com ([194.22.190.16]:7423 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id <S286942AbSBSSvD>;
	Tue, 19 Feb 2002 13:51:03 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: [PATCH] hex <-> int conversion routines.
Date: Tue, 19 Feb 2002 19:49:32 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <02021915240900.00635@jakob> <3C7274BE.1030803@evision-ventures.com>
In-Reply-To: <3C7274BE.1030803@evision-ventures.com>
MIME-Version: 1.0
Message-Id: <02021919493204.00447@jakob>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static __inline__ int _hexint_byte(const char *src)
> > +{
>
> ...
>
> > +}
>
> Not worth inlining. char conversion are seldomly time critical.
ok, I removed the inline version.

> > +static __inline__ int hexint_nibble(char x)
>
> Same applies here.
I added a tiny function, __hexint_nibble() which doesn't do error checking.
it's very small and can be used inline if needed.

> > +static __inline__ char inthex_nibble(int x)
> > +{
> > +	const char* digits = "0123456789abcdef";
> > +
> > +	return digits[x & 0x0f];
> > +}
>
> perhaps better do static const char *digits.
GCC doesn't copy const strings, as opposed to other const arrays.
So it should be fine as it is. GCC also reuse duplicated strings.

Regards,
	Jakob Kemi
