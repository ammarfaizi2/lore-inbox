Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268186AbUHFRVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268186AbUHFRVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266561AbUHFRTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:19:36 -0400
Received: from out007pub.verizon.net ([206.46.170.107]:7048 "EHLO
	out007.verizon.net") by vger.kernel.org with ESMTP id S268190AbUHFRQ0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:16:26 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Fri, 6 Aug 2004 13:16:24 -0400
User-Agent: KMail/1.6.82
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, vda@port.imtp.ilyichevsk.odessa.ua,
       ak@suse.de, Chris Shoemaker <c.shoemaker@cox.net>,
       William Lee Irwin III <wli@holomorphy.com>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408060751.07605.gene.heskett@verizon.net> <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0408060948310.24588@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408061316.24495.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out007.verizon.net from [151.205.8.94] at Fri, 6 Aug 2004 12:16:25 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 12:58, Linus Torvalds wrote:
>On Fri, 6 Aug 2004, Gene Heskett wrote:
>> Linus, Andrew, should I apply this patch too at the next remake?
>
>Might be worth it, but it's more important to see any oops at all,
> or lack of oopses..
>
>> FWIW, I'm still up (20:38) this morning, and showing plenty (127+
>> megs) of free memory.  No crash, no odd log (other than samba
>> squawking about some option thats been changed & I haven't fixed
>> the smb.conf) so far.
>>
>> I'm beginning to like this test patch, Linus, thanks :)
>
>If the only thing you have done is add the list_del_init() debugging
>patch, then the only thing that has changed is really the access
> patterns to uncached memory.
>
>The original list_del_init() tries to only do a few single _writes_
> to the dentries around it. The added debugging will do _reads_ (and
> thus bring it into the cache) of the dentry pointers of the
> dentries around it.
>
>If that change makes a real difference, I really only see two
>possibilities:
> - there really is a prefetch bug (or possibly, there's a bug in our
>   prefetch fixup code, and the known prefetch bug just triggers the
>   problem indirectly)
> - it just changes the timing enough that whatever bug you hit went
> away.
>
>Now, Chris Shoemaker reported dentry problems on a intel CPU and
> said that wli had seen something too, but I'm wondering whether
> Chris and wli might have been seeing the knfsd/xfs-related dentry
> bug that I found yesterday. So I think the prefetch theory is still
> alive, but we should check with Chris. Chris?
>
>		Linus

I'm still up, a bit over 24 hours now. :)  Free memory is slowly going 
away, I ran mozilla for a while which got rid of about 60 megs, and 
now I see I'm down to 23 free, whereas at the 11 hour up marker I had 
nearly 130 megs free yet.  I've got to go to town, so that will leave 
seti and kmail doing their thing till I get back.  If it goes down, 
hopefully it will record something, unlike the last couple of times.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
