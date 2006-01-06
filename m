Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932630AbWAFH3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbWAFH3p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbWAFH3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:29:44 -0500
Received: from mf00.sitadelle.com ([212.94.174.67]:2902 "EHLO smtp.cegetel.net")
	by vger.kernel.org with ESMTP id S932630AbWAFH3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:29:44 -0500
Message-ID: <43BE1C62.9030101@cosmosbay.com>
Date: Fri, 06 Jan 2006 08:29:38 +0100
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce sizeof(percpu_data) and removes dependance against
 NR_CPUS
References: <1135251766.3557.13.camel@pmac.infradead.org> <20060105021929.498f45ef.akpm@osdl.org> <43BD2406.2040007@cosmosbay.com> <Pine.LNX.4.61.0601060816330.22809@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0601060816330.22809@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt a écrit :
> 
> --- linux-2.6.15/include/linux/percpu.h	2006-01-03 04:21:10.000000000 +0100
> +++ linux-2.6.15-edum/include/linux/percpu.h	2006-01-05 14:45:48.000000000 +0100
> @@ -18,8 +18,7 @@
>  #ifdef CONFIG_SMP
>  
>  struct percpu_data {
> -	void *ptrs[NR_CPUS];
> -	void *blkp;
> +	void *ptrs[1]; /* real size depends on highest_possible_processor_id() */
>  };
>  
>  /* 
> 
> 
> I think we can use *ptrs[0] here.
> 

Or even dont change percpu.h, or else some guys will assume percpu_data cost 
nothing...

Eric
