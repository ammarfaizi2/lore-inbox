Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273379AbRIQBnv>; Sun, 16 Sep 2001 21:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273387AbRIQBnc>; Sun, 16 Sep 2001 21:43:32 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22004
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S273379AbRIQBnV>; Sun, 16 Sep 2001 21:43:21 -0400
Date: Sun, 16 Sep 2001 18:43:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
Message-ID: <20010916184339.H1564@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com> <20010917010927.A9308@schmorp.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010917010927.A9308@schmorp.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 01:09:27AM +0200,  Marc A. Lehmann  wrote:
> On Sun, Sep 16, 2001 at 03:58:35PM -0700, Mike Fedyk <mfedyk@matchmail.com> wrote:
> > #define BH_LowPrio	8	/* 1 if the buffer is lowprio */
> > #define BH_Temp         8       /* 1 if the buffer is temporary (unlinked)
> 
> Change BH_Temp to:
> 
> #define BH_Temp         9       /* 1 if the buffer is temporary (unlinked)
> 
> and it should work.
>                                      

/* bh state bits */
#define BH_Uptodate     0       /* 1 if the buffer contains valid data */
#define BH_Dirty        1       /* 1 if the buffer is dirty */
#define BH_Lock         2       /* 1 if the buffer is locked */
#define BH_Req          3       /* 0 if the buffer has been invalidated */
#define BH_Protected    6       /* 1 if the buffer is protected */
#define BH_Wait_IO      7       /* 1 if we should throttle on this buffer */
#define BH_Temp         8       /* 1 if the buffer is temporary (unlinked) */
#define BH_JWrite       9       /* 1 if being written to log (@@@ DEBUGGING)*/
#define BH_QuickFree    10      /* 1 if alloced and freed quickly (see below)*/
#define BH_Alloced      11      /* 1 if buffer has been allocated */
#define BH_Freed        12      /* 1 if buffer has been freed (truncated)*/
#define BH_Revoked      13      /* 1 if buffer has been revoked from the log*/
#define BH_RevokeValid  14      /* 1 if buffer revoked flag is valid */
#define BH_JDirty       15      /* 1 if buffer is dirty but journaled */

As you can see, that is already taken from ext3.  Is this ok?

#define BH_LowPrio      16      /* 1 if the buffer is temporary (unlinked)

Or do I only have 16 bits to work with?

TIA,

Mike
