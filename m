Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264540AbTCYUm1>; Tue, 25 Mar 2003 15:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264539AbTCYUm1>; Tue, 25 Mar 2003 15:42:27 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:35592 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S264540AbTCYUmZ>;
	Tue, 25 Mar 2003 15:42:25 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200303252053.h2PKrRn09596@oboe.it.uc3m.es>
Subject: Re: [PATCH] ENBD for 2.5.64
In-Reply-To: <1048623613.25914.14.camel@lotte> from Justin Cormack at "Mar 25,
 2003 08:20:08 pm"
To: Justin Cormack <justin@street-vision.com>
Date: Tue, 25 Mar 2003 21:53:27 +0100 (MET)
Cc: linux kernel <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin Cormack wrote:"
> On Tue, 2003-03-25 at 17:27, Peter T. Breuer wrote:
> > > ENBD is not a replacement for NBD - the two are alternatives, aimed
> > > at different niches.  ENBD is a sort of heavyweight industrial NBD.  It
> > > does many more things and has a different achitecture.  Kernel NBD is
> > > like a stripped down version of ENBD.  Both should be in the kernel.
> 
> hmm, I would argue that nbd is ok, as it is a nice lightweight block
> device (though I have not been able to use it due to the fact that I can
> never find a userspace and kernel that work together), while ENBD should
> be replaced by iscsi, now that is a real ietf standard, and can burn CDs
> across the net and all that extra stuff.

It's not a bad idea. But ENBD in particular can use any transport,
precisely becuase its networking is done in userspace. One only has to
write a stream.c module for it that implements

    read
    write
    open
    close

(There are currently implementations for three transports, including
tcp of course).    

> And I am intending to write an iscsi client sometime, but it got
> delayed. The server stuff is already available from 3com.

Possibly, but ENBD is designed to fail :-). And networks fail.
What will your iscsi implementation do when somebody resets the
router? All those issues are handled by ENBD. ENBD breaks off and
reconnects automatically. It reacts right to removable media.

I should also have said that ENBD has the following features (I said I
forgot some!)

  9) it drops into a mode where it md5sums both ends and skips writes
  of equal blocks, if that's faster. It moves in and out of this mode
  automatically. This helps RAID resyncs (2* overspeed is common on
  100BT nets, that is 20MB/s.).

  10) integration with RAID - it advises raid correctly of its state
  and does hot add and remove correctly (well, you need my patches to 
  raid, but there you are ...).

Of course, if somebody wants me to make enbd appear like a scis device
instead of a generic block device, I guess I could do that. Except,
that yecch, I have seen the scsi code, and I do not understand it.

Another good idea is to make the wire protocol iscsi compatible. I
have no objection to that.
   
Peter
