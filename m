Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261817AbSI2XUT>; Sun, 29 Sep 2002 19:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261838AbSI2XUT>; Sun, 29 Sep 2002 19:20:19 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:21637 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S261817AbSI2XUS>; Sun, 29 Sep 2002 19:20:18 -0400
Date: Sun, 29 Sep 2002 17:25:23 -0600
Message-Id: <200209292325.g8TNPNI17404@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Phil Oester <kernel@theoesters.com>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.39 - make MCE options arch dependent
In-Reply-To: <20020929161206.A14962@ns1.theoesters.com>
References: <20020929161206.A14962@ns1.theoesters.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester writes:
> No need to see P4 or Athlon options if you don't have one...
> 
> --- linux-2.5.39-orig/arch/i386/config.in       Fri Sep 27 14:49:42 2002
> +++ linux-2.5.39/arch/i386/config.in    Sun Sep 29 15:55:44 2002
> @@ -187,8 +187,12 @@
>  fi
>  
>  bool 'Machine Check Exception' CONFIG_X86_MCE
> -dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
> -dep_bool 'check for P4 thermal throttling interrupt.' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
> +if [ "$CONFIG_MK7" = "y" ]; then
> +   dep_bool 'Check for non-fatal errors on Athlon/Duron' CONFIG_X86_MCE_NONFATAL $CONFIG_X86_MCE
> +fi
> +if [ "$CONFIG_MPENTIUM4" = "y" ]; then
> +   dep_bool 'Check for P4 thermal throttling interrupt' CONFIG_X86_MCE_P4THERMAL $CONFIG_X86_MCE $CONFIG_X86_UP_APIC
> +fi 

But now I can't build a "generic" kernel which supports both these
features.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
