Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261730AbULJP2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261730AbULJP2c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbULJP2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:28:32 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:54221 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261730AbULJP2N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:28:13 -0500
Subject: Re: [PATCH 1/1] driver: Tpm hardware enablement
From: Kylene Hall <kjhall@us.ibm.com>
To: Ian Campbell <icampbell@arcom.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, sailer@watson.ibm.com,
       leendert@watson.ibm.com, Emily Ratliff <emilyr@us.ibm.com>,
       Tom Lendacky <toml@us.ibm.com>, tpmdd-devel@lists.sourceforge.net
In-Reply-To: <1102676169.31305.85.camel@icampbell-debian>
References: <Pine.LNX.4.58.0412081546470.24510@jo.austin.ibm.com>
	 <1102676169.31305.85.camel@icampbell-debian>
Content-Type: text/plain
Message-Id: <1102692480.20230.3.camel@jo.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Dec 2004 09:28:00 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-10 at 04:56, Ian Campbell wrote:
> Hi, 
> 
> On Thu, 2004-12-09 at 09:25 -0600, Kylene Hall wrote:
> > +	/* Determine chip type */
> > +	if (tpm_nsc_init(chip) == 0) {
> > +		chip->recv = tpm_nsc_recv;
> > +		chip->send = tpm_nsc_send;
> > +		chip->cancel = tpm_nsc_cancel;
> > +		chip->req_complete_mask = NSC_STATUS_OBF;
> > +		chip->req_complete_val = NSC_STATUS_OBF;
> > +	} else if (tpm_atml_init(chip) == 0) {
> > +		chip->recv = tpm_atml_recv;
> > +		chip->send = tpm_atml_send;
> > +		chip->cancel = tpm_atml_cancel;
> > +		chip->req_complete_mask =
> > +		    ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL;
> > +		chip->req_complete_val = ATML_STATUS_DATA_AVAIL;
> > +	} else {
> > +		rc = -ENODEV;
> > +		goto out_release;
> > +	}
> 
> The atmel part at least also comes as an I2C variant. 
> 
> We could continue to add to the ifelse here but perhaps it might be
> beneficial to split the individual chip specific stuff into separate
> files now and perhaps register them via some sort of
> register_tpm_hardware(struct tpm_chip_ops *) type interface?
> 
Good point.  Splitting this out (esp. because there will be more in the
future) is a good idea.  What is the usual way to do this?  For example,
what function in the chip specific file would call
register_tpm_hardware, how do I make sure that gets called etc.

Thanks,
Kylene

> Ian.

