Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261987AbSJDVfQ>; Fri, 4 Oct 2002 17:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262006AbSJDVfQ>; Fri, 4 Oct 2002 17:35:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36876 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261987AbSJDVfH>;
	Fri, 4 Oct 2002 17:35:07 -0400
Message-ID: <3D9E0AB7.8090905@pobox.com>
Date: Fri, 04 Oct 2002 17:40:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: [BK PATCH] pcibios_* removals for 2.5.40
References: <20021003224011.GA2289@kroah.com> <Pine.LNX.4.44.0210040930581.1723-100000@home.transmeta.com> <20021004165955.GC6978@kroah.com> <20021004205121.GA8346@kroah.com> <20021004205222.GB8346@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.674.3.3 -> 1.674.3.4
> #	drivers/char/rocket.c	1.12    -> 1.13   
> #	drivers/scsi/inia100.c	1.10    -> 1.11   
> #	 drivers/sbus/sbus.c	1.15    -> 1.16   
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 02/10/04	greg@kroah.com	1.674.3.4
> # PCI: fixed remaining usages of pcibios_present() that I missed previously.
> # --------------------------------------------
> #
> diff -Nru a/drivers/char/rocket.c b/drivers/char/rocket.c
> --- a/drivers/char/rocket.c	Fri Oct  4 13:47:29 2002
> +++ b/drivers/char/rocket.c	Fri Oct  4 13:47:29 2002
> @@ -1993,7 +1993,7 @@
>  			isa_boards_found++;
>  	}
>  #ifdef CONFIG_PCI
> -	if (pcibios_present()) {
> +	if (pci_present()) {
>  		if(isa_boards_found < NUM_BOARDS)
>  			pci_boards_found = init_PCI(isa_boards_found);
>  	} else {

can be greatly simplified -- just simply all the code in the ifdef to 
"if (isa_boards_found...) ...init_PCI..."


> diff -Nru a/drivers/sbus/sbus.c b/drivers/sbus/sbus.c
> --- a/drivers/sbus/sbus.c	Fri Oct  4 13:47:29 2002
> +++ b/drivers/sbus/sbus.c	Fri Oct  4 13:47:29 2002
> @@ -312,7 +312,7 @@
>  		nd = prom_searchsiblings(topnd, "sbus");
>  		if(nd == 0) {
>  #ifdef CONFIG_PCI
> -			if (!pcibios_present()) {	
> +			if (!pci_present()) {
>  				prom_printf("Neither SBUS nor PCI found.\n");
>  				prom_halt();
>  			} else {

I wonder if this is intentional arch code should not be changed...  David?


> diff -Nru a/drivers/scsi/inia100.c b/drivers/scsi/inia100.c
> --- a/drivers/scsi/inia100.c	Fri Oct  4 13:47:29 2002
> +++ b/drivers/scsi/inia100.c	Fri Oct  4 13:47:29 2002
> @@ -208,7 +208,7 @@
>  	/*
>  	 * PCI-bus probe.
>  	 */
> -	if (pcibios_present()) {
> +	if (pci_present()) {

test looks like it can be eliminated completely

