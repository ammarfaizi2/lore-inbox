Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135630AbRAYMfA>; Thu, 25 Jan 2001 07:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131717AbRAYMeu>; Thu, 25 Jan 2001 07:34:50 -0500
Received: from Cantor.suse.de ([194.112.123.193]:60176 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129511AbRAYMeh>;
	Thu, 25 Jan 2001 07:34:37 -0500
Date: Thu, 25 Jan 2001 13:34:29 +0100
From: Andi Kleen <ak@suse.de>
To: manfred@colorfullife.com
Cc: ak@suse.de, davem@redhat.com, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru
Subject: Re: Linux 2.2.16 through 2.2.18preX TCP hang bug triggered by rsync
Message-ID: <20010125133429.A17285@gruyere.muc.suse.de>
In-Reply-To: <3A701AEB.CF4CE9C3@stud.uni-saarland.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A701AEB.CF4CE9C3@stud.uni-saarland.de>; from masp0008@stud.uni-sb.de on Thu, Jan 25, 2001 at 12:24:11PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001 at 12:24:11PM +0000, Studierende der Universitaet des Saarlandes wrote:
> Andi wrote:
> > Basically it would accept the acks with the data in most
> > cases except when the application has totally stopped
> > reading and in that case it doesn't harm to ignore the
> > acks. 
> 
> But it seems that that's exactly what rsync does:
> It performs bulk data writes without reading. There are 32 kB in the
> receive buffers, and rsync continues to write. If the process would read
> some data the TCP stack would immediately recover.

Yes, but it has 64K of buffer. The other 32K are for skb headers. When it is 
sending MTU sized packets (and the MTU has any reasonable value) then most
of the other 32K are empty (a skb has ~150 bytes overhead) and you could
fit a few such bogus acks with data into that.

 
> RST are already processed, ACK's should be processed, but what about
> URG? 

Nobody cares about URG, it is broken anyways ;) 


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
