Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271135AbRHOLG6>; Wed, 15 Aug 2001 07:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271136AbRHOLGj>; Wed, 15 Aug 2001 07:06:39 -0400
Received: from biancha.hardboiledegg.com ([66.38.186.202]:17682 "HELO
	biancha.hardboiledegg.com") by vger.kernel.org with SMTP
	id <S271135AbRHOLGX>; Wed, 15 Aug 2001 07:06:23 -0400
Date: Wed, 15 Aug 2001 07:06:22 -0400
From: Marc Heckmann <heckmann@hbesoftware.com>
To: riel@conectiva.com.br
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.4.8-pre7: still buffer cache problems[+2.4.9-pre3 comments]
Message-ID: <20010815070622.A27813@hbe.ca>
In-Reply-To: <Pine.LNX.4.33L.0108091749580.1439-100000@duckman.distro.conectiva> <32779.213.7.62.75.997402832.squirrel@webmail.hbesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <32779.213.7.62.75.997402832.squirrel@webmail.hbesoftware.com>; from heckmann@hbesoftware.com on Thu, Aug 09, 2001 at 08:20:32PM -0400
X-AntiVirus: scanned for viruses by AMaViS 0.2.1-pre3 (http://amavis.org/)
X-AntiVirus: scanned for viruses by AMaViS 0.2.1-pre3 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 08:20:32PM -0400, marc heckmann wrote:
> > 
> > OK, there is no obvious way to do do drop-behind on
> > buffer cache pages, but I think we can use a quick
> > hack to make the system behave well under the presence
> > of large amounts of buffer cache pages.
> > 
> > What we could do is, in refill_inactive_scan(), just
> > moving buffer cache pages to the inactive list regardless
> > of page aging when there are too many buffercache pages
> > around in the system.
> > 
> > Does the patch below help you ?
> 
> well, the buffer cache still got huge and the system still swapped out like
> mad, but it seemed like the buffer cache grew _slower_ and that the vm was
> more fair towards other vm users. so interactivity was better but still far
> from 2.2. and then it oops'ed [I don't think it was because of your patch
> though..]:
> 

I tried 2.4.8 final and it fixes the problem.... could it be the 
fs/buffer.c changes? behaviour is now like 2.2 (good in this case). if I 
have time I'll try 2.4.8-ac5 to se if it also fixes it. thanks to whoever 
is responsible for the fix.

also I tried 2.4.9-pre3 and it performs _much_ [I'd say 10 times better!]
better under high VM load specifically when filling all ram+swap. Where
2.4.8 used to thrash without making any progress what so ever [I'd have to
reset], 2.4.9-pre3 will either oom_kill (the _right_ process) or manage to
handle swap to let processes run without thrashing. this is all on PPC 
without any highmem (192Mb + 200mb swap.).


	Cheers,

	-marc

