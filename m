Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132799AbRDIQ4E>; Mon, 9 Apr 2001 12:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132800AbRDIQzy>; Mon, 9 Apr 2001 12:55:54 -0400
Received: from barn.holstein.com ([198.134.143.193]:30732 "EHLO holstein.com")
	by vger.kernel.org with ESMTP id <S132799AbRDIQzq>;
	Mon, 9 Apr 2001 12:55:46 -0400
Date: Mon, 9 Apr 2001 16:54:37 GMT
Message-Id: <200104091654.f39GsbR00271@pcx4168.holstein.com>
From: "Todd M. Roy" <troy@holstein.com>
To: jonathan@daria.co.uk
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44f.3acf8044.2edba@trespassersw.daria.co.uk> (message from
	Jonathan Hudson on Sat, 07 Apr 2001 21:01:56 GMT)
Subject: Re: Unresolved symbol in 2.4.4p1, ia32
Reply-To: troy@holstein.com
In-Reply-To: <44f.3acf8044.2edba@trespassersw.daria.co.uk>
X-MIMETrack: Itemize by SMTP Server on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 04/09/2001 12:54:40 PM,
	Serialize by Router on Imail/Holstein(Release 5.0.1b|September 30, 1999) at
 04/09/2001 12:54:40 PM,
	Serialize complete at 04/09/2001 12:54:40 PM
X-Priority: 3 (Normal)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  From:	Jonathan Hudson <jonathan@daria.co.uk>
>  X-Newsreader: knews 1.0b.1
>  x-no-productlinks: yes
>  X-Newsgroups: fa.linux.kernel
>  Content-Type: text/plain; charset=iso-8859-1
>  Date:	Sat, 07 Apr 2001 21:01:56 GMT
>  Bytes:	235
>  Sender:	linux-kernel-owner@vger.kernel.org
>  Precedence: bulk
>  X-Mailing-List:	linux-kernel@vger.kernel.org
>  
>  depmod: *** Unresolved symbols in 
>          /lib/modules/2.4.4-pre1/kernel/drivers/ide/ide-cd.o
>  depmod: 	strstr
>  
>  depmod: *** Unresolved symbols in 
>          /lib/modules/2.4.4-pre1/kernel/drivers/parport/parport.o
>  depmod: 	strstr
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/
>  
>  

I think strstr (apparently a new function) got left out of 
i386_ksyms.c:
The following appears to have fixed it for me:
--- arch/i386/kernel/i386_ksyms.c.~1~	Mon Apr  9 10:54:58 2001
+++ arch/i386/kernel/i386_ksyms.c	Mon Apr  9 12:46:45 2001
@@ -97,6 +97,7 @@
 EXPORT_SYMBOL_NOVERS(__put_user_2);
 EXPORT_SYMBOL_NOVERS(__put_user_4);
 
+EXPORT_SYMBOL(strstr);
 EXPORT_SYMBOL(strtok);
 EXPORT_SYMBOL(strpbrk);
 EXPORT_SYMBOL(simple_strtol);


-- todd --

**********************************************************************
This footnote confirms that this email message has been swept by 
MIMEsweeper for the presence of computer viruses.
**********************************************************************
