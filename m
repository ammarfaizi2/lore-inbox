Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751397AbWDYHp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbWDYHp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 03:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWDYHpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 03:45:25 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:12890 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751397AbWDYHpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 03:45:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=rp7+apC95HfaY48qPfpPnwrU3TRM2UF8VGbCMZ4GIOvZUE0KnijSPUN/YINE2vsyaYEUx6IgPuFAk2W0PnJAHTtS5dm4Svn6eJaVlRQXUJSeJP/T0HZkTzHayKohv/65i7X8SKZtJ96drh90+yOTCzEX7H+TUnMXmDVLKbRyNY8=  ;
Message-ID: <444DCE65.5050906@yahoo.com.au>
Date: Tue, 25 Apr 2006 17:23:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
References: <200511142327.18510.a1426z@gawab.com> <200604241412.13267.a1426z@gawab.com> <444CB588.6090105@yahoo.com.au> <200604241637.56637.a1426z@gawab.com>
In-Reply-To: <200604241637.56637.a1426z@gawab.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Nick Piggin wrote:
> 
>>Al Boldi wrote:
>>
>>>Could do that by:
>>>
>>>	# echo 1 > /proc/sys/kernel/su-pid
>>>
>>>which would imply nr-threads = 1
>>>
>>>So maybe introduce /proc/sys/kernel/nr-threads to allow that to be
>>>variable, but this isn't really critical.
>>
>>Why not just have su-nr-threads?
> 
> 
> Unless I am misunderstanding you, even root/root-proc can be hit by a 
> runaway, so the threads-max limits this globally which is great, but this 
> may lock-you out of being able to control the situation based on uid only.
> 
> Thus this patch gives root the ability to allow a certain pid to exceed the 
> threads-max limit, while all other pids are still limited.

But the point is that root is able to get their pids under control,
and can't be DoSed by unpriv users. Right?

Nothing is going to be perfect, I mean the su-pid pid could get "hit
bya runaway" and is arguably worse than nr-threads-su, because it has
no upper limit and coult take down the whole system.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
