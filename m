Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKMJMr>; Mon, 13 Nov 2000 04:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129410AbQKMJMh>; Mon, 13 Nov 2000 04:12:37 -0500
Received: from relay01.valueweb.net ([216.219.253.235]:1287 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S129050AbQKMJMW>; Mon, 13 Nov 2000 04:12:22 -0500
Message-ID: <3A0FB18A.534F2F21@opersys.com>
From: Karim Yaghmour <karym@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
CC: Eric Reischer <emr@engr.de.psu.edu>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, debian-powerpc@lists.debian.org
Subject: Re: Issue compiling 2.4test10
In-Reply-To: <Pine.LNX.4.10.10011021021110.19979-100000@opal.biophys.uni-duesseldorf.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date: Mon, 13 Nov 2000 04:12:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Schmitz wrote:
> 
> Would this patch help?
> 
> --- drivers/input/keybdev.c.org Thu Nov  2 10:13:39 2000
> +++ drivers/input/keybdev.c     Thu Nov  2 10:19:43 2000
> @@ -36,7 +36,7 @@
>  #include <linux/module.h>
>  #include <linux/kbd_kern.h>
> 
> -#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__)
> +#if defined(CONFIG_X86) || defined(CONFIG_IA64) || defined(__alpha__) || defined(__mips__) || defined(CONFIG_MAC_HID)
> 

I've tried this on my PowerBook and it doesn't work. The keymap is broken and
pressing anything on the keyboard will output something completely different.
This is fixed if the "defined(CONFIG_MAC_HID)" gets move the "#elif" part of
the "#if" mentionned above.

That said, 2 and 3 button emulation is broken for (at least) the PowerBook on test-10.
I've tried the 
echo "1" > /proc/sys/dev/mac_hid/mouse_button_emulation
and there's no effect. Anyone know what this is about?

Thanks.

===================================================
                 Karim Yaghmour
               karym@opersys.com
          Operating System Consultant
 (Linux kernel, real-time and distributed systems)
===================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
