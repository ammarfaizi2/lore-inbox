Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271995AbRJJUsY>; Wed, 10 Oct 2001 16:48:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274862AbRJJUsO>; Wed, 10 Oct 2001 16:48:14 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:17095 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S271995AbRJJUsC>; Wed, 10 Oct 2001 16:48:02 -0400
Date: Wed, 10 Oct 2001 16:48:23 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: kernelnewbies@nl.linux.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [CFT][PATCH] smoother VM for -ac
Message-ID: <20011010164823.A17860@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0110101710150.26495-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0110101710150.26495-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, Oct 10, 2001 at 05:25:30PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2001 at 05:25:30PM -0300, Rik van Riel wrote:
> 4) in page_alloc.c, the "slowdown" reschedule has been
>    made stronger by turning it into a try_to_free_pages(),
>    under memory load, this results in allocators calling
>    try_to_free_pages() when the amount of work to be done
>    isn't too bad yet and pretty much guarantees them they'll
>    get to do their allocation immediately afterwards ...
>    statistics make sure that the memory hogs are slowed down
>    much more than well-behaved programs

There's a small problem with this one: I know that during testing of 
earlier 2.4 kernels we saw a livelock which was caused by the vm 
subsystem spinning without scheduling.  This can happen in a couple of 
cases like NFS where another task has to be allowed to run in order to 
make progress in clearing pages.

		-ben
