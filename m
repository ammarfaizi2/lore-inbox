Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262485AbRFOCor>; Thu, 14 Jun 2001 22:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262865AbRFOCoh>; Thu, 14 Jun 2001 22:44:37 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:46884 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S262485AbRFOCo3>; Thu, 14 Jun 2001 22:44:29 -0400
Message-ID: <3B29B05A.38E89B02@redhat.com>
Date: Fri, 15 Jun 2001 02:51:06 -0400
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Kurt Garloff <garloff@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: SMP spin-locks
In-Reply-To: <Pine.LNX.3.95.1010614132506.10137B-100000@chaos.analogic.com> <20010614193501.F23383@garloff.etpnet.phys.tue.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kurt Garloff wrote:
> 
> On Thu, Jun 14, 2001 at 01:26:05PM -0400, Richard B. Johnson wrote:
> > Question 2: What is the purpose of the code sequence, "repz nop"
> 
> Puts iP4 into low power mode.

Umm, slightly more accurate would be to say that it makes the P4 processor
wait before resuming the loop to give the lock a chance to have been
released.  It makes the code go from a constant busy loop to a check/wait
small amount of time/check again loop.  This in turns keeps your processor
from trying to constantly check the lock itself which is suppossed to have
benefits in terms of inter-processor bus pressure.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
