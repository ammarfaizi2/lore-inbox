Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVFBIXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVFBIXK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 04:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFBIVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 04:21:16 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32237 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261238AbVFBIT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 04:19:27 -0400
Subject: Re: [patch 6/9] dlm: clear recovery flags
From: Arjan van de Ven <arjan@infradead.org>
To: David Teigland <teigland@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050602080301.GF21570@redhat.com>
References: <20050602080301.GF21570@redhat.com>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 10:19:20 +0200
Message-Id: <1117700360.6458.25.camel@laptopd505.fenrus.org>
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

On Thu, 2005-06-02 at 16:03 +0800, David Teigland wrote:
> plain text document attachment (clear-recovery-flags.patch)
> At the start of recovery, all the recovery flags are cleared from the
> previous recovery.  Two of them weren't being cleared.
> 
> Signed-off-by: David Teigland <teigland@redhat.com>
> 
> Index: linux/drivers/dlm/member.c
> ===================================================================
> --- linux.orig/drivers/dlm/member.c	2005-06-02 12:28:30.000000000 +0800
> +++ linux/drivers/dlm/member.c	2005-06-02 13:07:46.060566696 +0800
> @@ -276,6 +276,8 @@
>  	 */
>  
>  	dlm_recoverd_suspend(ls);
> +	clear_bit(LSFL_LOCKS_VALID, &ls->ls_flags);
> +	clear_bit(LSFL_ALL_LOCKS_VALID, &ls->ls_flags);
>  	clear_bit(LSFL_DIR_VALID, &ls->ls_flags);
>  	clear_bit(LSFL_ALL_DIR_VALID, &ls->ls_flags);
>  	clear_bit(LSFL_NODES_VALID, &ls->ls_flags);

btw do these need to be atomic? right now these are atomic ops and thus
very expensive... you might want to switch to nonatomic variants if
that's not needed.


