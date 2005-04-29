Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262300AbVD2LLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbVD2LLq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 07:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVD2LLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 07:11:46 -0400
Received: from baloney.puettmann.net ([194.97.54.34]:33995 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262300AbVD2LLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 07:11:31 -0400
Date: Fri, 29 Apr 2005 13:10:48 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Alexander Nyberg <alexn@telia.com>, linux-kernel@vger.kernel.org,
       rddunlap@osdl.org, ak@suse.de
Subject: Re: 2.6.11.7 kernel panic on boot on AMD64
Message-ID: <20050429111047.GH18972@puettmann.net>
References: <20050427140342.GG10685@puettmann.net> <1114769162.874.4.camel@localhost.localdomain> <20050429031027.62d17bfa.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429031027.62d17bfa.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Ruben Puettmann <ruben@puettmann.net>
X-Scanner: exiscan *1DRTOS-0001Hn-00*eitI5GAoWiY* (Puettmann.NeT, Germany)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 03:10:27AM -0700, Andrew Morton wrote:
> > This is bogus appending stuff to the saved_command_line and at the same
> > time in Rubens case it touches the late_time_init() which breakes havoc.
> 
> -ETOOTERSE.  Do you meen that the user's command line was so long that this
> strcat wandered off the end of the buffer and corrupted late_time_init?
> 
> 
> > Signed-off-by: Alexander Nyberg <alexn@telia.com>
> > 
> > Index: linux-2.6/arch/x86_64/kernel/head64.c
> > ===================================================================
> > --- linux-2.6.orig/arch/x86_64/kernel/head64.c	2005-04-26 11:41:43.000000000 +0200
> > +++ linux-2.6/arch/x86_64/kernel/head64.c	2005-04-29 11:57:46.000000000 +0200
> > @@ -93,9 +93,6 @@
> >  #ifdef CONFIG_SMP
> >  	cpu_set(0, cpu_online_map);
> >  #endif
> > -	/* default console: */
> > -	if (!strstr(saved_command_line, "console="))
> > -		strcat(saved_command_line, " console=tty0"); 
> 
> Wasn't that code there for a reason?
> 

The patch didn't apply on 2.6.11.7 it gives this reject file:


***************                                                                                                                    
*** 93,101 ****                                                                                                                    
  #ifdef CONFIG_SMP                                                                                                                
         cpu_set(0, cpu_online_map);                                                                                               
  #endif                                                                                                                           
-        /* default console: */                                                                                                    
-        if (!strstr(saved_command_line, "console="))                                                                              
-                strcat(saved_command_line, " console=tty0");                                                                      
         s = strstr(saved_command_line, "earlyprintk=");                                                                           
         if (s != NULL)                                                                                                            
                 setup_early_printk(s);                                                                                            
--- 93,98 ----                                                                                                                     
  #ifdef CONFIG_SMP                                                                                                                
         cpu_set(0, cpu_online_map);                                                                                               
  #endif                                                                                                                           
         s = strstr(saved_command_line, "earlyprintk=");                                                                           
         if (s != NULL)                                                                                                            
                 setup_early_printk(s);                                                                                            
                                                                                                                                   

After apply by hand it works yes this was ist. Can this be fixed in the
next Versions? 


                        Ruben


-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
