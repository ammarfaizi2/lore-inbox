Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbUJ1Sws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbUJ1Sws (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 14:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbUJ1StS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 14:49:18 -0400
Received: from web12822.mail.yahoo.com ([216.136.174.203]:23208 "HELO
	web12822.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262123AbUJ1SoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 14:44:16 -0400
Message-ID: <20041028184406.55475.qmail@web12822.mail.yahoo.com>
Date: Thu, 28 Oct 2004 11:44:06 -0700 (PDT)
From: Shantanu Goel <sgoel01@yahoo.com>
Subject: Re: ext3 multiple thread streaming write performance with 2.6.9
To: Arjan van de Ven <arjan@infradead.org>
Cc: Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1098950444.2642.6.camel@laptop.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointer Arjan.  That worked out well.
Here are the numbers I got for 2.6.9 with reservation
patches applied from 2.6.9-mm1.

  ext3:data=ordered,reservation: 1: 47 48 48 (47)
  ext3:data=ordered,reservation: 2: 47 44 45 (46)
  ext3:data=ordered,reservation: 4: 45 43 45 (44)
ext3:data=writeback,reservation: 1: 47 49 48 (48)
ext3:data=writeback,reservation: 2: 48 46 44 (46)
ext3:data=writeback,reservation: 4: 46 45 45 (45)
                           ext2: 1: 53 55 54 (54)
                           ext2: 2: 42 52 51 (48)
                           ext2: 4: 21 26 25 (24)
                            xfs: 1: 53 53 53 (53)
                            xfs: 2: 48 53 51 (51)
                            xfs: 4: 43 47 46 (45)

--- Arjan van de Ven <arjan@infradead.org> wrote:

> On Wed, 2004-10-27 at 21:04 -0700, Shantanu Goel
> wrote:
> > Hi,
> > 
> > I am seeing extremely variable and poor
> performance
> > with ext3 in the presence of multiple streaming
> > writers.  Below are the results of some tests I
> have
> > conducted with iozone.  XFS appears to be most
> > consistent performer for this workload, followed
> by
> > ext2 and finally ext3.  Has this been observed
> > elsewhere?  If so, is it possible to tune ext3 to
> > perform better on this workload?
> 
> yes you should use the reservations patch from the
> -mm tree;
> see http://people.redhat.com/arjanv/reservations.png
> for a graph of the difference 
> 
> 



		
__________________________________
Do you Yahoo!?
Read only the mail you want - Yahoo! Mail SpamGuard.
http://promotions.yahoo.com/new_mail 
