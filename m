Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132244AbRCVX1A>; Thu, 22 Mar 2001 18:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132245AbRCVX0u>; Thu, 22 Mar 2001 18:26:50 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:43875 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S132244AbRCVX0m>; Thu, 22 Mar 2001 18:26:42 -0500
Message-ID: <3ABA8B02.F28B333A@redhat.com>
Date: Thu, 22 Mar 2001 18:30:10 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Stephen Clouse <stephenc@theiqgroup.com>,
        Guest section DW <dwguest@win.tue.nl>,
        Rik van Riel <riel@conectiva.com.br>,
        "Patrick O'Rourke" <orourke@missioncriticallinux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent OOM from killing init
In-Reply-To: <E14gDxd-0003Tw-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > How do you return an out of memory error to a C program that is out of memory
> > > due to a stack growth fault. There is actually not a language construct for it
> >
> > Simple, you reclaim a few of those uptodate buffers.  My testing here has
> 
> If you have reclaimable buffers you are not out of memory. If oom is triggered
> in that state it is a bug. If you are complaining that the oom killer triggers
> at the wrong time then thats a completely unrelated issue.

Ummm, yeah, that would pretty much be the claim.  Real easy to reproduce too. 
Take your favorite machine with lots of RAM, run just a handful of startup
process and system daemons, then log in on a few terminals and do:

while true; do bonnie -s (1/2 ram); done

Pretty soon, system daemons will start to die.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
