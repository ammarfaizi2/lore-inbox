Return-Path: <linux-kernel-owner+w=401wt.eu-S932310AbXAIRpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbXAIRpb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbXAIRpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:45:31 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:2363 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932304AbXAIRpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:45:30 -0500
Date: Tue, 9 Jan 2007 18:45:34 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
       ibm-acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6.20-rc4 regression] ibm-acpi: bay support disabled
Message-ID: <20070109174534.GN25007@stusta.de>
References: <20070109172845.GA3528@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109172845.GA3528@khazad-dum.debian.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 03:28:45PM -0200, Henrique de Moraes Holschuh wrote:
> A new one for you, it exists since 2.6.20-rc2.
> 
> Subject      : ThinkPad removable bay support disabled unconditionally
> References   : http://marc.theaimsgroup.com/?l=linux-acpi&m=116750681901208&w=2
> Caused-By    : Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Handled-By   : Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> Status       : patch attached

Thanks, noted.

> From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> 
> ACPI: ibm-acpi: fix Kconfig entries for ibm-acpi bay and dock
> 
> Support for ACPI_BAY has not been merged in mainline yet.  Usage of
> "depends on FOO=n" fails if FOO is undefined, thus ibm-acpi support
> for bay was being made non-available in a kernel that has no other
> sort of bay support.
> 
> Fix it to use "depends on ! FOO" instead, that does the right thing
> when FOO is undefined.  Fix ACPI_IBM_DOCK accordingly as well while
> at it, and also improve the help text.
> 
> Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
> ---
>  drivers/acpi/Kconfig |   17 ++++++++++-------
>  1 files changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 1639998..34cc8d5 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -215,26 +215,29 @@ config ACPI_IBM
>  config ACPI_IBM_DOCK
>  	bool "Legacy Docking Station Support"
>  	depends on ACPI_IBM
> -	depends on ACPI_DOCK=n
> -	default n
> +	depends on ! ACPI_DOCK
> +	default y
>...

!ACPI_DOCK is wrong if the intention was ACPI_DOCK=n (since ACPI_DOCK is 
a tristate).

I'd say the right fix is to remove the negative dependencies on unmerged 
options and reintroduce them once these options themselves got merged.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

