Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932549AbWARAVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932549AbWARAVv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932550AbWARAVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:21:51 -0500
Received: from ms-smtp-03-smtplb.tampabay.rr.com ([65.32.5.133]:60365 "EHLO
	ms-smtp-03.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932549AbWARAVt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:21:49 -0500
Message-ID: <43CD8A19.3010100@cfl.rr.com>
Date: Tue, 17 Jan 2006 19:21:45 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051010)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Michael Loftis <mloftis@wgops.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: FYI: RAID5 unusably unstable through 2.6.14
References: <E1EywcM-0004Oz-IE@laurel.muq.org> <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
In-Reply-To: <B34375EBA93D2866BECF5995@d216-220-25-20.dynip.modwest.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your understanding of statistics leaves something to be desired.  As you 
add disks the probability of a single failure is grows linearly, but the 
probability of double failure grows much more slowly.  For example:

If 1 disk has a 1/1000 chance of failure, then
2 disks have a (1/1000)^2 chance of double failure, and
3 disks have a (1/1000)^2 * 3 chance of double failure
4 disks have a (1/1000)^2 * 7 chance of double failure

Thus the probability of double failure on this 4 drive array is ~142 
times less than the odds of a single drive failing.  As the probably of 
a single drive failing becomes more remote, then the ratio of that 
probability to the probability of double fault in the array grows 
exponentially.

( I think I did that right in my head... will check on a real calculator 
  later )

This is why raid-5 was created: because the array has a much lower 
probabiliy of double failure, and thus, data loss, than a single drive. 
  Then of course, if you are really paranoid, you can go with raid-6 ;)


Michael Loftis wrote:
> Absolutely not.  The more spindles the more chances of a double failure. 
> Simple statistics will mean that unless you have mirrors the more drives 
> you add the more chance of two of them (really) failing at once and 
> choking the whole system.
> 
> That said, there very well could be (are?) cases where md needs to do a 
> better job of handling the world unravelling.
> -
