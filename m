Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265042AbRG0Vms>; Fri, 27 Jul 2001 17:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264942AbRG0Vmj>; Fri, 27 Jul 2001 17:42:39 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:9993 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S264461AbRG0Vm1>; Fri, 27 Jul 2001 17:42:27 -0400
Date: Fri, 27 Jul 2001 18:42:26 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
Cc: <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@transmeta.com>,
        Daniel Phillips <phillips@kernelnewbies.org>
Subject: Re: 2.4.8-pre1 and dbench -20% throughput
In-Reply-To: <200107272112.f6RLC3d28206@maila.telia.com>
Message-ID: <Pine.LNX.4.33L.0107271837270.5582-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, 27 Jul 2001, Roger Larsson wrote:

> But "dbench 32" (on my 256 MB box) results has are the most interesting:
>
> 2.4.0 gave 33 MB/s
> 2.4.8-pre1 gives 26.1 MB/s (-21%)
>
> Do we now throw away pages that would be reused?

Yes. This is pretty much expected behaviour with the use-once
patch, both as it is currently implemented and how it works
in principle.

This is because the use-once strategy protects the working
set from streaming IO in a better way than before. One of the
consequences of this is that streaming IO pages get less of a
chance to be reused before they're evicted.

Database systems usually have a history of recently evicted
pages so they can promote these quick-evicted pages to the
list of more frequently used pages when it's faulted in again.

regards,

Rik
--
Executive summary of a recent Microsoft press release:
   "we are concerned about the GNU General Public License (GPL)"


		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

