Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVEZMtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVEZMtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 08:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261394AbVEZMtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 08:49:19 -0400
Received: from upco.es ([130.206.70.227]:59859 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S261379AbVEZMtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 08:49:14 -0400
Date: Thu, 26 May 2005 14:49:11 +0200
From: Romano Giannetti <romanol@upco.es>
To: Olaf Hering <olh@suse.de>
Cc: Pavel Machek <pavel@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] show swsuspend only on .config where it can compile
Message-ID: <20050526124911.GA19822@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es, Olaf Hering <olh@suse.de>,
	Pavel Machek <pavel@suse.de>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050526111614.GA25685@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050526111614.GA25685@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2005 at 01:16:14PM +0200, Olaf Hering wrote:
> show swsuspend only on .config where it can compile.
> I got this on PPC32 && SMP
> 
> kernel/power/smp.c:24: error: storage size of `ctxt' isn't known
> 
> Signed-off-by: Olaf Hering <olh@suse.de>
> 
> Index: linux-2.6.12-rc5-olh/kernel/power/Kconfig
> ===================================================================
> --- linux-2.6.12-rc5-olh.orig/kernel/power/Kconfig
> +++ linux-2.6.12-rc5-olh/kernel/power/Kconfig
> @@ -28,7 +28,7 @@ config PM_DEBUG
>  
>  config SOFTWARE_SUSPEND
>  	bool "Software Suspend (EXPERIMENTAL)"
> -	depends on EXPERIMENTAL && PM && SWAP
> +	depends on EXPERIMENTAL && PM && SWAP && (X86 && SMP) || ((FVR || PPC32 || X86) && !SMP)

Shouldn't be ...&& ( (X86 && SMP) || (FVR || PPC32 || X86) && !SMP )  ?

and maybe 

EXPERIMENTAL && PM && SWAP && ( X86  || ((FVR || PPC32) && !SMP) ) 

is clearer? 



-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
