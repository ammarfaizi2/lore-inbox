Return-Path: <linux-kernel-owner+w=401wt.eu-S932335AbXAQOUj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbXAQOUj (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 09:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbXAQOUj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 09:20:39 -0500
Received: from wr-out-0506.google.com ([64.233.184.236]:15546 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbXAQOUi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 09:20:38 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=SB4YaaYHl3o2UrPwcW0AQYRRrsHJx3/7tUgyEIVYgW3WwM7hz4C8vIK6uQ4QaIp13YwSRPm8kobKj9eqRCQkjN5uiwUsWKMd1iCLiG2hJwYhpwHoFxih16A7NGIEG0fq0Ili9s+df/dukNPrNn4cVXdavSsFwZ4CAdKQjR8D30w=
Message-ID: <45AE30A8.70802@gmail.com>
Date: Wed, 17 Jan 2007 23:20:24 +0900
From: Tejun Heo <htejun@gmail.com>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19.1, sata_sil: sata dvd writer doesn't work
References: <45841710.9040900@t-online.de> <4587F87C.2050100@gmail.com> <45883299.2050209@t-online.de> <45887CD8.5090100@gmail.com> <458AE5FB.7080607@t-online.de> <4591FE96.1080606@gmail.com> <459346C4.1030802@gmail.com> <45941F1E.2080808@t-online.de> <459A482C.6020809@gmail.com> <45A296BC.8020208@t-online.de>
In-Reply-To: <45A296BC.8020208@t-online.de>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Harald Dunkel wrote:
> Hi Tejun,
> 
> Tejun Heo wrote:
>> Hello,
>>
>> Please do the following and post the result.
>>
>> # strace mplayer -v dvd:// > out 2>&1
>>
> 
> I had sent this out last week. Any news about this?

Okay, I just tested a number of dvds on x86-64 and x86.  The error
pattern is really interesting.  It doesn't matter whether you're on
x86-64 or x86, 2.6.18 or 2.6.20-rc5.  The problem occurs when a dvd
which doesn't match dvd's region mask is played.

MMC command 0xa4 (READ KEY) is the one which always fails.  After the
failure, the odd goes into strange state and usually won't respond to
commands.  Interestingly, if you pull the power plug or reset the
machine while the READ KEY command is in progress and then reconnect it,
you can play the DVD after that.  I've checked this multiple times and
no, dvdcss key caching isn't the cause, crossed checked it multiple times.

Once you played a dvd this way, the drive seems to remember the dvd and
successfully plays it afterwards.  I've checked this multiple times
using completely separate OS installation (one x86, the other x86-64).

This almost looks like new defense method against CSS-workaround.  Can't
understand why the drive remembers successfully played dvds tho.

This is NOT a kernel/driver bug.  Maybe libdvdread people are interested
in it.  You better take it to them.

-- 
tejun
