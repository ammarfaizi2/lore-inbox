Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbTDLNCq (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 09:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263265AbTDLNCq (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 09:02:46 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:43137 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S263264AbTDLNCp (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 09:02:45 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Eric Wong <eric@yhbt.net>
Subject: Re: 2.4.20-ck5 sucks
Date: Sat, 12 Apr 2003 23:16:16 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org
References: <200304121323.25094.kernel@kolivas.org> <20030412124132.GA3187@BL4ST>
In-Reply-To: <20030412124132.GA3187@BL4ST>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304122316.16785.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Apr 2003 22:41, Eric Wong wrote:
> Con Kolivas <kernel@kolivas.org> wrote:
> > It seems the interactivity patch wasn't worth the effort, confirming my
> > suspicions - which is why I resisted posting it in the first place.
>
> Yikes!  I've been indulging in 2.5.67 + anticipatory I/O for bit now,
> back to 2.4...
>
> I finally got around running ck5 with a lot of other odd patches from
> here and there just last night.  I wasn't sure if it was ck5 or any
> thing else I put in my kernel that caused it, but the scheduler didn't
> seem to want to work once physical memory was low.
>
> There's a pretty serious bug in the ck5 scheduler where things stop
> running after physical memory is low.  Even if the make World jobs are
> cancelled, performance is still sluggish.
<---snip-->

Eric I appreciate the work you've done for ck5, but this is two discrete 
problems. 

The first is the one you describe with the memory killing the scheduler - a 
serious bug. 

The second is that the interactivity patch is too slow. It takes up to 5 
seconds for xmms skipping (the reference bad program but used everywhere) to 
stop. When you first start music it skips all over the place and then settles 
down after a while. This is embarassing considering the machines are >1Ghz 
cpus and it doesnt happen on p233 with old scheduler. It appears to take less 
time the higher the Hz is (makes sense I guess) however higher Hz in 2.4 
incurs too much overhead under heavy load. This happens even in 2.5 but is a 
bit more subtle. 

My concern is that ck6pre without the interactivity addon works better. I've 
added the more finegrained scheduler timing and the small bugfix but backed 
out the rest. I don't think the interactivity patch in it's current form is 
of any use to O(1) 2.4 kernels.

I think Zwane and others have demonstrated that this happens in 2.5 as well so 
it needs some work yet to be better than stock.

Con
