Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263460AbREYABC>; Thu, 24 May 2001 20:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263461AbREYAAv>; Thu, 24 May 2001 20:00:51 -0400
Received: from femail8.sdc1.sfba.home.com ([24.0.95.88]:20658 "EHLO
	femail8.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S263460AbREYAAf>; Thu, 24 May 2001 20:00:35 -0400
Message-ID: <3B0DA0BA.5895592F@home.com>
Date: Thu, 24 May 2001 20:00:58 -0400
From: Willem Riede <wriede@home.com>
X-Mailer: Mozilla 4.7 [en] (X11; U; Linux 2.2.15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Junfeng Yang <yjf@Stanford.EDU>
CC: Dawson Engler <engler@csl.stanford.edu>, linux-kernel@vger.kernel.org,
        mc@CS.Stanford.EDU
Subject: Re: [CHECKER] null bugs in 2.4.4 and 2.4.4-ac8
In-Reply-To: <Pine.GSO.4.31.0105241532450.11846-100000@elaine24.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang wrote:
> 
> On Thu, 24 May 2001, Willem Riede wrote:
> 
> > Dawson Engler wrote:
> > >
> > > Hi All,
> > >
> > > Enclosed are 103 potential errors where code gets a pointer from a
> > > possibly-failing routine (kmalloc, etc) and dereferences it without
> > >
> > > [BUG] osst_do_scsi will never return NULL if argument SRpnt isn't NULL. But they copy SRpnt back by *aSRpnt, implies it could be NULL
> >
> > No. It implies SRpnt could have changed. The functions flagged
> > (osst_read_back_buffer_and_rewrite and osst_reposition_and_retry)
> > cannot be reached with SRpnt == NULL. So these are false alarms.
> 
> these are false positives if osst_read_back_buffer_and rewrite can't be
> reached with SRpnt == NULL. It seems that osst_do_scsi will not change
> SRpnt unless it is NULL though.

That is currently true, and the re-assignment of SRpnt is superfluous but
harmless. It is not a design constraint though that SRpnt cannot change
(except it can't change to NULL), so I prefer to leave the code as is.

>                                 In other words, SRpnt is changed by
> osst_do_scsi <=> the initial argument SRpnt == NULL. Probabaly the pointer
> aSRpnt is useless.
> 
The pointer aSRpnt is not useless, it's used to communicate the current
value of SRpnt throughout the driver.

Regards, Willem Riede.
