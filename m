Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271706AbRH0PPh>; Mon, 27 Aug 2001 11:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271753AbRH0PP1>; Mon, 27 Aug 2001 11:15:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:13837 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S271706AbRH0PPK>;
	Mon, 27 Aug 2001 11:15:10 -0400
Date: Mon, 27 Aug 2001 12:14:43 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Helge Hafting <helgehaf@idb.hist.no>, <linux-kernel@vger.kernel.org>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
In-Reply-To: <499114355.998926919@[169.254.198.40]>
Message-ID: <Pine.LNX.4.33L.0108271213370.5646-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Aug 2001, Alex Bligh - linux-kernel wrote:

> A nit: I think it's a MRU list you want.

Absolutely, however ...

> If you are reading
> ahead (let's have caps for a page that has been used for reading,
> as well as read from the disk, and lowercase for read-ahead that
> has not been used):
> 	ABCDefghijklmnopq
>              |            |
>             read         disk
> 	   ptr          head
> and you want to reclaim memory, you want to drop (say) 'pq'
> to get
> 	ABCDefghijklmno
> for two reasons: firstly because 'efg' etc. are most likely
> to be used NEXT, and secondly because the diskhead is nearer
> 'pq' when you (inevitably) have to read it again.

This is NOT MRU, since p and q have not been used yet.
In this example you really want to drop D and C instead.

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

