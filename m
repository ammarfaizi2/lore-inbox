Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262860AbTJTTnz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 15:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262855AbTJTTnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 15:43:55 -0400
Received: from smtpq1.home.nl ([213.51.128.196]:39138 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S262854AbTJTTnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 15:43:49 -0400
Date: Mon, 20 Oct 2003 21:42:52 +0200 (CEST)
From: Aschwin Marsman <aschwin@marsman.org>
X-X-Sender: marsman@localhost.localdomain
To: marcelo.tosatti@cyclades.com.br
cc: linux-scsi@vger.kernel.org, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Retry: 2.4.23-pre5 BK: aic7xxx_reg.h: Permission Denied
In-Reply-To: <Pine.LNX.4.44.0309211135400.4110-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310202134530.2047-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Sep 2003, Aschwin Marsman wrote:

> Hi,

Hi,
 
> During the compilation of 2.4.23-pre5 (latest from BK), I get the
> following:

2.4.23-pre7 (latest from BK of today) still gives the same problem for me.
The patch below still applies cleanly. Will this problem be solved? If
not then I will remove the generation of this driver from my automatic
build procedure.
 
> aicasm/aicasm -I. -r aic7xxx_reg.h -p aic7xxx_reg_print.c -i aic7xxx_osm.h -o aic7xxx_seq.h aic7xxx.seq
> aic7xxx_reg.h: Permission denied
> make[3]: *** [aic7xxx_seq.h] Error 73
> make[3]: Leaving directory `/home/marsman/src/bk/linux-2.4/drivers/scsi/aic7xxx'
> make[2]: *** [_modsubdir_aic7xxx] Error 2
> make[2]: Leaving directory `/home/marsman/src/bk/linux-2.4/drivers/scsi'
> make[1]: *** [_modsubdir_scsi] Error 2
> make[1]: Leaving directory `/home/marsman/src/bk/linux-2.4/drivers'
> make: *** [_mod_drivers] Error 2
> 
> The reason is that:
> aic79xx_reg.h
> aic79xx_reg_print.c
> aic79xx_seq.h
> aic7xxx_reg.h
> aic7xxx_reg_print.c
> aic7xxx_seq.h
> 
> are generated files, but they are under version control and therefor readonly, so they can't
> be written. I see two options:
> 1) Do not put them under version control
> 2) Remove/make them writable before new versions are generated.
> 
> I would prefer option one, but you can argue that it is nice to be able to see the history
> of the generated files.
> 
> The patch below removes the files before they are written.
> 
> --- drivers/scsi/aic7xxx/Makefile.org	Sun Sep 21 07:19:34 2003
> +++ drivers/scsi/aic7xxx/Makefile	Sun Sep 21 11:46:29 2003
> @@ -75,6 +75,7 @@
>  		 -o aic7xxx_seq.h aic7xxx.seq
>  endif
>  $(aic7xxx_gen): aic7xxx.seq aic7xxx.reg aicasm/aicasm
> +	$(RM) $(aic7xxx_gen)
>  	$(aic7xxx_asm_cmd)
>  endif
>  
> @@ -90,6 +91,7 @@
>  		 -o aic79xx_seq.h aic79xx.seq
>  endif
>  $(aic79xx_gen): aic79xx.seq aic79xx.reg aicasm/aicasm
> +	$(RM) $(aic79xx_gen)
>  	$(aic79xx_asm_cmd)
>  endif
>  
 
Best regards,
 
Aschwin Marsman
 
--
aschwin@marsman.org              http://www.marsman.org

