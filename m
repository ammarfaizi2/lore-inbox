Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313707AbSDHRSA>; Mon, 8 Apr 2002 13:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313708AbSDHRR7>; Mon, 8 Apr 2002 13:17:59 -0400
Received: from [195.63.194.11] ([195.63.194.11]:63247 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313707AbSDHRR6>; Mon, 8 Apr 2002 13:17:58 -0400
Message-ID: <3CB1C1A3.2040206@evision-ventures.com>
Date: Mon, 08 Apr 2002 18:13:23 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Richard Gooch <rgooch@ras.ucalgary.ca>
CC: Oliver Neukum <oliver@neukum.org>, nahshon@actcom.co.il,
        Pavel Machek <pavel@suse.cz>, Benjamin LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@zip.com.au>,
        joeja@mindspring.com, linux-kernel@vger.kernel.org
Subject: Re: faster boots?
In-Reply-To: <E16tTAF-0008F2-00@the-village.bc.nu>	<200204080048.g380mt514749@lmail.actcom.co.il>	<200204080057.g380vbO00868@vindaloo.ras.ucalgary.ca>	<16uSEQ-1XziYCC@fmrl04.sul.t-online.com> <200204081706.g38H62N14879@vindaloo.ras.ucalgary.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch wrote:
> Oliver Neukum writes:
> 
>>>>and spin-up on any operation that writes to the disk (and block that
>>>>operation).
>>>
>>>Absolutely not! I don't want my writes to spin up the drive.
>>
>>Even if you sync ?
> 
> 
> I'm undecided. I think it's good to have a way to let the user force a
> flush, but I don't like the same mechanism being used by applications
> which think they know better. So flushing on sync(2) or f*sync(2) is
> perhaps undesirable. Maybe the way to deal with this is to have:
> 
> - tunable flush time (i.e. how long to wait after a write(2) before
>   flushing, if the drive is currently unspun)
> 
> - tunable dirty pages limit (i.e. how many dirty pages allowed before
>   flushing)
> 
> - tunable "ignore *sync(2)" option. Default value is 0 (don't
>   ignore). When set to 1, ignore all calls to *sync(2).
> 
> So then on my 256 MiB laptop, I'd probably set the flush time to 3
> hours, the dirty page limit to 64 MiB, and ignore *sync(2). I'd write
> a suid-root programme which did:
> 	enable_sync ();
> 	sync ();
> 	disable_sync ();

Quite frankly the spin-up-down-up-down-up behaviour of linux on
notbooks even if I let them entierly alone is to say the leasy annoying...
And noflushd didn't help me a jota on this issue. Second I don't
think that going though this cycle even on desktop systems does
really help the reliability of the wearings of the driver. For
some reaons I wasn't able to find all the 1000 parameters one has
to set before the whole thing does shut properly. Curing this by
settign some "low water mark" for the number of allowed dirty pages
is curing the symptoms - if there are no system activities there
simply should be no chance for some crepping dirty pages if this is
still the case there are just chances that there are simple bugs out
there. kflushd should by no chance flush the caches just in case
without checking whatever there was some activity in an ideal world.

