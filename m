Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129930AbQL2XLf>; Fri, 29 Dec 2000 18:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130653AbQL2XLZ>; Fri, 29 Dec 2000 18:11:25 -0500
Received: from unthought.net ([212.97.129.24]:20629 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S129930AbQL2XLP>;
	Fri, 29 Dec 2000 18:11:15 -0500
Date: Fri, 29 Dec 2000 23:40:48 +0100
From: Jakob Østergaard <jakob@unthought.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Petru Paler <ppetru@ppetru.net>,
        Jure Pecar <pegasus@telemach.net>, linux-kernel@vger.kernel.org,
        thttpd@bomb.acme.com
Subject: Re: linux 2.2.19pre and thttpd (VM-global problem?)
Message-ID: <20001229234048.B12468@unthought.net>
Mail-Followup-To: Jakob Østergaard <jakob@unthought.net>,
	Andrea Arcangeli <andrea@suse.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Petru Paler <ppetru@ppetru.net>, Jure Pecar <pegasus@telemach.net>,
	linux-kernel@vger.kernel.org, thttpd@bomb.acme.com
In-Reply-To: <20001229165340.C12791@athlon.random> <E14C4bd-0005bM-00@the-village.bc.nu> <20001229200657.B16261@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <20001229200657.B16261@athlon.random>; from andrea@suse.de on Fri, Dec 29, 2000 at 08:06:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2000 at 08:06:57PM +0100, Andrea Arcangeli wrote:
> On Fri, Dec 29, 2000 at 06:50:18PM +0000, Alan Cox wrote:
> > Your cgi will keep the other CPU occupied, or run two of them. thttpd has
> > superb scaling properties compared to say apache.
> 
> I think with 8 CPUs and 8 NICs (usual benchmark setup) you want more than 1 cpu
> serving static data and it should be more efficient if it's threaded and
> sleeping in accept() instead of running eight of them (starting from sharing
> tlb entries and avoiding flushes probably without the need of CPU binding).

Ok - my point was (and maybe I'm just misunderstanding something):

Multiple threads do send() etc. -> this gets serialized by the kernel
anyway, as TCP checksums are done in the kernel as well as the NIC
driving etc.   If the TCP layer cannot parallelize checksum calculation.

One thread does many send()'s  -> this also gets serialized by the
kernel.

Or:  one thread vs. many threads reading from the disk -> makes no difference
since there is *one* buffer layer, one driver, one disk etc. etc.

My question is:   Does it change anything in the way the TCP stack
can crank out packets, if I change the number of threads in user-space
making the system calls ?

Does the fine-grained locking allow multiple user-space threads to
actually have TCP checksums etc. done on multiple CPUs concurrently,
and is it true that this will not happen if I have one user-space
thread doing non-blocking send() calls ?

Thanks,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
