Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263606AbRFAQjC>; Fri, 1 Jun 2001 12:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263605AbRFAQix>; Fri, 1 Jun 2001 12:38:53 -0400
Received: from dsl-dt-208-38-4-i185-cgy.nucleus.com ([208.38.4.185]:10759 "EHLO
	skaro.l-w.net") by vger.kernel.org with ESMTP id <S263606AbRFAQii>;
	Fri, 1 Jun 2001 12:38:38 -0400
Date: Fri, 1 Jun 2001 10:38:15 -0600 (MDT)
From: <lost@l-w.net>
To: Andries.Brouwer@cwi.nl
cc: dean-list-linux-kernel@arctic.org, jcwren@jcwren.com,
        linux-kernel@vger.kernel.org
Subject: Re: select() - Linux vs. BSD
In-Reply-To: <UTC200106010816.KAA162273.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.21.0106011030330.10964-100000@skaro.l-w.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001 Andries.Brouwer@cwi.nl wrote:

> (ii) The Linux man page only says
> 
> RETURN VALUE
>        On  success,  select  and  pselect  return  the  number of
>        descriptors contained in the descriptor sets, which may be
>        zero  if  the  timeout expires before anything interesting
>        happens.  On error, -1  is  returned,  and  errno  is  set
>        appropriately;  the  sets and timeout become undefined, so
>        do not rely on their contents after an error.
> 	
> That is, a wise programmer does not assume any particular value
> for the bits after a timeout.

So how does this say the value of the fdsets are undefined after a
timeout? It says specifically that upon success it returns the number of
descriptors in the sets, zero if the timeout expires. That is a success
condition upon which select() sets the fdsets to contain the descriptors
upon which something interesting happened. In the case of a timeout with
no descriptor having anything interesting, the sets would, logically, be
cleared.

The man page does state that the value of "timeout" is effectively
undefined upon return and that "timeout" and the fdsets are undefined
after an error, however.

Of course, not looking at the sets upon a zero return is a fairly obvious
optimization as there is little point in doing so.

William Astle
finger lost@l-w.net for further information

Geek Code V3.12: GCS/M/S d- s+:+ !a C++ UL++++$ P++ L+++ !E W++ !N w--- !O
!M PS PE V-- Y+ PGP t+@ 5++ X !R tv+@ b+++@ !DI D? G e++ h+ y?

