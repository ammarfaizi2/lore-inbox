Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272668AbRIQEmL>; Mon, 17 Sep 2001 00:42:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273471AbRIQEmC>; Mon, 17 Sep 2001 00:42:02 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:247 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S273470AbRIQElx>; Mon, 17 Sep 2001 00:41:53 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Sun, 16 Sep 2001 22:42:11 -0600
To: linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
Message-ID: <20010916224211.H1541@turbolinux.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com> <20010917010927.A9308@schmorp.de> <20010916184339.H1564@mikef-linux.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010916184339.H1564@mikef-linux.matchmail.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16, 2001  18:43 -0700, Mike Fedyk wrote:
> > Change BH_Temp to:
> > 
> > #define BH_Temp         9       /* 1 if the buffer is temporary (unlinked)
> > 
> > and it should work.
> >                                      
> 
> /* bh state bits */
> #define BH_Uptodate     0       /* 1 if the buffer contains valid data */
> #define BH_Dirty        1       /* 1 if the buffer is dirty */
> #define BH_Lock         2       /* 1 if the buffer is locked */
> #define BH_Req          3       /* 0 if the buffer has been invalidated */
> #define BH_Protected    6       /* 1 if the buffer is protected */
> #define BH_Wait_IO      7       /* 1 if we should throttle on this buffer */
> #define BH_Temp         8       /* 1 if the buffer is temporary (unlinked) */
> #define BH_JWrite       9       /* 1 if being written to log (@@@ DEBUGGING)*/
> #define BH_QuickFree    10      /* 1 if alloced and freed quickly (see below)*/
> #define BH_Alloced      11      /* 1 if buffer has been allocated */
> #define BH_Freed        12      /* 1 if buffer has been freed (truncated)*/
> #define BH_Revoked      13      /* 1 if buffer has been revoked from the log*/
> #define BH_RevokeValid  14      /* 1 if buffer revoked flag is valid */
> #define BH_JDirty       15      /* 1 if buffer is dirty but journaled */
> 
> As you can see, that is already taken from ext3.  Is this ok?
> 
> #define BH_LowPrio      16      /* 1 if the buffer is temporary (unlinked)
> 
> Or do I only have 16 bits to work with?

No, you have 32 bits to work with.  In my ext3-2.2 patches I just increased
all of the ext3 numbers by one.  I don't think it is critical what number is
used in the end, as long as you don't get another patch defining these flags
(reiserfs uses these flags in 2.2 as well).

Cheers, Andreas
-- 
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

