Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130072AbRCAWxN>; Thu, 1 Mar 2001 17:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130079AbRCAWwy>; Thu, 1 Mar 2001 17:52:54 -0500
Received: from mercury.ultramaster.com ([208.222.81.163]:63917 "EHLO
	mercury.ultramaster.com") by vger.kernel.org with ESMTP
	id <S130072AbRCAWww>; Thu, 1 Mar 2001 17:52:52 -0500
Message-ID: <3A9ED281.90C5F7CB@dm.ultramaster.com>
Date: Thu, 01 Mar 2001 17:51:45 -0500
From: David Mansfield <lkml@dm.ultramaster.com>
Organization: Ultramaster Group LLC
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-mm@kvack.org,
        " Xos… V·zquez" <xose@smi-ps.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] oom-killer trigger
In-Reply-To: <Pine.LNX.4.33.0103011904140.1304-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 1. the OOM killer never triggers if we have > freepages.min
>    of free memory
> 2. __alloc_pages() never allocates pages to < freepages.min
>    for user allocations
> 
> ==> the OOM killer never gets triggered under some workloads;
>     the system just sits around with nr_free_pages == freepages.min
> 
> The patch below trivially fixes this by upping the OOM kill limit
> by a really small number of pages ...

> +       if (nr_free_pages() > freepages.min + 4)


Call me stupid, but why not just change the > to >= (or < to <=) rather
than introducing a magic number (4).  Or at least make the magic number
interesting, like:

+       if (nr_free_pages() > freepages.min + 42)

:-)

Thanks for the bugfix,
David

-- 
David Mansfield                                           (718) 963-2020
david@ultramaster.com
Ultramaster Group, LLC                               www.ultramaster.com
