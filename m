Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315175AbSEEDEu>; Sat, 4 May 2002 23:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315809AbSEEDEt>; Sat, 4 May 2002 23:04:49 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:33540 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S315175AbSEEDEs>;
	Sat, 4 May 2002 23:04:48 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre8aa2 
In-Reply-To: Your message of "Sun, 05 May 2002 09:34:25 +1000."
             <3CD47001.4DF960D2@eyal.emu.id.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 05 May 2002 13:04:37 +1000
Message-ID: <2661.1020567877@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 05 May 2002 09:34:25 +1000, 
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>I agree with this. However, since this driver cannot be built, and
>since the latest modutils will exit badly for unresolved, I strongly
>believe that the comx driver should not be offered (disable it in
>the Config.in) until it is fixed - 2.4 being a stable kernel.
>
>I had to wrap 'depmod' with a script to ignore failures in order
>to get through a full build (which includes the kernel plus a few
>extra modules like NVdriver, dc395, lm_sensors).

You should not have to wrap depmod.  Standard 2.4.* modutils returns 0
for unresolved errors, for compatibility with previous behaviour.  You
have to do depmod -u to get a non-zero return code.  The -u flag was
added in modutils 2.4.7 and defaults to off.  In modutils 2.5 it will
default to on, that will break code that relies on the existing
behaviour.  I will not change modutils default behaviour in 2.4.

So why is your version of depmod breaking?  Either you are specifying
-u or your distribution has hacked depmod to default -u to on.  Check
depmod.c for variable flag_unresolved_error, it should default to 0.

