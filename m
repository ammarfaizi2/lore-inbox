Return-Path: <linux-kernel-owner+w=401wt.eu-S932279AbXADHRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbXADHRM (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 02:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbXADHRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 02:17:12 -0500
Received: from smtp104.mail.mud.yahoo.com ([209.191.85.214]:20583 "HELO
	smtp104.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932279AbXADHRL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 02:17:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=TSUHqVY4tYRzGNDsSganj53SXISkmepBFTmxycRFmpCYaaL9r2wI/cW5E/jOZZGK8douJ2WingTG4PJnjY3ZVixYVPpzv/G6QcfH10wD6hrIbIY0GmUdD4/hS8KACHTUBJUy2Jcf9KNaC4eHE7CKyV0DCSYVHm+DFySVBzPRvmE=  ;
X-YMail-OSG: NQNrRjQVM1lMsF9CXBg48XFT5OeNFyob.CVPJ.e4jFLDHuiit_mdQQVmwSYZ_tD0RFpRjMijRtQcOd9d95diCn_zatz6h9qNoHO_4Gi.wx2GomqjCo2RDXM8NSfRKisvUnZmtjVLeq6TD28-
Message-ID: <459CA9D5.4080708@yahoo.com.au>
Date: Thu, 04 Jan 2007 18:16:37 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: David Miller <davem@davemloft.net>, torvalds@osdl.org, gelma@gelma.net,
       linux-kernel@vger.kernel.org
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
References: <20070103214121.997be3e6.akpm@osdl.org>	<459C98BF.5080409@yahoo.com.au>	<20070103221220.c4589831.akpm@osdl.org>	<20070103.225607.133169483.davem@davemloft.net> <20070103230629.a2e734b9.akpm@osdl.org>
In-Reply-To: <20070103230629.a2e734b9.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 03 Jan 2007 22:56:07 -0800 (PST)
> David Miller <davem@davemloft.net> wrote:

>>>>Anyway that leaves us with the question of why Andrea's database is getting
>>>>corrupted. Hopefully he can give us a minimal test-case.
>>>
>>>It'd odd that stories of pre-2.6.19 BerkeleyDB corruption are now coming
>>>out of the woodwork.  It's the first I've ever heard of them.
>>
>>Note that the original rtorrent debian bug report was against 2.6.18
> 
> 
> I think that was 2.6.18+debian-added-dirty-page-tracking-patches.
> 
> If that memory is correct, I'll assert (and emphasise) that the cause of the
> alleged BerkeleyDB corruption is not known at this time.

I think that's right. Even if it were plain 2.6.18 that had rtorrent
corruption, then it would be more evidence we still have an unidentified
bug, because none of the patches fixed anything we have found to be
buggy in 2.6.18.

> The post-2.6.19 "fix" might make it go away.  But if it does, we do not know
> why, and it might still be there, only harder to hit.

Likely. I think it is only hiding the bug (maybe the writeout patterns
from shared dirty accounting are changing timings or codepaths).

Of course, this means that we still can't confirm whether or not it is a
kernel bug. It could be a BDB bug that's being hidden.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
