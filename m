Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVFUQRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVFUQRT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbVFUQQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 12:16:49 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:59349 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262161AbVFUQPb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 12:15:31 -0400
Date: Tue, 21 Jun 2005 09:14:52 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Domen Puncer <domen@coderock.org>, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 04/12] block/xd: replace schedule_timeout() with msleep()
Message-ID: <20050621161452.GA4175@us.ibm.com>
References: <20050620215133.675387000@nd47.coderock.org> <Pine.LNX.4.61L.0506211233490.9446@blysk.ds.pg.gda.pl> <20050621132100.GL3906@nd47.coderock.org> <Pine.LNX.4.61L.0506211451180.9446@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61L.0506211451180.9446@blysk.ds.pg.gda.pl>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.06.2005 [14:53:49 +0100], Maciej W. Rozycki wrote:
> On Tue, 21 Jun 2005, Domen Puncer wrote:
> 
> > mdelay - busy loop
> > msleep - schedule
> 
>  Right -- that's my mistake.  But what's the point of the change in the 
> first place anyway?  The original code is correct.

Please refer to the comment in the description:

schedule_timeout(1) is ambiguous in older/unchanged code since 2.4, as
it indicated a 10 millisecond sleep then. Now, in 2.6, it indicates a 1
millisecond sleep (HZ==1000). I am trying to prevent issues like this
coming up in the future (CONFIG_HZ has hit -mm, e.g.) and msleep() is a
good way to do so.

If you are trying to sleep for the shortest amount of time possible (a
tick), though, then the code is fine, I guess. A comment may be useful,
though.

Thanks,
Nish
