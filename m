Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290298AbSAPAVR>; Tue, 15 Jan 2002 19:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289789AbSAPAVH>; Tue, 15 Jan 2002 19:21:07 -0500
Received: from harddata.com ([216.123.194.198]:52231 "EHLO mail.harddata.com")
	by vger.kernel.org with ESMTP id <S290298AbSAPAU5>;
	Tue, 15 Jan 2002 19:20:57 -0500
Date: Tue, 15 Jan 2002 17:20:10 -0700
From: Michal Jaegermann <michal@harddata.com>
To: Roland Dreier <roland@digitalvampire.org>
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix two bugs in lib/vsprintf.c
Message-ID: <20020115172010.A26769@mail.harddata.com>
In-Reply-To: <87advgrmnh.fsf@love-shack.home.digitalvampire.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87advgrmnh.fsf@love-shack.home.digitalvampire.org>; from roland@digitalvampire.org on Tue, Jan 15, 2002 at 01:25:38AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 01:25:38AM -0800, Roland Dreier wrote:
> The below patch fixes two bugs in lib/vsprintf.c's implementation of
> vsscanf().

If we are looking at these things I have some gnawing suspicions
that a constant 0xFFFFFFFFUL at line 489 of lib/vsprintf.c
in this function:

    int vsprintf(char *buf, const char *fmt, va_list args)
    {
            return vsnprintf(buf, 0xFFFFFFFFUL, fmt, args);
    }

was really meant to be (size_t)(-1).  It is not the same if a platform
is not 32 bits.  Roland, what do you think?

  Michal
