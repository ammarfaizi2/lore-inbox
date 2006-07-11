Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWGKSox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWGKSox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWGKSox
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:44:53 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:25714 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932101AbWGKSow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:44:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=KQgEDpqoLLgPyukeMav75eOfUrGCITq++pWFacK+9Lo3p/PuTuS6qTQCP8lAq87AoVSCWmgD5VNLTsd7ZlK+10tTxoS3Abq+lgKcBYcndwv10sBlDM+E+MNoAtCoiNFZnJouKPB4clf6AJyjgVFKtYf7OcGvz0Q+uf/HHlFnGYo=  ;
Message-ID: <44B39151.10600@yahoo.com.au>
Date: Tue, 11 Jul 2006 21:53:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Joshua Hudson <joshudson@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] 'volatile' in userspace
References: <44B0FAD5.7050002@argo.co.il>  <MDEHLPKNGKAHNMBLJOLKMEPGNAAB.davids@webmaster.com>  <20060709195114.GB17128@thunk.org> <20060709204006.GA5242@nospam.com>  <20060710034250.GA15138@thunk.org> <bda6d13a0607101000w6ec403bbq7ac0fe66c09c6080@mail.gmail.com> <44B29461.40605@yahoo.com.au> <Pine.LNX.4.61.0607110945580.30961@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0607110945580.30961@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:
>>What's wrong with _exit(exec() == -1 ? 0 : errno);
>>and picking up the status with wait(2) ?
>>
> 
> The exec'd application may return regular error codes, which would 
> interfere. IIRC /usr/sbin/useradd has different exit codes depending on 
> what failed (providing some option, failure to create account, failure to 
> create home dir, etc.). Now if you exit(errno) instead, you have an 
> overlap.

You're right. Maybe you could return -ve or with a high bit set,
but I guess you may not know what the app will return.

But I don't see how the volatile or pipe solutions are any better
though: it would seem that both result in undefined behaviour
according to my vfork man page. At least the wait() solution is
defined (and workable, if you know what the target might return).

> And your code is somewhat wrong. Given that exec() would stand for 
> execve(someprogram_and_args_here), if it returned -1 you would return 0, 
> indicating success. Can't be. And if exec() does not return -1, which it 
> never should, you return errno, which never reaches anyone.

Yeah, thinko.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
