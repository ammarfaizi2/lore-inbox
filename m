Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965320AbWJBTEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965320AbWJBTEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 15:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965326AbWJBTEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 15:04:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:48155 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965319AbWJBTEN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 15:04:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=aTDlOHV6TthdeDtParOcMwZUM1f802Yxh4OL1Z61D8+7pSex3t34Pr6ryBuXRhurlRknzj/9MNVmsACvfkWY72BY6ap5qpdbAO5lCooHCOfuWsM+p3vFpJugcmZNoWkgXqp8mR4/AGH+hBMyCCaYIsvGATbYVMOaPV9eXeZ6ZCQ=
Date: Mon, 2 Oct 2006 21:02:46 +0000
From: Frederik Deweerdt <deweerdt@free.fr>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-scsi@vger.kernel.org,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       "J.A. Magall??n" <jamagallon@ono.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] move aic7xxx to pci_request_irq
Message-ID: <20061002210246.GG3003@slug>
References: <1159573404.13029.96.camel@localhost.localdomain> <20060930140946.GA1195@slug> <451F049A.1010404@garzik.org> <20061001142807.GD16272@parisc-linux.org> <1159729523.2891.408.camel@laptopd505.fenrus.org> <20061001193616.GF16272@parisc-linux.org> <1159755141.2891.434.camel@laptopd505.fenrus.org> <20061002200048.GC3003@slug> <20061002200703.GD3003@slug> <20061002182744.GM16272@parisc-linux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061002182744.GM16272@parisc-linux.org>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2006 at 12:27:44PM -0600, Matthew Wilcox wrote:
> On Mon, Oct 02, 2006 at 08:07:03PM +0000, Frederik Deweerdt wrote:
> > +++ b/drivers/scsi/aic7xxx/aic79xx_osm_pci.c
> > @@ -341,12 +341,12 @@ ahd_pci_map_int(struct ahd_softc *ahd)
> >  {
> >  	int error;
> >  
> > -	error = request_irq(ahd->dev_softc->irq, ahd_linux_isr,
> > -			    IRQF_SHARED, "aic79xx", ahd);
> > +	error = pci_request_irq(ahd->dev_softc, ahd_linux_isr,
> > +			    IRQF_SHARED, "aic79xx");
> >  	if (!error)
> >  		ahd->platform_data->irq = ahd->dev_softc->irq;
> >  	
> > -	return (-error);
> > +	return error;
> 
> Seems unsafe to me.
It is, it slipped through the patches, I didn't mean to send it to the
list :(. Please ignore that.
> 
> > -	
> > -	return (-error);
> > -}
> >  
> > +	return error;
> > +}
> 
> Ditto.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
