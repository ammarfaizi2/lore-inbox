Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLKNuK>; Mon, 11 Dec 2000 08:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129511AbQLKNuA>; Mon, 11 Dec 2000 08:50:00 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:21403 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129183AbQLKNtq>; Mon, 11 Dec 2000 08:49:46 -0500
Message-ID: <3A34D455.7208BE2F@haque.net>
Date: Mon, 11 Dec 2000 08:19:17 -0500
From: "Mohammad A. Haque" <mhaque@haque.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Miles Lane <miles@megapathdsl.net>, Frank Davis <fdavis112@juno.com>,
        linux-kernel@vger.kernel.org
Subject: Re: INIT_LIST_HEAD marco audit
In-Reply-To: <E145SRT-0007sM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thinko.

Question is... Adam Richter posted a patch for i2o_lan.c that does
this...

static struct tq_struct i2o_post_buckets_task = {
	list: LIST_HEAD_INIT(i2o_post_buckets_task.list),
	sync: 0,
	routine: (void (*)(void *))i2o_lan_receive_post,
	data: (void *) 0
};

If that's correct then is the only fix for structures similar to
tcic_task to type cast the routine?

Alan Cox wrote:
> 
> > -static struct tq_struct tcic_task = {
> > -     routine:        tcic_bh
> > +DECLARE_TASK_QUEUE(tcic_task);
> > +struct tq_struct run_tcic_task = {
> > +     routine:        (void (*)(void *)) tcic_bh
> >  };
> 
> Why remove the 'static' ?

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/ 
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
