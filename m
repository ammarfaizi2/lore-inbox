Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVHAXca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVHAXca (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 19:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVHAXca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 19:32:30 -0400
Received: from tim.rpsys.net ([194.106.48.114]:9693 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S261338AbVHAXc0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 19:32:26 -0400
Subject: Re: 2.6.13-rc3-mm3
From: Richard Purdie <rpurdie@rpsys.net>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508011609140.9237@graphe.net>
References: <20050728025840.0596b9cb.akpm@osdl.org>
	 <1122860603.7626.32.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508010908530.3546@graphe.net>
	 <1122926537.7648.105.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011335090.7011@graphe.net>
	 <1122930474.7648.119.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011414480.7574@graphe.net>
	 <1122931637.7648.125.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011438010.7888@graphe.net>
	 <1122933133.7648.141.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011517300.8498@graphe.net>
	 <1122937261.7648.151.camel@localhost.localdomain>
	 <Pine.LNX.4.62.0508011609140.9237@graphe.net>
Content-Type: text/plain
Date: Tue, 02 Aug 2005 00:32:12 +0100
Message-Id: <1122939132.7648.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-01 at 16:16 -0700, Christoph Lameter wrote:
> Hmmm. this should have returned the behavior to normal. Ah. Need to use 
> new_entry instead of entry. Try this (is there any way that I could get 
> access to the sytem? I am on IRC (freenode.net nick o-o) or on skype).
>  
> +#ifdef CONFIG_ATOMIC_TABLE_OPS
>  	/*
>  	 * If the cmpxchg fails then another processor may have done
>  	 * the changes for us. If not then another fault will bring
> @@ -2106,6 +2107,11 @@
>  	} else {
>  		inc_page_state(cmpxchg_fail_flag_update);
>  	}
> +#else
> +	ptep_set_access_flags(vma, address, pte, new_entry, write_access);
> +	update_mmu_cache(vma, address, new_entry);
> +	lazy_mmu_prot_update(new_entry);
> +#endif

With this applied, the system boots then X locks up in memcpy as before.
The cmpxchg_fail_flag_update remains at zero but given the above patch,
that's to be expected...

Sadly, remote access to the system isn't really much use as there is no
compiler on the device and flashing a new kernel is a manual procedure
involving pressing buttons.

Richard

