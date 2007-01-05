Return-Path: <linux-kernel-owner+w=401wt.eu-S1161031AbXAEKG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbXAEKG1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 05:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161039AbXAEKG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 05:06:27 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:24639 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161031AbXAEKG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 05:06:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=PoAcMDv2j+sNxxJjLzzKv4kHo9aqSaK5FviUrHK7/b6B3L7jP3rZl+z9p5iMuN6fIEf0hldX88kHkugXpZB10gPwZN7P2QhBaxVSYPGX2KdpUJIrJP0E01Hp20290WjNXlBzEH2T/8IDw+BFgHbOojsjTikqogSldC264lgNjLs=
Date: Fri, 5 Jan 2007 12:06:11 +0200
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc3] TTY_IO: Remove unnecessary kmalloc casts
Message-ID: <20070105100610.GA382@Ahmed>
Mail-Followup-To: Rolf Eike Beer <eike-kernel@sf-tec.de>,
	linux-kernel@vger.kernel.org
References: <20070105063600.GA13571@Ahmed> <200701050910.11828.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701050910.11828.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 09:10:01AM +0100, Rolf Eike Beer wrote:
> Ahmed S. Darwish wrote:
> > Remove unnecessary kmalloc casts in drivers/char/tty_io.c
> >
> > Signed-off-by: Ahmed Darwish <darwish.07@gmail.com>
> 
>   	if (!*ltp_loc) {
>  -		ltp = (struct ktermios *) kmalloc(sizeof(struct ktermios),
>  -						 GFP_KERNEL);
>  +		ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
>                       ^^^^^^^
>   		if (!ltp)
>   			goto free_mem_out;
>   		memset(ltp, 0, sizeof(struct ktermios));
>                 ^^^^^^ 
> kzalloc
> 
>   		if (!*o_ltp_loc) {
>  -			o_ltp = (struct ktermios *)
>  -				kmalloc(sizeof(struct ktermios), GFP_KERNEL);
>  +			o_ltp = kmalloc(sizeof(struct ktermios), GFP_KERNEL);
>                                 ^^^^^^^
>   			if (!o_ltp)
>   				goto free_mem_out;
>   			memset(o_ltp, 0, sizeof(struct ktermios));
>                         ^^^^^^
> kzalloc

Currently I'm dropping this patch and writing a big patch to remove all the 
k[mzc]alloc castings in the 20-rc3 tree as suggested by Mr. Robert Day.
I think this will be better done in another patch to let every patch do one
single thing. right ?

-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
