Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268704AbTCCSvg>; Mon, 3 Mar 2003 13:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268711AbTCCSvg>; Mon, 3 Mar 2003 13:51:36 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:32668
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S268704AbTCCSvf>; Mon, 3 Mar 2003 13:51:35 -0500
Subject: Re: [patch] small tty irq race fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nicolas Pitre <nico@cam.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303031305130.31566-100000@xanadu.home>
References: <Pine.LNX.4.44.0303031305130.31566-100000@xanadu.home>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046721965.7320.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 20:06:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 		fp = tty->flip.flag_buf + TTY_FLIPBUF_SIZE;
> -		tty->flip.buf_num = 0;
>  
>  		local_irq_save(flags); // FIXME: is this safe?
> +		tty->flip.buf_num = 0;

The other CPU can be touching these fields too surely. Its a
useful note that the spinlocks need putting in the right spot
but its still broken 8(

