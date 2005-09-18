Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbVIRIHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbVIRIHv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 04:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbVIRIHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 04:07:51 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:12174 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S1751325AbVIRIHu (ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 04:07:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=vQj1HP/XZz0O3vIPJokn75xANJhokl6eXBwkQNX/E8n5C7u5KMxsv+pi+fCv/+XtoujyVRYej6qOsSc65cYMyO8sakDrrx2Wej+ZEeYfAAWHY4KX7YayBn5XV+JHxReVoBrcvfobEiq8hiGBig4m/mLin9T9lAOCpuM6QaGzru8=  ;
Message-ID: <432D2083.6030707@yahoo.com.au>
Date: Sun, 18 Sep 2005 18:08:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.10) Gecko/20050802 Debian/1.7.10-1
X-Accept-Language: en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au> <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au> <Pine.LNX.4.61.0509141906040.3728@scrub.home> <20050914230049.F30746@flint.arm.linux.org.uk> <Pine.LNX.4.61.0509150010100.3728@scrub.home> <20050914232106.H30746@flint.arm.linux.org.uk> <4328D39C.2040500@yahoo.com.au> <Pine.LNX.4.61.0509170300030.3743@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0509170300030.3743@scrub.home>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 15 Sep 2005, Nick Piggin wrote:
> 
> 
>>Roman: any ideas about what you would prefer? You'll notice
>>atomic_inc_not_zero replaces rcuref_inc_lf, which is used several times
>>in the VFS.
> 
> 
> In the larger picture I'm not completely happy with these scalibilty 
> patches, as they add extra overhead at the lower end. On a UP system in 
> general nothing beats:
> 
> 	spin_lock();
> 	if (*ptr)
> 		ptr += 1;
> 	spin_unlock();
> 
> The main problem is here that the atomic functions are used in two basic 
> situation:
> 
> 1) interrupt synchronization
> 2) multiprocessor synchronization
> 
> The atomic functions have to assume both, but on UP systems it often is 
> a lot cheaper if they don't have to synchronize with interrupts. So 
> replacing a spinlock with a few atomic operations can hurt UP performance.
> 

Maybe so, but what I'm doing is introducing a slightly better
implementation of what is currently in tree, and attempting to
follow current standards as far as possible. I don't think you
could say that is a bad thing.

Now I don't think anyone would be flat out opposed to 1 - reworking
the atomic.h code to allow some genericity (is that a word?); 2 -
reworking atomic.h code to allow combining of atomic ops, or allowing
interrupt unsafe ops...

Of course, neither is going to be merged unless done tastefully, and
I imagine both would be difficult to get right, with probably a low
cost/benefit ratio.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
