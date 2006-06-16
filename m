Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbWFPNsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbWFPNsh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 09:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWFPNsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 09:48:37 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25809 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751399AbWFPNsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 09:48:36 -0400
Date: Fri, 16 Jun 2006 14:48:29 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] tasklet_unlock_wait() cpu_relax()
Message-ID: <20060616134829.GA12657@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andreas Mohr <andi@rhlx01.fht-esslingen.de>,
	Andrew Morton <akpm@osdl.org>,
	Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
References: <20060614192920.GD19938@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614192920.GD19938@rhlx01.fht-esslingen.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2006 at 09:29:20PM +0200, Andreas Mohr wrote:
> Hi all,
> 
> use cpu_relax() here, too (instead of barrier()).
> 
> Signed-off-by: Andreas Mohr <andi@lisas.de>
> 
> 
> diff -urN linux-2.6.17-rc6-mm2.orig/include/linux/interrupt.h linux-2.6.17-rc6-mm2.my/include/linux/interrupt.h
> --- linux-2.6.17-rc6-mm2.orig/include/linux/interrupt.h	2006-06-13 19:28:16.000000000 +0200
> +++ linux-2.6.17-rc6-mm2.my/include/linux/interrupt.h	2006-06-14 20:35:49.000000000 +0200
> @@ -227,7 +227,7 @@
>  
>  static inline void tasklet_unlock_wait(struct tasklet_struct *t)
>  {
> -	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { barrier(); }
> +	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) { cpu_relax(); }
>  }

While you're at it could you reformat it to proper kernel style, e.g.:

static inline void tasklet_unlock_wait(struct tasklet_struct *t)
{
	while (test_bit(TASKLET_STATE_RUN, &t->state))
		cpu_relax();
}
