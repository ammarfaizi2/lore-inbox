Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266006AbUIMEyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266006AbUIMEyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 00:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266034AbUIMEyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 00:54:21 -0400
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:54716 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266006AbUIMEyC (ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 13 Sep 2004 00:54:02 -0400
Message-ID: <414527E6.6080202@yahoo.com.au>
Date: Mon, 13 Sep 2004 14:53:58 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Subject: Re: 2.6.9-rc1: page_referenced_one() CPU consumption
References: <Pine.LNX.4.44.0409101315520.16623-100000@localhost.localdomain>	<41424E71.3050107@yahoo.com.au> <16708.28915.200356.565462@gargle.gargle.HOWL>
In-Reply-To: <16708.28915.200356.565462@gargle.gargle.HOWL>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

> I ran tests few times, and difference between patched and un-patched
> kernels is within noise, so you are right, try-lock does not help.
> 

Well I'm glad - because I much prefer the spin_lock over the trylock :)

> But now I have new great idea instead. :)
> 
> I think page_referenced() should transfer dirtiness to the struct page
> as it scans pte's. Basically the earlier we mark page dirty the better
> file system write-back performs, because page has more chances to be
> bulk-written by ->writepages(). This is better than my previous patches
> to this end (that used separate function to transfer dirtiness from
> pte's to the page), because
> 
>     - locking overhead is avoided
> 
>     - it's simpler.
> 
> Nick, are you still in business of benchmarking random VM patches? :-)
> 

Yeah I am, and I do have that patch sitting around. It can *really*
help for writeout via maped memory (obviously doesn't help write()).

I think Andrew's response was that it can theoretically cause writeout
for workloads that don't want it, so I should come up with at least
one real-world improvement!
