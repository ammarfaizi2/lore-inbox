Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbUKCTJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbUKCTJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 14:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbUKCTJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 14:09:16 -0500
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:33910 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S261816AbUKCTFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 14:05:15 -0500
Date: Wed, 3 Nov 2004 10:59:55 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Jan Kasprzak <kas@fi.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor fix of RCU documentation
Message-ID: <20041103185954.GA1331@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20041102232317.GD13012@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041102232317.GD13012@fi.muni.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good catch!  Andrew, please apply.

						Thanx, Paul

Acked-by: <paulmck@us.ibm.com>

On Wed, Nov 03, 2004 at 12:23:18AM +0100, Jan Kasprzak wrote:
> 	Hello, all!
> 
> the attached patch fixes an incorrect example in Documentation/RCU/listRCU.txt
> - the "original" lock-based code should not call RCU functions, of course.
> 
> -Yenya
> 
> Signed-Off-By: Jan "Yenya" Kasprzak <kas@fi.muni.cz>
> 
> --- linux-2.6.9/Documentation/RCU/listRCU.txt.orig	2004-10-18 23:53:44.000000000 +0200
> +++ linux-2.6.9/Documentation/RCU/listRCU.txt	2004-10-30 14:49:42.706526360 +0200
> @@ -82,7 +82,7 @@
>  		list_for_each_entry(e, list, list) {
>  			if (!audit_compare_rule(rule, &e->rule)) {
>  				list_del(&e->list);
> -				call_rcu(&e->rcu, audit_free_rule, e);
> +				write_unlock(&auditsc_lock);
>  				return 0;
>  			}
>  		}
> 
> -- 
> | Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
> | GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
> | http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> > Whatever the Java applications and desktop dances may lead to, Unix will <
> > still be pushing the packets around for a quite a while.      --Rob Pike <
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
