Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129117AbQKFHd3>; Mon, 6 Nov 2000 02:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129841AbQKFHdT>; Mon, 6 Nov 2000 02:33:19 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:35078 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129117AbQKFHdJ>; Mon, 6 Nov 2000 02:33:09 -0500
Date: Mon, 6 Nov 2000 07:32:53 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Oliver Xymoron <oxymoron@waste.org>
cc: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]
In-Reply-To: <Pine.LNX.4.10.10011060118040.8248-100000@waste.org>
Message-ID: <Pine.LNX.4.21.0011060730410.14068-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Nov 2000, Oliver Xymoron wrote:

> If I understand you correctly:
> 
> process 1         process 2
> open(/dev/dsp)
> modprobe->        
>                   load module
>                   init module   (can't remember which context, actually)
> start writing     
>                   set mixer levels
> 

> Is there any reason we ever want to unblock process 1 before process 2
> terminates?

No, and I don't think we do. That's not the point.

'init module' is still _after_ 'set mixer levels'. There is a period
during which the mixer levels are changed.

The desired mixer levels should be available to the module at the time of
initialisation.


-- 
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
