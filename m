Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317517AbSIIQ2L>; Mon, 9 Sep 2002 12:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317512AbSIIQ2L>; Mon, 9 Sep 2002 12:28:11 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:18055 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317508AbSIIQ2H>;
	Mon, 9 Sep 2002 12:28:07 -0400
Subject: Re: NFS lockd patch proposal for user-level control of the grace period
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: alan@lxorguk.ukuu.org.uk, hch@infradead.org, linux-kernel@vger.kernel.org,
       linux-kernel-owner@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.2a (Intl) 23 November 1999
Message-ID: <OF56438CB7.84FFBB03-ON87256C2F.005A4D15@us.ibm.com>
From: Juan Gomez <juang@us.ibm.com>
Date: Mon, 9 Sep 2002 09:31:24 -0700
X-MIMETrack: Serialize by Router on D03NM694/03/M/IBM(Build V60_09042002A|September 04, 2002) at
 09/09/2002 10:31:29
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





I think either way we get to the kernel would be ok with me. I picked
sysctl because some comments in the code susggested somebody already though
of supporting a sysctl gate to user land to export
grace period control, also Chrisptop suggested this was the way to go when
I previously proposed using the raw proc filesystem. I think what is nice
about sysctl is that it is extensible, If we use signals and some other
folks keep on using signals for other control purposed then they will
eventually run out and they will have to add sysctl anyway. Said that I
think either way serves the purpose I want.


Juan



|---------+---------------------------------->
|         |           Neil Brown             |
|         |           <neilb@cse.unsw.edu.au>|
|         |           Sent by:               |
|         |           linux-kernel-owner@vger|
|         |           .kernel.org            |
|         |                                  |
|         |                                  |
|         |           09/08/02 05:27 PM      |
|         |                                  |
|---------+---------------------------------->
  >-----------------------------------------------------------------------------------------------------------------------------|
  |                                                                                                                             |
  |       To:       Juan Gomez/Almaden/IBM@IBMUS                                                                                |
  |       cc:       Alan Cox <alan@lxorguk.ukuu.org.uk>, hch@infradead.org, linux-kernel@vger.kernel.org                        |
  |       Subject:  Re: NFS lockd patch proposal for user-level control of the grace period                                     |
  |                                                                                                                             |
  |                                                                                                                             |
  >-----------------------------------------------------------------------------------------------------------------------------|



On Friday September 6, juang@us.ibm.com wrote:
>
>
>
>
> Christoph, Alan, Neil,
>
> Attached you will find the patch with the sysctl implementation of my
> previous patch to enable grace period control from user-land.
> Please let me know if this looks good enough for inclusion in the kernel
> distribution or whether I still need to do something else.
> Note this piece is derived from net/sunrpc/sysctl.c, which by the way I
> think has a problem with the READ/WRITE verifys which seem
>  to be swicthed which I fixed in lockd version but not there, you may
want
> to take a look at net/sunrpc/sysctl.c and fix that although that's a
minor
> thing.
>
> (See attached file: lockd-sysctl.patch)
>

I still haven't managed to find out exactly what you want to do with
this, and hence whether it is appropriate.

You mentioned in another Email that this was for a High Availability
setup where one server might take-over a filesystem that another
server was previously serving.

If this is the case, do you really want to change the grace period, or
do you really want to re-start the grace period.
If that is what you really want, then I think that sysctl is
un-necessary and a simple signal would do the trick.
Currently, SIGKILL will
   1/ drop all locks held for clients
   2/ restart the grace period.

it would probably be quite sensible (and trivial to code) for SIGHUP
(say) to restart the grace period without dropping the locks.

Would this be suitable for you?

NeilBrown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



