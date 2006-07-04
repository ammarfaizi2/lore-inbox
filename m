Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750717AbWGDHvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750717AbWGDHvy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 03:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbWGDHvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 03:51:53 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10152 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750717AbWGDHvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 03:51:52 -0400
Subject: Re: [PATCH 1/2] x86-64 TIF flags for debug regs and io bitmap in
	ctxsw
From: Arjan van de Ven <arjan@infradead.org>
To: eranian@hpl.hp.com
Cc: linux-kernel@vger.kernel.org, ak@suse.de
In-Reply-To: <20060704072832.GB5902@frankl.hpl.hp.com>
References: <20060704072832.GB5902@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Tue, 04 Jul 2006 09:51:49 +0200
Message-Id: <1151999509.3109.6.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		}
> -	}
> +	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> +	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> +		__switch_to_xtra(prev_p, next_p, tss);

well isn't this replacing an if() (which isn't cheap but also not
expensive, due to unlikely()) with an atomic operation (which *is*
expensive) ?

That to me doesn't make this sound like an actual win....


