Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbWDUFtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbWDUFtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 01:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbWDUFtR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 01:49:17 -0400
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:26744 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750751AbWDUFtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 01:49:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=c9lkBluJPs3vtQ3b2B9XrP9ktaFzv8a9J9hBwghSJ9kKr3Bcpvht8nB0kRs3jIDVz78u7HpyyDc3sh71Lr/9d2oz/WH+ZOXgnfYdYnGk22p/7jjEK8n2OaVb/sB4Me9leGzvvVYCZ9hr0kivO2X3lqd/MehobKoFAqMMaRts4PE=  ;
Message-ID: <4447E8DB.6000807@yahoo.com.au>
Date: Fri, 21 Apr 2006 06:02:35 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Linh Dang <linhd@nortel.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.17-rc2
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org>	<20060419200001.fe2385f4.diegocg@gmail.com>	<Pine.LNX.4.64.0604191111170.3701@g5.osdl.org>	<20060420145041.GE4717@suse.de>	<wn5fyk85bw7.fsf@linhd-2.ca.nortel.com>	<20060420194914.GL4717@suse.de> <wn53bg858b2.fsf@linhd-2.ca.nortel.com>
In-Reply-To: <wn53bg858b2.fsf@linhd-2.ca.nortel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linh Dang wrote:
> Jens Axboe <axboe@suse.de> wrote:

>>DVD burning probably isn't a good splice fit, since you need to do
>>more than actually just point the device at the data. SG_IO is
>>already zero-copy as it maps the user data into the kernel without
>>copying, so there's very little room for improvement there to begin
>>with.
> 
> 
> DVD burning on linux is mostly:
> 
>         mkisofs .... | growisofs ....
> 
> Ideally, on mkisofs side, we'd be able to:
> 
>   - write some data/padding into the pipe
>   - splice a HUGE file into the pipe
>   - write some data/padding into the pipe
>   - splice a HUGE file into the pipe
>   ...
> 
> On growisofs side, we'd be able to:
> 
>   - send some commands
>   - splice N MBs of data from the pipe to the driver
>   - send some commands
>   - splice M MBs of data from the pipe to the driver
>   ...
> 
> What'd be nice is an ioctl to change the size of the pipe between
> mkisofs and growisofs.

I don't see why the pipe buffers would be a problem though. It isn't
like you've lost any of the pagecache buffering (eg. from readahead)
or the application level buffering.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
