Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262349AbULCU4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbULCU4y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 15:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262360AbULCU4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 15:56:53 -0500
Received: from siaag1ad.compuserve.com ([149.174.40.6]:55804 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S262349AbULCU4w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 15:56:52 -0500
Date: Fri, 3 Dec 2004 15:52:59 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Time sliced CFQ io scheduler
To: Jens Axboe <axboe@suse.de>
Cc: "Prakash K. Cheemplavam" <prakashkc@gmx.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Neil Brown <neilb@cse.unsw.edu.au>
Message-ID: <200412031555_MC3-1-8FF2-32E7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Dec 2004 at 11:31:30 +0100 Jens Axboe wrote:

>> Yeas, I have linux raid (testing md1). Have appield both settings on 
>> both drives and got a interesting new pattern: Now it alternates. My 
>> email client is still not usale while writing though...
>
> Funky. It looks like another case of the io scheduler being at the wrong
> place - if raid sends dependent reads to different drives, it screws up
> the io scheduling. The right way to fix that would be to io scheduler
> before raid (reverse of what we do now), but that is a lot of work. A
> hack would be to try and tie processes to one md component for periods
> of time, sort of like cfq slicing.

 How about having the raid1 read balance code send each read to every drive
in the mirror, and just take the first one that returns data?  It could then
cancel the rest, or just ignore them...  ;)


--Chuck Ebbert  03-Dec-04  15:43:54
