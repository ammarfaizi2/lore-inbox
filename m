Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289054AbSAZKdW>; Sat, 26 Jan 2002 05:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289055AbSAZKdC>; Sat, 26 Jan 2002 05:33:02 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:13579 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S289054AbSAZKc6>;
	Sat, 26 Jan 2002 05:32:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "George Bonser" <george@gator.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux console at boot 
In-Reply-To: Your message of "Thu, 24 Jan 2002 21:05:45 -0800."
             <CHEKKPICCNOGICGMDODJKEPAGBAA.george@gator.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 26 Jan 2002 21:32:45 +1100
Message-ID: <20849.1012041165@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 21:05:45 -0800, 
"George Bonser" <george@gator.com> wrote:
>Is there any way to stop the console scrolling during boot? My reason
>for this is I am trying to troubleshoot a boot problem with
>2.4.18-pre7 and I would like to give a more useful report than "it
>won't boot" but the screen outputs information every few seconds and I
>can't "freeze" the display so I can copy down the initial error(s).

Serial console is the best.  If you can't do that, add a delay after
each set of console output.  Tweak 100000000 to get a suitable delay.

Index: 17.1/kernel/printk.c
--- 17.1/kernel/printk.c Tue, 11 Dec 2001 09:58:50 +1100 kaos (linux-2.4/j/48_printk.c 1.1.2.2.7.1.2.3 644)
+++ 17.1(w)/kernel/printk.c Sat, 26 Jan 2002 21:30:53 +1100 kaos (linux-2.4/j/48_printk.c 1.1.2.2.7.1.2.3 644)
@@ -373,6 +373,7 @@ static void call_console_drivers(unsigne
 		}
 	}
 	_call_console_drivers(start_print, end, msg_level);
+	{ int i; for (i = 0; i < 100000000; ++i) ; }
 }
 
 static void emit_log_char(char c)

