Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282934AbRL2PBl>; Sat, 29 Dec 2001 10:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283234AbRL2PBb>; Sat, 29 Dec 2001 10:01:31 -0500
Received: from fwext.dif.dk ([130.227.136.2]:65276 "EHLO DIFPST1A.dif.dk")
	by vger.kernel.org with ESMTP id <S282934AbRL2PBU>;
	Sat, 29 Dec 2001 10:01:20 -0500
Subject: Re: [PATCH] console_loglevel broken on ia64 (and possibly other
	archs)
From: Jesper Juhl <jju@dif.dk>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
In-Reply-To: <20011224233515.B3932@elf.ucw.cz>
In-Reply-To: <3C23BD30.F8C3B2E1@dif.dk>  <20011224233515.B3932@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 29 Dec 2001 16:02:27 +0100
Message-Id: <1009638152.11066.0.camel@jju>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-24 at 23:35, Pavel Machek wrote:
> > This patch fixes the console_loglevel variable(s) so that code that
> > assumes the variables occupy continuous storage does not break (and
> > overwrite other data).
> 
> It seems to me you are adding feature? And unneeded one, also.
> 									Pavel

if you do 

echo 6 4 1 7 > /proc/sys/kernel/printk

then you will overwrite console_loglevel and the next 3 ints. If the
next 3 ints are default_message_loglevel, minimum_console_loglevel &
default_console_loglevel then all is fine, but if these are not stored
in consecutive memory then you will corrupt other data instead - which
is a bug. By turning those into an array of ints then you guarantee that
the variables will occupy consecutive storage and thus the bug is no
more!
That is the purpose of the patch.

Keith Owens has confirmed this to be a problem on IA64 and that the
patch fixes the problem. I'm not aware of other architectures having
that problem, but with this patch it is impossible for them to have a
problem, and it has no ill effects as far as I can tell.

Thank you for your feedback!


-- 
Mvh. / Best regards
Jesper Juhl - jju@dif.dk


