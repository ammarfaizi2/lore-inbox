Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273977AbRI0WeV>; Thu, 27 Sep 2001 18:34:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274001AbRI0WeM>; Thu, 27 Sep 2001 18:34:12 -0400
Received: from ausxc08.us.dell.com ([143.166.99.216]:53745 "EHLO
	ausxc08.us.dell.com") by vger.kernel.org with ESMTP
	id <S273999AbRI0WeA>; Thu, 27 Sep 2001 18:34:00 -0400
Message-ID: <8F120FA493CAD743B30EEB8F356985B501A7819D@AUSXMBT102VS1.amer.dell.com>
From: Robert_Macaulay@Dell.com
To: andrea@suse.de
Cc: riel@conectiva.com.br, ckulesa@as.arizona.edu,
        linux-kernel@vger.kernel.org, bmatthews@redhat.com,
        marcelo@conectiva.com.br, torvalds@transmeta.com
Subject: RE: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs. 2.4.9
	-ac14/15(+stuff)]
Date: Thu, 27 Sep 2001 17:34:17 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrea Arcangeli [mailto:andrea@suse.de]
> Sent: Thursday, September 27, 2001 5:13 PM
> To: Macaulay, Robert
> Cc: Rik van Riel; Craig Kulesa; linux-kernel@vger.kernel.org; Bob
> Matthews; Marcelo Tosatti; Linus Torvalds
> Subject: highmem deadlock fix [was Re: VM in 2.4.10(+tweaks) vs.
> 2.4.9-ac14/15(+stuff)]
> 
> @@ -2519,7 +2521,9 @@
>  	int tryagain = 1;
>  
>  	do {
> -		if (buffer_dirty(p) || buffer_locked(p)) {
> +		if (unlikely(buffer_pending_IO(p)))
> +			tryagain = 0;
> +		else if (buffer_dirty(p) || buffer_locked(p)) {
>  			if (test_and_set_bit(BH_Wait_IO, &p->b_state)) {
>  				if (buffer_dirty(p)) {
>  					ll_rw_block(WRITE, 1, &p);
> 

Im getting an undefined reference to the unlikely function in this patch.
