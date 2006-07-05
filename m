Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWGEGMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWGEGMU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 02:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWGEGMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 02:12:20 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:65413 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750878AbWGEGMT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 02:12:19 -0400
Date: Tue, 4 Jul 2006 23:12:40 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Urs Thuermann <urs@isnogud.escape.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU Documentation
Message-ID: <20060705061240.GC19776@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <m2sllh8kep.fsf@janus.isnogud.escape.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2sllh8kep.fsf@janus.isnogud.escape.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2006 at 05:22:22PM +0200, Urs Thuermann wrote:
> Updater should use _rcu variant of list_del().
> 
> urs

Good catch!!!

Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
> Signed-off-by: Urs Thuermann <urs@isnogud.escape.de>
> 
> --- linux-2.6.17/Documentation/RCU/whatisRCU.txt.orig
> +++ linux-2.6.17/Documentation/RCU/whatisRCU.txt
> @@ -677,8 +677,9 @@
>  	+	spin_lock(&listmutex);
>  		list_for_each_entry(p, head, lp) {
>  			if (p->key == key) {
> -				list_del(&p->list);
> +	-			list_del(&p->list);
>  	-			write_unlock(&listmutex);
> +	+			list_del_rcu(&p->list);
>  	+			spin_unlock(&listmutex);
>  	+			synchronize_rcu();
>  				kfree(p);
> @@ -726,7 +727,7 @@
>   5   write_lock(&listmutex);            5   spin_lock(&listmutex);
>   6   list_for_each_entry(p, head, lp) { 6   list_for_each_entry(p, head, lp) {
>   7     if (p->key == key) {             7     if (p->key == key) {
> - 8       list_del(&p->list);            8       list_del(&p->list);
> + 8       list_del(&p->list);            8       list_del_rcu(&p->list);
>   9       write_unlock(&listmutex);      9       spin_unlock(&listmutex);
>                                         10       synchronize_rcu();
>  10       kfree(p);                     11       kfree(p);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
