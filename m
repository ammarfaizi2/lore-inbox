Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262052AbTCVHiK>; Sat, 22 Mar 2003 02:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262053AbTCVHiK>; Sat, 22 Mar 2003 02:38:10 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:5384 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262052AbTCVHiJ>; Sat, 22 Mar 2003 02:38:09 -0500
Date: Sat, 22 Mar 2003 07:49:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: PATCH: fix proc handling in sis, siimageand slc90e66
Message-ID: <20030322074911.A24305@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <200303211936.h2LJaCK7025824@hraefn.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303211936.h2LJaCK7025824@hraefn.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Mar 21, 2003 at 07:36:12PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 21, 2003 at 07:36:12PM +0000, Alan Cox wrote:
> diff -u --new-file --recursive --exclude-from /usr/src/exclude linux-2.5.65/drivers/ide/pci/siimage.c linux-2.5.65-ac2/drivers/ide/pci/siimage.c
> --- linux-2.5.65/drivers/ide/pci/siimage.c	2003-03-03 19:20:09.000000000 +0000
> +++ linux-2.5.65-ac2/drivers/ide/pci/siimage.c	2003-03-06 23:35:51.000000000 +0000
> @@ -55,6 +55,7 @@
>  static int siimage_get_info (char *buffer, char **addr, off_t offset, int count)
>  {
>  	char *p = buffer;
> +	int len;
>  	u16 i;
>  
>  	p += sprintf(p, "\n");
> @@ -62,7 +63,11 @@
>  		struct pci_dev *dev	= siimage_devs[i];
>  		p = print_siimage_get_info(p, dev, i);
>  	}
> -	return p-buffer;	/* => must be less than 4k! */
> +	/* p - buffer must be less than 4k! */
> +	len = (p - buffer) - offset;
> +	*addr = buffer + offset;
> +	
> +	return len > count ? count : len;

Shouldn't this just move to the seq_file interface?  (probably the "simple"
variant)

