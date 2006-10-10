Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030631AbWJJXQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030631AbWJJXQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 19:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030639AbWJJXQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 19:16:34 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:34729
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1030631AbWJJXQc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 19:16:32 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] trivial iomem annotations (arch/powerpc/platfroms/parsemi/pci.c)
Date: Wed, 11 Oct 2006 01:16:05 +0200
User-Agent: KMail/1.9.4
References: <20061009152309.GQ29920@ftp.linux.org.uk>
In-Reply-To: <20061009152309.GQ29920@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610110116.05870.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 October 2006 17:23, Al Viro wrote:
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  arch/powerpc/platforms/pasemi/pci.c |   26 +++++++++++++-------------
>  1 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pasemi/pci.c b/arch/powerpc/platforms/pasemi/pci.c
> index 4679c52..39020c1 100644
> --- a/arch/powerpc/platforms/pasemi/pci.c
> +++ b/arch/powerpc/platforms/pasemi/pci.c
> @@ -35,17 +35,17 @@ #define PA_PXP_CFA(bus, devfn, off) (((b
>  
>  #define CONFIG_OFFSET_VALID(off) ((off) < 4096)
>  
> -static unsigned long pa_pxp_cfg_addr(struct pci_controller *hose,
> +static void volatile __iomem *pa_pxp_cfg_addr(struct pci_controller *hose,
>  				       u8 bus, u8 devfn, int offset)
>  {
> -	return ((unsigned long)hose->cfg_data) + PA_PXP_CFA(bus, devfn, offset);
> +	return hose->cfg_data + PA_PXP_CFA(bus, devfn, offset);
>  }
>  
>  static int pa_pxp_read_config(struct pci_bus *bus, unsigned int devfn,
>  			      int offset, int len, u32 *val)
>  {
>  	struct pci_controller *hose;
> -	unsigned long addr;
> +	void volatile __iomem *addr;

I think you should drop all these new "volatile"s.

>  	hose = pci_bus_to_host(bus);
>  	if (!hose)
> @@ -62,13 +62,13 @@ static int pa_pxp_read_config(struct pci
>  	 */
>  	switch (len) {
>  	case 1:
> -		*val = in_8((u8 *)addr);
> +		*val = in_8(addr);
>  		break;
>  	case 2:
> -		*val = in_le16((u16 *)addr);
> +		*val = in_le16(addr);
>  		break;
>  	default:
> -		*val = in_le32((u32 *)addr);
> +		*val = in_le32(addr);
>  		break;
>  	}
>  
> @@ -79,7 +79,7 @@ static int pa_pxp_write_config(struct pc
>  			       int offset, int len, u32 val)
>  {
>  	struct pci_controller *hose;
> -	unsigned long addr;
> +	void volatile __iomem *addr;
>  
>  	hose = pci_bus_to_host(bus);
>  	if (!hose)
> @@ -96,16 +96,16 @@ static int pa_pxp_write_config(struct pc
>  	 */
>  	switch (len) {
>  	case 1:
> -		out_8((u8 *)addr, val);
> -		(void) in_8((u8 *)addr);
> +		out_8(addr, val);
> +		(void) in_8(addr);
>  		break;
>  	case 2:
> -		out_le16((u16 *)addr, val);
> -		(void) in_le16((u16 *)addr);
> +		out_le16(addr, val);
> +		(void) in_le16(addr);
>  		break;
>  	default:
> -		out_le32((u32 *)addr, val);
> -		(void) in_le32((u32 *)addr);
> +		out_le32(addr, val);
> +		(void) in_le32(addr);
>  		break;
>  	}
>  	return PCIBIOS_SUCCESSFUL;

-- 
Greetings Michael.
