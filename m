Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRA2PNi>; Mon, 29 Jan 2001 10:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131487AbRA2PN2>; Mon, 29 Jan 2001 10:13:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51216 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131290AbRA2PNL>;
	Mon, 29 Jan 2001 10:13:11 -0500
Date: Mon, 29 Jan 2001 16:12:51 +0100
From: Jens Axboe <axboe@suse.de>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Dieter Nuetzel <Dieter.Nuetzel@hamburg.de>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Linux-2.4.1-pre11 / ll_rw_b watermark metric?
Message-ID: <20010129161251.F19381@suse.de>
In-Reply-To: <13F3075C2004@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13F3075C2004@vcnet.vc.cvut.cz>; from VANDROVE@vc.cvut.cz on Mon, Jan 29, 2001 at 11:56:13AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29 2001, Petr Vandrovec wrote:
> On 29 Jan 01 at 4:43, Dieter Nützel wrote:
> > I have pre11 running with Andrea's suggested fix.
> >
> >         high_queued_sectors = total_ram / 3;
> >         low_queued_sectors = high_queued_sectors / 2;
> >         if (low_queued_sectors < 0)
> >                 low_queued_sectors = total_ram / 2;
> >
> 
> I have one question: How it can happen that low_queued_sectors
> is less than zero with this changed logic? (And if it get triggered,
> low_queued_sectors will be greater than high_queued_sectors - which
> is not what we want...)

This wasn't my change, but you're right it's wrong.

> But it is certainly better than 2.4.0-pre8 approach, as
> with 200MB of memory (exactly 192MB left unused) you can end up with
> low_queued_sectors == 0... And it does not give you optimal behavior.

Same here, definitely not right either. Dunno how I missed that.

-- 
Jens Axboe

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
