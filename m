Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266220AbRF3Rdw>; Sat, 30 Jun 2001 13:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266221AbRF3Rdn>; Sat, 30 Jun 2001 13:33:43 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:8463 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266220AbRF3Rdf>; Sat, 30 Jun 2001 13:33:35 -0400
Date: Sat, 30 Jun 2001 10:32:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Steve Lord <lord@sgi.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bounce buffer deadlock
In-Reply-To: <Pine.LNX.4.21.0106301229280.3227-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106301030570.1470-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 29 Jun 2001, Steve Lord wrote:
>
> Has anyone else seen a hang like this:
>
>   bdflush()
>     flush_dirty_buffers()
>       ll_rw_block()
> 	submit_bh(buffer X)
> 	  generic_make_request()
> 	    __make_request()
> 	        create_bounce()
> 		  alloc_bounce_page()
> 		    alloc_page()
> 		      try_to_free_pages()
> 			do_try_to_free_pages()
> 			  page_launder()
> 			    try_to_free_buffers( , 2)  -- i.e. wait for buffers
> 			      sync_page_buffers()
> 				__wait_on_buffer(buffer X)

Should be fixed in 2.4.6-pre8 (or pre7, for that matter).

		Linus

