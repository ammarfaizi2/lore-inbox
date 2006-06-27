Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWF0P0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWF0P0P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161097AbWF0P0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:26:15 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:20670 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1161095AbWF0P0O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:26:14 -0400
Subject: Re: + delay-accounting-taskstats-interface-send-tgid-once.patch
	added to -mm tree
From: Arjan van de Ven <arjan@infradead.org>
To: michal.k.k.piotrowski@gmail.com
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, akpm@osdl.org,
       nagar@watson.ibm.com, balbir@in.ibm.com, jlan@engr.sgi.com
In-Reply-To: <1151421336.5217.28.camel@laptopd505.fenrus.org>
References: <200606261906.k5QJ6vCp025201@shell0.pdx.osdl.net>
	 <1151421336.5217.28.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Tue, 27 Jun 2006 17:26:10 +0200
Message-Id: <1151421970.5217.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> CPU 0                		CPU 1
> (in irq)            	 	(in the code above)

actually CPU 0 doesn't even have to be in irq context; any context will
do

> 		     		stats_lock is taken
> tasklist_lock is taken	     	
> stats_lock_is taken <spin>	
> 				<interrupt happens>
> 		     		tasklist_lock is taken
> 		     
> which now forms an AB-BA deadlock!
> 
> 
> this happens at least in copy_process which can call taskstats_tgid_free
> without first disabling interrupts (via cleanup_signal). There may be
> many other cases, I've not checked deeper yet.
> 
> Solution should be to make these functions use irqsave variant... any
> comments from the authors of this patch ?
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

