Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262508AbVEMTU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbVEMTU3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVEMTSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:18:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1256 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262487AbVEMTO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:14:57 -0400
Subject: Re: tickle nmi watchdog whilst doing serial writes.
From: Arjan van de Ven <arjan@infradead.org>
To: Dave Jones <davej@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050513184806.GA24166@redhat.com>
References: <20050513184806.GA24166@redhat.com>
Content-Type: text/plain
Date: Fri, 13 May 2005 21:14:52 +0200
Message-Id: <1116011692.6694.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 14:48 -0400, Dave Jones wrote:
>  	if (up->port.flags & UPF_CONS_FLOW) {
>  		tmout = 1000000;
>  		while (--tmout &&
> -		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0))
> +		       ((serial_in(up, UART_MSR) & UART_MSR_CTS) == 0)) {
>  			udelay(1);
> +			touch_nmi_watchdog();
> +		}
>  	}
>  }
>  
> 
> We *could* tickle it less often, but given we're busy waiting anyway
> it probably doesnt make sense to not favour the more simple approach.
> Hmm, maybe we want a cpu_relax() in there too. opinions?

udelay() includes cpu_relax() already so that is futile.

However.. this is a hack. Do we really need to do busy waiting here for
this long??


