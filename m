Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265894AbTAYInm>; Sat, 25 Jan 2003 03:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266218AbTAYInl>; Sat, 25 Jan 2003 03:43:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23568 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265894AbTAYInl>;
	Sat, 25 Jan 2003 03:43:41 -0500
Date: Sat, 25 Jan 2003 08:52:48 +0000
From: Matthew Wilcox <willy@debian.org>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@redhat.com>,
       willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.5] pci_{save,restore}_extended_state
Message-ID: <20030125085248.A4882@parcelfarce.linux.theplanet.co.uk>
References: <20030124212403.A25285@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030124212403.A25285@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Fri, Jan 24, 2003 at 09:24:03PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 09:24:03PM +0300, Ivan Kokshaysky wrote:
> pci.h: added missing SIZEOFs for each capability as per PCI specs.
> I'm not 100% sure about PCI_CHSWP_SIZEOF and PCI_X_SIZEOF - somebody
> with respective specs in hands (Matthew?) ought to verify this...

PCI-X is 8 bytes -- ID, Next capability, 2-byte `Command', 4-byte `Status'

Except PCI-X bridges, which are 16-bytes long.  And I didn't write down the
definition for those.

Hotswap uses only 3 bytes, but the 4th byte is `reserved' so better save
4 bytes rather than 3.

>  #define  PCI_CHSWP_PI		0x30	/* Programming Interface */
>  #define  PCI_CHSWP_EXT		0x40	/* ENUM# status - extraction */
>  #define  PCI_CHSWP_INS		0x80	/* ENUM# status - insertion */
> +#define PCI_CHSWP_SIZEOF	4
>  
>  /* PCI-X registers */
>  
> @@ -309,6 +314,7 @@
>  #define  PCI_X_STATUS_MAX_SPLIT	0x0380	/* Design Max Outstanding Split Trans */
>  #define  PCI_X_STATUS_MAX_CUM	0x1c00	/* Designed Max Cumulative Read Size */
>  #define  PCI_X_STATUS_SPL_ERR	0x2000	/* Rcvd Split Completion Error Msg */
> +#define PCI_X_SIZEOF		9
>  
>  /* Include the ID list */
>  

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
