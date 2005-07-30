Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262943AbVG3NU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262943AbVG3NU1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 09:20:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262949AbVG3NU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 09:20:27 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:46773 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262943AbVG3NUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 09:20:25 -0400
Date: Sat, 30 Jul 2005 15:20:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
Subject: Re: [PATCH] swsusp: simpler calculation of number of pages in PBE list
Message-ID: <20050730132015.GF1830@elf.ucw.cz>
References: <42EA87A0.908@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <42EA87A0.908@stud.feec.vutbr.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Pá 29-07-05 21:46:40, Michal Schmidt wrote:
> The function calc_nr uses an iterative algorithm to calculate the number 
> of pages needed for the image and the pagedir. Exactly the same result 
> can be obtained with a one-line expression.
> 
> Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

Thanks, applied.

> diff -Nurp -X dontdiff.new linux-mm/kernel/power/swsusp.c linux-mm.mich/kernel/power/swsusp.c
> --- linux-mm/kernel/power/swsusp.c	2005-07-28 13:57:53.000000000 +0200
> +++ linux-mm.mich/kernel/power/swsusp.c	2005-07-29 21:01:46.000000000 +0200
> @@ -737,18 +737,7 @@ static void copy_data_pages(void)
>  
>  static int calc_nr(int nr_copy)
>  {
> -	int extra = 0;
> -	int mod = !!(nr_copy % PBES_PER_PAGE);
> -	int diff = (nr_copy / PBES_PER_PAGE) + mod;
> -
> -	do {
> -		extra += diff;
> -		nr_copy += diff;
> -		mod = !!(nr_copy % PBES_PER_PAGE);
> -		diff = (nr_copy / PBES_PER_PAGE) + mod - extra;
> -	} while (diff > 0);
> -
> -	return nr_copy;
> +	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
>  }
>  
>  /**


-- 
teflon -- maybe it is a trademark, but it should not be.
