Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271931AbRIDKZj>; Tue, 4 Sep 2001 06:25:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271932AbRIDKZa>; Tue, 4 Sep 2001 06:25:30 -0400
Received: from ns.suse.de ([213.95.15.193]:28179 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271931AbRIDKZO>;
	Tue, 4 Sep 2001 06:25:14 -0400
Date: Tue, 4 Sep 2001 12:25:24 +0200
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, jeffm@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [SOLVED + PATCH]: documented Oops running big-endian reiserfs on parisc architecture
Message-ID: <20010904122524.A26403@gruyere.muc.suse.de>
In-Reply-To: <20010903003437.A385@linux-m68k.org.suse.lists.linux.kernel> <20010903213835.A13887@fury.csh.rit.edu.suse.lists.linux.kernel> <oupoforxpc1.fsf@pigdrop.muc.suse.de> <20010904.030454.85412225.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010904.030454.85412225.davem@redhat.com>; from davem@redhat.com on Tue, Sep 04, 2001 at 03:04:54AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2001 at 03:04:54AM -0700, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: 04 Sep 2001 11:44:30 +0200
> 
>    Jeff Mahoney <jeffm@suse.com> writes:
>    
>    >     I did kick around the idea of making those macros the default accessors for
>    >     the deh_state member (which is the only place they're used), but it unfairly
>    >     penalizes arches that don't need them.
>    
>    On archs that don't need them {get,put}_unaligned should be just normal
>    assignments. They are certainly on i386.
> 
> I can also almost guarentee you that the x86 will sometimes not
> execute these bitops atomically on SMP.

It's not needed when you have another lock to protect and don't have
interrupt threads.

iirc near all of reiserfs still runs under the BKL. BKL/schedule are full
memory barriers.

> What's more, you will have less QA'ing to do, since this code will
> always be in use and thus tested.

I think for a fs it is best to go with bigger locks and avoid the issue
of atomic operations completely.

-Andi
