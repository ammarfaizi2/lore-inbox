Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130070AbQK0LWL>; Mon, 27 Nov 2000 06:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129963AbQK0LWB>; Mon, 27 Nov 2000 06:22:01 -0500
Received: from ns.caldera.de ([212.34.180.1]:52240 "EHLO ns.caldera.de")
        by vger.kernel.org with ESMTP id <S129768AbQK0LVs>;
        Mon, 27 Nov 2000 06:21:48 -0500
Date: Mon, 27 Nov 2000 11:49:50 +0100
From: Christoph Hellwig <hch@ns.caldera.de>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: Friedrich Lobenstock <fl@fl.priv.at>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kbuild@torque.net, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org
Subject: Re: [KBUILD] Re: [BUG] 2.4.0-test11-ac3 breaks raid autodetect (was Re: [BUG] raid5 link error? (was [PATCH] raid5 fix after xor.c cleanup))
Message-ID: <20001127114950.A12206@caldera.de>
Mail-Followup-To: Neil Brown <neilb@cse.unsw.edu.au>,
        Friedrich Lobenstock <fl@fl.priv.at>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kbuild@torque.net,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <20001117234144.A14461@spaans.ds9a.nl> <20001118123536.A5674@spaans.ds9a.nl> <20001118235352.D2226@spaans.ds9a.nl> <14872.29479.901021.472890@notabene.cse.unsw.edu.au> <3A2074CC.8219AB99@fl.priv.at> <14881.50316.705469.752219@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <14881.50316.705469.752219@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Mon, Nov 27, 2000 at 01:18:52PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 01:18:52PM +1100, Neil Brown wrote:
> Thanks for this....
> 
> I have looked more deeply, and discovered the error of my ways.
> As the Makefiles now stand, all export-objs (OX_OBJS) get linked
> before non-export-objs (O_OBJS) in the same directory, independantly
> of any ordering imposed within the Makefile.

Yes.

> This caused md.o to get linked before raid?.o.
> Due to carelessness on my part I didn't notice this happening when I
> was testing.
> 
> The following patch fixes it.  I hope the change to Rules.make is
> acceptable - I have CCed to linux-kbuild incase anyone there has an
> issue with it.

I don't think so.  Look at drivers/usb/Makefile for an other (cleaner)
solution to solve this.  I don't think it is a good idea to solve the
same problem with two different hacks...

	Christoph

-- 
Always remember that you are unique.  Just like everyone else.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
