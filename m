Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267072AbSLDUf5>; Wed, 4 Dec 2002 15:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267078AbSLDUf5>; Wed, 4 Dec 2002 15:35:57 -0500
Received: from codepoet.org ([166.70.99.138]:28039 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S267072AbSLDUf4>;
	Wed, 4 Dec 2002 15:35:56 -0500
Date: Wed, 4 Dec 2002 13:43:29 -0700
From: Erik Andersen <andersen@codepoet.org>
To: zippel@linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [kconfig] Direct use of lxdialog routines by menuconfig (resent,v2)
Message-ID: <20021204204329.GA29999@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	zippel@linux-m68k.org, linux-kernel@vger.kernel.org
References: <20021123095040.GY25628@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021123095040.GY25628@pasky.ji.cz>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Nov 23, 2002 at 10:50:40AM +0100, Petr Baudis wrote:
>  		if (menu == &rootmenu) {
> -			cprint(":");
> -			cprint("--- ");
> -			cprint("L");
> -			cprint("Load an Alternate Configuration File");
> -			cprint("S");
> -			cprint("Save Configuration to an Alternate File");
> -		}
> -		stat = exec_conf();
> +			cmake(); cprint_tag(":"); cprint_name("--- ");
> +			cmake(); cprint_tag("L"); cprint_name("Load an Alternate Configuration File");
> +			cmake(); cprint_tag("S"); cprint_name("Save Configuration to an Alternate File");
> +		}
> +		dialog_clear();
> +		stat = dialog_menu(prompt ? prompt : "Main Menu",
> +				menu_instructions, rows, cols, rows - 10,
> +				active_entry, item_no, items);
>  		if (stat < 0)
>  			continue;

You never return from sub-menus.  This last bit should be:

  		if (stat < 0)
- 			continue;
+ 			return;

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
