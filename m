Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290015AbSAQQbc>; Thu, 17 Jan 2002 11:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289867AbSAQQbW>; Thu, 17 Jan 2002 11:31:22 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:21810 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S289817AbSAQQbH>; Thu, 17 Jan 2002 11:31:07 -0500
Date: Thu, 17 Jan 2002 17:31:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Rik van Riel <riel@conectiva.com.br>
Subject: Re: clarification about redhat and vm
Message-ID: <20020117173144.Q4847@athlon.random>
In-Reply-To: <20020117161055.K4847@athlon.random> <E16RFE9-00042W-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E16RFE9-00042W-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Jan 17, 2002 at 04:17:21PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 04:17:21PM +0000, Alan Cox wrote:
> The RH VM is totally unrelated to the crap in 2.4.9 vanilla. The SAP comment
> begs a question. 2.4.10 seems to have problems remembering to actually 
> do fsync()'s. How much of your SAP benchmark is from fsync's that dont
> happen ? Do you get the same values with 2.4.18-aa ?

AFIK the bench was not with 2.4.10 (not that I remeber any missing fsync
anyways, actually MS_ASYNC is broken and this is fixed between in
18pre2aa2 from Andrew Morton, but that was broken in 2.4.[79] too). The
bench in 2.2 was delivering much better performance than with 2.4 (I
don't recall the exact number) and 2.2 definitely is not missing fsync
etc...  furthmore the 2.2 numbers were reproducible. the benchmark swaps
heavily shm etc... and the 2.4.[79] vm was collapsing at the second pass
(I think first throughput was 5 then 1 1 1 1), if you swapout always the
wrong part and you start trashing because of unbalance of aging it is
very easy to make a x10 difference in the final numbers. I think a sane
vm should run faster than 2.2 and to be reproducible as 2.2. I tend to
like such test, also because it is a real life test (unlike what
somebody thought). The huge regression in such test was one of the main
reasons that made me to realize the brokeness of the vm algorithms.

Andrea
