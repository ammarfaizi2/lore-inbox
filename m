Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288090AbSACAkS>; Wed, 2 Jan 2002 19:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288089AbSACAik>; Wed, 2 Jan 2002 19:38:40 -0500
Received: from fep04.swip.net ([130.244.199.132]:8340 "EHLO fep04-svc.swip.net")
	by vger.kernel.org with ESMTP id <S288049AbSACAhe>;
	Wed, 2 Jan 2002 19:37:34 -0500
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] scheduler fixups ...
In-Reply-To: <Pine.LNX.4.40.0201021438500.1034-100000@blue1.dev.mcafeelabs.com>
From: Peter Osterlund <petero2@telia.com>
Date: 03 Jan 2002 01:36:28 +0100
In-Reply-To: <Pine.LNX.4.40.0201021438500.1034-100000@blue1.dev.mcafeelabs.com>
Message-ID: <m24rm4p8xf.fsf@pengo.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On 2 Jan 2002, Peter Osterlund wrote:
> 
> > Davide Libenzi <davidel@xmailserver.org> writes:
> >
> > > a still lower ts
> >
> > This also lowers the effectiveness of nice values. In 2.5.2-pre6, if I
> > run two cpu hogs at nice values 0 and 19 respectively, the niced task
> > will get approximately 20% cpu time (on x86 with HZ=100) and this
> > patch will give even more cpu time to the niced task. Isn't 20% too
> > much?
> 
> The problem is that with HZ == 100 you don't have enough granularity to
> correctly scale down nice time slices. Shorter time slices helps the
> interactive feel that's why i'm pushing for this.

OK, but even architectures with bigger HZ values will suffer. Isn't it
better to set MIN_NICE_TSLICE to a smaller value (such as 1000) and
fix the calculation in fill_tslice_map to make sure ts_table[i] is
always non-zero. The current formula will break anyway if

        HZ < 1000000 / MIN_NICE_TSLICE = 100,

but maybe HZ >= 100 is true for all architectures?

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
