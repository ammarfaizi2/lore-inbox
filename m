Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271626AbRIBNsr>; Sun, 2 Sep 2001 09:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271627AbRIBNsi>; Sun, 2 Sep 2001 09:48:38 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:63651 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271626AbRIBNsY>;
	Sun, 2 Sep 2001 09:48:24 -0400
Date: Sun, 02 Sep 2001 14:48:39 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: Memory Problem in 2.4.10-pre2 / __alloc_pages failed
Message-ID: <1013623912.999442119@[169.254.198.40]>
In-Reply-To: <200109020226.f822QCS18912@maile.telia.com>
In-Reply-To: <200109020226.f822QCS18912@maile.telia.com>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or/and we could remove the sources of higher order allocs, as an example:
> why is the SCSI layer allowed to allocate order 3 allocs (32 kB) several
> times per second? Will we really get a performance hit by not allowing
> higher order allocs in active driver code?

Or put them in some slab like code, the slab for which gets allocated
early on when memory is not fragmented, and (nearly) never gets released.
Most of the stuff that actually NEEDS atomic allocation (as opposed
to some of the requirements that are bogus) are for packets / data
in flight. There is probably a finite amount of this at any given time.

--
Alex Bligh
