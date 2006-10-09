Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932948AbWJIPld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932948AbWJIPld (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 11:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932949AbWJIPld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 11:41:33 -0400
Received: from lixom.net ([66.141.50.11]:22723 "EHLO mail.lixom.net")
	by vger.kernel.org with ESMTP id S932948AbWJIPlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 11:41:32 -0400
Date: Mon, 9 Oct 2006 10:40:43 -0500
From: Olof Johansson <olof@lixom.net>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial iomem annotations
 (arch/powerpc/platfroms/parsemi/pci.c)
Message-ID: <20061009104043.0d4c6416@localhost.localdomain>
In-Reply-To: <20061009152309.GQ29920@ftp.linux.org.uk>
References: <20061009152309.GQ29920@ftp.linux.org.uk>
X-Mailer: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.4; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Oct 2006 16:23:09 +0100 Al Viro <viro@ftp.linux.org.uk> wrote:

> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Acked-by: Olof Johansson <olof@lixom.net>


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
>  
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
