Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290211AbSAXABy>; Wed, 23 Jan 2002 19:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290220AbSAXABr>; Wed, 23 Jan 2002 19:01:47 -0500
Received: from sombre.2ka.mipt.ru ([194.85.82.77]:60571 "EHLO
	sombre.2ka.mipt.ru") by vger.kernel.org with ESMTP
	id <S290211AbSAXABh>; Wed, 23 Jan 2002 19:01:37 -0500
Date: Thu, 24 Jan 2002 03:01:06 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre7: compile error
Message-Id: <20020124030106.2ac290dd.johnpol@2ka.mipt.ru>
In-Reply-To: <200201232346.AAA12999@webserver.ithnet.com>
In-Reply-To: <Pine.LNX.4.21.0201231953410.4134-100000@freak.distro.conectiva>
	<200201232346.AAA12999@webserver.ithnet.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 00:46:45 +0100
Stephan von Krawczynski <skraw@ithnet.com> wrote:

> "I am sorry, Dave. I'm afraid I can't do that":                       

> ipfwadm_core.o ipfwadm_core.c                                         
> ipfwadm_core.c: In function `free_fw_chain':                          
> ipfwadm_core.c:691: called object is not a function                   
> ipfwadm_core.c: In function `insert_in_chain':                        
> ipfwadm_core.c:735: called object is not a function                   
> ipfwadm_core.c: In function `append_to_chain':                        
> ipfwadm_core.c:786: called object is not a function                   
> ipfwadm_core.c: In function `del_from_chain':                         
> ipfwadm_core.c:861: called object is not a function                   

I hope this patch will help you:

--- ./net/ipv4/netfilter/ipfwadm_core.c  Thu Jan 24 02:57:54 2002
+++ ./net/ipv4/netfilter/ipfwadm_core.c~ Thu Jan 24 02:58:01 2002
@@ -688,7 +688,7 @@
                ftmp = *chainptr;
                *chainptr = ftmp->fw_next;
                kfree(ftmp);
-               MOD_DEC_USE_COUNT();
+               MOD_DEC_USE_COUNT;
        }
        restore_flags(flags);
 }
@@ -732,7 +732,7 @@
        ftmp->fw_next = *chainptr;
                *chainptr=ftmp;
        restore_flags(flags);
-       MOD_INC_USE_COUNT();
+       MOD_INC_USE_COUNT;
        return(0);
 }
 
@@ -783,7 +783,7 @@
        else
                *chainptr=ftmp;
        restore_flags(flags);
-       MOD_INC_USE_COUNT();
+       MOD_INC_USE_COUNT;
        return(0);
 }
 
@@ -858,7 +858,7 @@
        }
        restore_flags(flags);
        if (was_found) {
-               MOD_DEC_USE_COUNT();
+               MOD_DEC_USE_COUNT;
                return 0;
        } else
                return(EINVAL);



> Regards,                                                              
> Stephan                                                               

	Evgeniy Polyakov ( s0mbre ).
