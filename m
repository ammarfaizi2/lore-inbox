Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751607AbWFVEQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbWFVEQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWFVEQG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:16:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:32710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751607AbWFVEQE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:16:04 -0400
Date: Wed, 21 Jun 2006 21:15:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ananda Raju <Ananda.Raju@neterion.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, dgc@sgi.com, balbir@in.ibm.com,
       viro@zeniv.linux.org.uk, neilb@suse.de, jblunck@suse.de,
       tglx@linutronix.de, ananda.raju@neterion.com,
       leonid.grossman@neterion.com, ravinandan.arakali@neterion.com,
       alicia.pena@neterion.com
Subject: Re: [patch 2.6.17] s2io driver irq fix
Message-Id: <20060621211534.b740d0f8.akpm@osdl.org>
In-Reply-To: <Pine.GSO.4.10.10606211537540.23949-100000@guinness>
References: <Pine.GSO.4.10.10606211537540.23949-100000@guinness>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 15:50:49 -0400 (EDT)
Ananda Raju <Ananda.Raju@neterion.com> wrote:

> +	if (sp->intr_type == MSI_X) {
> +		int i;
>  
> -				free_irq(vector, arg);
> +		for (i=1; (sp->s2io_entries[i].in_use == MSIX_FLG); i++) {
> +			if (sp->s2io_entries[i].type == MSIX_FIFO_TYPE) {
> +				sprintf(sp->desc[i], "%s:MSI-X-%d-TX",
> +					dev->name, i);
> +				err = request_irq(sp->entries[i].vector,
> +					  s2io_msix_fifo_handle, 0, sp->desc[i],
> +						  sp->s2io_entries[i].arg);

Is it usual to prohibit IRQ sharing with msix?

