Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbULJQjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbULJQjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 11:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbULJQhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 11:37:21 -0500
Received: from holomorphy.com ([207.189.100.168]:60049 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261752AbULJQgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 11:36:36 -0500
Date: Fri, 10 Dec 2004 08:36:14 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210163614.GN2714@holomorphy.com>
References: <1101938767.13353.62.camel@tglx.tec.linutronix.de> <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041203022854.GL32635@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2004 at 03:28:54AM +0100, Andrea Arcangeli wrote:
> +	if (mm == &init_mm) {
> +		mmput(mm);
> +		return NULL;
> +	}

On Fri, Dec 03, 2004 at 03:28:54AM +0100, Andrea Arcangeli wrote:
> +	if (PTR_ERR(p) == -1UL)
> +		goto out;
> +
>  	/* Found nothing?!?! Either we hang forever, or we panic. */
>  	if (!p) {
> +		read_unlock(&tasklist_lock);
>  		show_free_areas();
>  		panic("Out of memory and no killable processes...\n");
>  	}

Maybe the mm == &init_mm case should return an ERR_PTR also, as that is
a sign of a transient error, not cause for a hard panic.


-- wli
