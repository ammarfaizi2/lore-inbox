Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWEAGPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWEAGPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 02:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWEAGPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 02:15:15 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:5213 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751281AbWEAGPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 02:15:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=J1k5Kk+3p1Wpak+vFUb6q7Q3sJwE1ds3cPbM1diY+xYVbcOutRas1H3WH49ijGzSXZZOpH0U0vvqX3RUX2JH/cutXEUrlo+9XCpgRqVEEaTeepm3SXZzJLFNPXa3em4ZfuKQ8CiIClQZhlZDkoWprDA4EIBSoFr3rvd8SdmmO7w=  ;
Message-ID: <4455A764.1000307@yahoo.com.au>
Date: Mon, 01 May 2006 16:15:00 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 004 of 11] md: Increase the delay before marking metadata
 clean, and make it configurable.
References: <20060501152229.18367.patches@notabene>	<1060501053019.22949@suse.de>	<20060430224404.1060d29a.akpm@osdl.org> <17493.42109.153523.381980@cse.unsw.edu.au>
In-Reply-To: <17493.42109.153523.381980@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Sunday April 30, akpm@osdl.org wrote:
>
>>NeilBrown <neilb@suse.de> wrote:
>>
>>>
>>>When a md array has been idle (no writes) for 20msecs it is marked as
>>>'clean'.  This delay turns out to be too short for some real
>>>workloads.  So increase it to 200msec (the time to update the metadata
>>>should be a tiny fraction of that) and make it sysfs-configurable.
>>>
>>>
>>>...
>>>
>>>+   safe_mode_delay
>>>+     When an md array has seen no write requests for a certain period
>>>+     of time, it will be marked as 'clean'.  When another write
>>>+     request arrive, the array is marked as 'dirty' before the write
>>>+     commenses.  This is known as 'safe_mode'.
>>>+     The 'certain period' is controlled by this file which stores the
>>>+     period as a number of seconds.  The default is 200msec (0.200).
>>>+     Writing a value of 0 disables safemode.
>>>+
>>>
>>Why not make the units milliseconds?  Rename this to safe_mode_delay_msecs
>>to remove any doubt.
>>
>
>Because umpteen years ago when I was adding thread-usage statistics to
>/proc/net/rpc/nfsd I used milliseconds and Linus asked me to make it
>seconds - a much more "obvious" unit.  See Email below.
>It seems very sensible to me.
>

Either way, all ambiguity is removed if you put the unit in the name. And
don't use jiffies because that obviously is not portable (which sounds like
it was Linus' biggest concern).

Once you do that, I don't much care whether you use seconds or milliseconds.
Other than to note that many of our units now are ms, especially when 
they're
measuring things at or around the ms order of magnitude. But I'm not 
aware of
so many proc values that don't work in integers.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
