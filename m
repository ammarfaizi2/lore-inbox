Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313123AbSC1Jur>; Thu, 28 Mar 2002 04:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313126AbSC1Jui>; Thu, 28 Mar 2002 04:50:38 -0500
Received: from ucs.co.za ([196.23.43.2]:63762 "EHLO ucs.co.za")
	by vger.kernel.org with ESMTP id <S313123AbSC1Ju1>;
	Thu, 28 Mar 2002 04:50:27 -0500
Subject: Re: VIA text console corruption and fix.
From: Berend De Schouwer <bds@jhb.ucs.co.za>
To: Steven Walter <srwalter@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020327225549.GA5337@hapablap.dyn.dhs.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 28 Mar 2002 11:33:21 +0200
Message-Id: <1017308002.23088.243.camel@bds.ucs.co.za>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-28 at 00:55, Steven Walter wrote:
> On Wed, Mar 27, 2002 at 09:17:30PM +0200, Berend De Schouwer wrote:
> [...]
> > I have 3000+ identical VIA KT133/Duron 750MHz machines.  In 20% of these
> > the bug is visible, in the others, it isn't.  The machines run in an
> > LTSP-ish configuration.  The machines are supposed to be identical (they
> > were bought together), but have different revisions of BIOS versions,
> > etc.  They have on-board S3 Savage cards that steal RAM from the main
> > RAM.
> 
> Aha, another.  You're the fourth or fifth person with this problem.  I
> have a patch very similar to yours.  What my patch does is only clear
> bit 7, which is what was experimentally determined to disable the Write
> Memory Queue.  So far it seems that only KM133 (KT133 w/onboard S3
> Savage) are afflicted.

Well, these boards use KL133s (not KM133s).  The KL133 also has an
integrated S3 ProSavage card.

Maybe another bit seems to need setting somewhere.  But where?
 
> However, the patch isn't being accepted until an explanation from VIA is
> obtained (apparently the head kernel honcho's were explicitly told to
> clear bit 5).  I'm working on that now.

I've been told the same.  Clearing bit 5 is apparently necessary to
prevent IDE crruption.  Asus lists two motherboards, one with a KL133,
one with a KL133A.  It looks like the motherboards using KL133s are
broken, and the KL133As work.

How bad is "not clearing bit 5"?
How bad is 

  if ((device_id = kl133) || (device_id = km133)) {
     /* Don't clear bit 5 */
  }

Is it possible to clear bit 5, but not bit X, to fix it?

> -- 
> -Steven
> In a time of universal deceit, telling the truth is a revolutionary act.
> 			-- George Orwell
> He's alive.  He's alive!  Oh, that fellow at RadioShack said I was mad!
> Well, who's mad now?
> 			-- Montgomery C. Burns
-- 
Berend De Schouwer

