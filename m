Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbQJ2BrH>; Sat, 28 Oct 2000 21:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129535AbQJ2Bq6>; Sat, 28 Oct 2000 21:46:58 -0400
Received: from brutus.conectiva.com.br ([200.250.58.146]:47089 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S129233AbQJ2Bqv>; Sat, 28 Oct 2000 21:46:51 -0400
Date: Sat, 28 Oct 2000 23:46:37 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Andi Kleen <ak@suse.de>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        "Dave S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: tcp_do_sendmsg() allocation still broken ?
In-Reply-To: <20001029020311.A16003@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.21.0010282345200.4224-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Oct 2000, Andi Kleen wrote:
> On Sat, Oct 28, 2000 at 07:12:44PM -0200, Marcelo Tosatti wrote:
> > 
> > tcp_do_sendmsg() still allocates using GFP_KERNEL when it can't, it seems: 
> 
> tcp_do_sendmsg() should only be called from process context,
> because it can sleep for other reasons anyways.

Andi, if sk->allocation is there to be ignored, why 
don't you remove that element from the structure?

> If someone calls it from interrupt context it needs to be fixed.

Think about nbd.
Think about swap-over-network.
Think about the reasons why sk->allocation exists.

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
