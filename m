Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267972AbUHEVi7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267972AbUHEVi7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 17:38:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267991AbUHEVhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 17:37:48 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:54237 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S267972AbUHEVfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 17:35:30 -0400
Message-ID: <4112A91B.6090508@am.sony.com>
Date: Thu, 05 Aug 2004 14:39:39 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Lee Revell <rlrevell@joe-job.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dsingleton@mvista.com, lkml@rtr.ca
Subject: Re: [PATCH] Configure IDE probe delays
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>	 <1091226922.5083.13.camel@localhost.localdomain>	 <1091232770.1677.24.camel@mindpipe>	 <200407311434.59604.vda@port.imtp.ilyichevsk.odessa.ua>	 <1091297179.1677.290.camel@mindpipe> <1091302522.6910.4.camel@localhost.localdomain>
In-Reply-To: <1091302522.6910.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> If you want to speed this up then the two bits that the initial proposal
> and Jeff have sensibly come up with are
> 
> 1.	Are we doing too many probes

By way of commentary, it *is* possible to reduce the number of probes
using existing kernel command line options (hd<x>=noprobe and
ide<x>=noprobe)  This helps on systems where interfaces or devices
are known not to exist.  This is described in my OLS paper, and I
plan to put up a wiki page with instructions for interested parties,
real soon now... :-)

However, further reducing the number of probes is still a worthy goal.
We'll take a look at this when we get a chance.  Given some
of the feedback on this thread, this sounds like it might be prone
to worse breakage for legacy hardware than simply adjusting the delay
duration.

> 2.	Should we switch to proper reset polling
> 
> For certain cases (PPC spin up) we actually have switched to doing drive
> spin up this way...

I'm not sure what this means.  Can someone tell me more about this
or point me to some code?  (Sorry for my ignorance, I'm not an IDE
expert by any means.)

BTW - Any comments on Todd's new patch? (see message with title
"IDE probe delay symbol")  This one doesn't make the value configurable,
but does use a #define (preserving the traditional 50 ms value).  This
at least removes a magic number, and it makes it easier to identify the
msleeps that have historically been related.

With this new patch, nothing changes for the legacy crowd, but it still
makes it easier for RACER_BOYs ;-) to dink with the value.

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
