Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263344AbSIVPoq>; Sun, 22 Sep 2002 11:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264056AbSIVPoq>; Sun, 22 Sep 2002 11:44:46 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:16347 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S263344AbSIVPop>; Sun, 22 Sep 2002 11:44:45 -0400
Message-ID: <3D8DE705.9090907@si.rr.com>
Date: Sun, 22 Sep 2002 11:51:33 -0400
From: Frank Davis <fdavis@si.rr.com>
Reply-To: fdavis@si.rr.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Molina <tmolina@cox.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: compile error and fix in v_midi.c
References: <Pine.LNX.4.44.0209221033440.959-100000@dad.molina>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas,
   This patch was submited before:
http://marc.theaimsgroup.com/?l=linux-kernel&m=103156669011988&w=2

and also by myself back in 2.5.33
http://marc.theaimsgroup.com/?l=linux-kernel&m=103094246825436&w=2

but hasn't been included yet.

Regards,
Frank


Thomas Molina wrote:
> Compiling 2.5.3[78] I get the following:
> 
> v_midi.c: In function `v_midi_open':
> v_midi.c:55: structure has no member named `lock'
> v_midi.c:58: structure has no member named `lock'
> v_midi.c:62: structure has no member named `lock'
> v_midi.c: In function `v_midi_close':
> v_midi.c:83: structure has no member named `lock'
> v_midi.c:87: structure has no member named `lock'
> v_midi.c: In function `attach_v_midi':
> v_midi.c:223: structure has no member named `lock'
> v_midi.c:244: structure has no member named `lock'
> make[2]: *** [v_midi.o] Error 1
> make[1]: *** [oss] Error 2
> make: *** [sound] Error 2
> 
> The following patch fixes that:
> 
> --- linux-2.5-tm/sound/oss/v_midi.h.old	Sun Sep 22 10:01:43 2002
> +++ linux-2.5-tm/sound/oss/v_midi.h	Sun Sep 22 10:02:48 2002
> @@ -11,5 +11,6 @@
>  	   int input_opened;
>  	   int intr_active;
>  	   void (*midi_input_intr) (int dev, unsigned char data);
> +	   spinlock_t lock;
>  	} vmidi_devc;
>  
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


