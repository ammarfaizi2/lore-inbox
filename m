Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310176AbSCKXPf>; Mon, 11 Mar 2002 18:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310158AbSCKXPZ>; Mon, 11 Mar 2002 18:15:25 -0500
Received: from zok.SGI.COM ([204.94.215.101]:29107 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S310153AbSCKXPI>;
	Mon, 11 Mar 2002 18:15:08 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-pre3 
In-Reply-To: Your message of "Tue, 12 Mar 2002 10:04:42 +1100."
             <3C8D380A.166A7895@eyal.emu.id.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 12 Mar 2002 10:14:35 +1100
Message-ID: <4656.1015888475@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002 10:04:42 +1100, 
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>   dep_tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
>$CONFIG_SGI_IP22
>
>Looks OK to me though. However CONFIG_SGI_IP22 is not set anywhere,
>should
>dep_tristate treat it as FALSE?

That is a restriction on CML1, particularly when using any of the
config options that rely on shell scripts.  CONFIG_SGI_IP22 is
undefined for i386 and the shell converts $CONFIG_SGI_IP22 to blank,
before CML1 even sees it.  Doing dep_* on options that might be
undefined is unreliable.  This works :-

if [ "$CONFIG_SGI_IP22" = "y" ]; then
   tristate '  Indy/I2 Hardware Watchdog' CONFIG_INDYDOG
fi

