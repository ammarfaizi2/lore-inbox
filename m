Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290308AbSAPA45>; Tue, 15 Jan 2002 19:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290310AbSAPA4o>; Tue, 15 Jan 2002 19:56:44 -0500
Received: from 12-234-95-123.client.attbi.com ([12.234.95.123]:55656 "HELO
	hellmouth.digitalvampire.org") by vger.kernel.org with SMTP
	id <S289804AbSAPAzE>; Tue, 15 Jan 2002 19:55:04 -0500
To: Michal Jaegermann <michal@harddata.com>
Cc: torvalds@transmeta.com, marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix two bugs in lib/vsprintf.c
In-Reply-To: <87advgrmnh.fsf@love-shack.home.digitalvampire.org> <20020115172010.A26769@mail.harddata.com>
From: Roland Dreier <roland@digitalvampire.org>
Date: 15 Jan 2002 16:54:57 -0800
In-Reply-To: Michal Jaegermann's message of "Tue, 15 Jan 2002 17:20:10 -0700"
Message-ID: <876663ru72.fsf@love-shack.home.digitalvampire.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michal" == Michal Jaegermann <michal@harddata.com> writes:

    Michal> On Tue, Jan 15, 2002 at 01:25:38AM -0800, Roland Dreier wrote:
    Roland> The below patch fixes two bugs in lib/vsprintf.c's
    Roland> implementation of vsscanf().

    Michal> If we are looking at these things I have some gnawing
    Michal> suspicions that a constant 0xFFFFFFFFUL at line 489 of
    Michal> lib/vsprintf.c in this function:

    int vsprintf(char *buf, const char *fmt, va_list args)
    {
            return vsnprintf(buf, 0xFFFFFFFFUL, fmt, args);
    }

    Michal> was really meant to be (size_t)(-1).  It is not the same
    Michal> if a platform is not 32 bits.  Roland, what do you think?

You are probably right, although I can't see it making much practical
difference (unlike the bugs I fixed, which actually bit me :)  Still,
it wouldn't hurt to fix it.

R.
-- 
Roland Dreier                                <roland@digitalvampire.org>
GPG Key fingerprint = A89F B5E9 C185 F34D BD50  4009 37E2 25CC E0EE FAC0
