Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWCQJN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWCQJN0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 04:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbWCQJN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 04:13:26 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:42710 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1751500AbWCQJN0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 04:13:26 -0500
Message-ID: <441A7DA5.7070303@aitel.hist.no>
Date: Fri, 17 Mar 2006 10:13:09 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bret Towe <magnade@gmail.com>
CC: Neil Brown <neilb@suse.de>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: nfs udp 1000/100baseT issue
References: <dda83e780603151424u1b3ea605vd6e8dea896fc276e@mail.gmail.com>	 <Pine.LNX.4.61.0603162139450.11776@yvahk01.tjqt.qr>	 <dda83e780603161733o10a3c330kddf96a726f162fa7@mail.gmail.com>	 <17434.7434.626268.71114@cse.unsw.edu.au> <dda83e780603161911o7c2babb7wfc6671f9bc3441e4@mail.gmail.com>
In-Reply-To: <dda83e780603161911o7c2babb7wfc6671f9bc3441e4@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bret Towe wrote:

>On 3/16/06, Neil Brown <neilb@suse.de> wrote:
>  
>
>>There is no flow control in UDP
>>    
>>
>
>is this a linux design flaw or just nature of udp?
>  
>
That has nothing to do with linux at all.

"Now flow control in udp" is a udp design issue.  And it is not
a flaw either - the rule is simple:

If you need flow control - use tcp.
If you don't need flow control, and don't want the
overhead of flow control - use udp.

Udp is for those cases where flow control is consideres a waste of time.

Now, the original decision to base early NFS on udp, that was
a design mistake.  Again, not a linux problem but a nfs problem.
Fortunately, today a solution for this exists and is implemented
in linux - and it is nfs over tcp.

>>.  If anything gets lots, the client
>>has to resend the request, and the server then has to respond again.
>>If the respond is large (e.g. a read) and gets fragmented (if > 1500bytes)
>>then there is a good chance that one or more fragments of a reply will
>>get lots in the switch stepping down from 1G to 100M.  Every time.
>>
>>Your options include:
>>
>>  - use tcp
>>    
>>
>
>im wondering why this isnt the default to begin with
>  
>
Hard to say.  I guess someone thought they could get better
performance with udp - it has less overhead.,
Then didn't bother testing this idea with a somewhat congested network?

Helge Hafting
