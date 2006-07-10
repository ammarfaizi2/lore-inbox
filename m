Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWGJJWk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWGJJWk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932494AbWGJJWk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:22:40 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:55750 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932491AbWGJJWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:22:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RL4lQjueo3YT/GMpNZC1bRoFyajEuy9HRmrOJRDHlz/xWHRJ1a9724S6ncGlBMnYRuUb3XSDw/o1k7p66jV5q5ApRXrf1iILwf7XnEusgcMm87k8bMVDG/2mHMSBBUmxuxfR49bTlau5KMed+5di0yO9ZiOrReVpPgNbC2um1Eo=
Message-ID: <6bffcb0e0607100222m5cbdba31ia39d47f3f1f94b26@mail.gmail.com>
Date: Mon, 10 Jul 2006 11:22:33 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.18-rc1-mm1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Arjan van de Ven" <arjan@infradead.org>
In-Reply-To: <20060710074039.GA26853@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060709021106.9310d4d1.akpm@osdl.org>
	 <6bffcb0e0607090332i477d594fq9ef96721574ae91b@mail.gmail.com>
	 <20060709035203.cdc3926f.akpm@osdl.org>
	 <20060710074039.GA26853@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

On 10/07/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Andrew Morton <akpm@osdl.org> wrote:
>
> > > This looks like a problem with cpufreq.
> > >
> > > =======================================================
> > > [ INFO: possible circular locking dependency detected ]
> > > -------------------------------------------------------
> > > cpuspeed/1426 is trying to acquire lock:
> > >  (&inode->i_data.tree_lock){.+..}, at: [<c0151dc7>] find_get_page+0x12/0x70
> > >
> > > but task is already holding lock:
> > >  (&mm->mmap_sem){----}, at: [<c0116cab>] do_page_fault+0x10d/0x4ea
> > >
> > > which lock already depends on the new lock.
> > >
> >
> > rofl.  You broke lockdep.
>
> ouch! the lock identifications look quite funny :-| Never saw that
> happen before,

:)

> i'm wondering what's going on. Michal, did this happen
> straight during bootup? Or did you remove/recompile/reinsert any modules
> perhaps?

It's happening while /etc/init.d/cpuspeed execution.

I forgot about "make O=/dir/ clean". When new -mm is out I always
remove kernel directory and create new one.

>
> > Well.  I guess it's barely conceivable that you earlier took an oops
> > while holding tree_lock, so lockdep decided that mmap_sem nests inside
> > tree_lock.
>
> Arjan is preparing a patch to turn off lockdep when we crash. Although i
> dont see any trace of an earlier oops in the dmesg.
>
>         Ingo
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
