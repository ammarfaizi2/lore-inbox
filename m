Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267194AbSLECwN>; Wed, 4 Dec 2002 21:52:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267195AbSLECwN>; Wed, 4 Dec 2002 21:52:13 -0500
Received: from fly.hiwaay.net ([216.180.54.1]:20749 "EHLO mail.hiwaay.net")
	by vger.kernel.org with ESMTP id <S267194AbSLECwM>;
	Wed, 4 Dec 2002 21:52:12 -0500
Date: Wed, 4 Dec 2002 20:59:45 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: linux-kernel@vger.kernel.org
Subject: Re: #! incompatible -- binfmt_script.c broken?
Message-ID: <20021204205945.A233182@hiwaay.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: HiWAAY Internet Services
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Matthias Andree <matthias.andree@gmx.de> said:
>Nope. It cannot be correct if it breaks compatibility without giving us
>any advantage.

Compatibility with _what_?  Linux works exactly the same as Tru64 Unix
for example - it supplies everything after the program to execute as the
first argument.  Are you going to make the kernel honor the setting of
the IFS environment variable?  Should it split only on space?  What
about tab?  Or $LANG (maybe space is different in different character
sets)?

The difference is that Tru64's /bin/sh (and /usr/bin/posix/sh and
/usr/bin/ksh) stops processing the argument and continues without error
after it hits a (single or double) dash and a space, while bash (and
pdksh and ash and zsh) don't handle that.

Try the following under your shell.  On Solaris and Tru64 sh and ksh, it
is handled with no error.  Under bash (on Linux, Solaris, and Tru64), it
returns an error:

$ set "-- xyzzy"
$ echo $?

According to SUSv3, bash is not compliant, because for set, under the
section "CONSEQUENCES OF ERRORS" is listed "None." and the "EXIT STATUS"
is "Zero."

Fix the shell(s).
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
