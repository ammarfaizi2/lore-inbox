Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVDNHVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVDNHVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 03:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVDNHVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 03:21:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26336 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261450AbVDNHVw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 03:21:52 -0400
Date: Thu, 14 Apr 2005 09:21:49 +0200
From: Arjan van de Ven <arjanv@redhat.com>
To: tsuchiya yoshihiro <yt@labs.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SLEEP_ON_BKLCHECK
Message-ID: <20050414072149.GB15460@devserv.devel.redhat.com>
References: <425DBC76.60804@labs.fujitsu.com> <1113461190.6293.1.camel@laptopd505.fenrus.org> <425E190E.6000809@labs.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425E190E.6000809@labs.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 04:17:34PM +0900, tsuchiya yoshihiro wrote:
> Arjan van de Ven wrote:
> 
> >On Thu, 2005-04-14 at 09:42 +0900, tsuchiya yoshihiro wrote:
> >  
> >
> >>Hi,
> >>In Fedora Core3, interruptible_sleep_on() checks if the system is
> >>lock_kernel()'ed
> >>by SLEEP_ON_BKLCHECK. Same thing is done in RedHatEL4.
> >>Also I found a patch including SLEEP_ON_BKLCHECK was posted before,
> >>but is not included in 2.6.11.
> >>Why SLEEP_ON_BKLCHECK checks lock_kernel ?
> >>    
> >>
> >
> >Because you really need to hold the BKL when you call sleep_on() family
> >of APIs, otherwise you have a very big race.
> >
> >Also note that you in your code really should not call any of the
> >sleep_on() family of functions at all! It is a very very deprecated and
> >defective API!!!!
> >
> >  
> >
> Oh, I did not know that.
> What do you use instead? I found wait_event. Is that what you use?

yep 

> 
> Actually, I am porting my friend's code that runs on 2.4.X to 2.6.
> How is sleep_on in 2.4? You should not use sleep_on in 2.4 also?

correct, sleep_on in 2.4 is also broken and racey
