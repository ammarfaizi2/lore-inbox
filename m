Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268212AbUIPQFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268212AbUIPQFn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 12:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268206AbUIPQEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 12:04:00 -0400
Received: from mail.tmr.com ([216.238.38.203]:43012 "EHLO gatekeeper.tmr.com")
	by vger.kernel.org with ESMTP id S268280AbUIPP4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 11:56:54 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Bill Davidsen <davidsen@tmr.com>
Newsgroups: mail.linux-kernel
Subject: Re: [RFC, 2.6] a simple FIFO implementation
Date: Thu, 16 Sep 2004 11:57:34 -0400
Organization: TMR Associates, Inc
Message-ID: <ciccmu$ija$1@gatekeeper.tmr.com>
References: <20040913135253.GA3118@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Trace: gatekeeper.tmr.com 1095349791 19050 192.168.12.100 (16 Sep 2004 15:49:51 GMT)
X-Complaints-To: abuse@tmr.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
In-Reply-To: <20040913135253.GA3118@crusoe.alcove-fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> Hi all,
> 
> Is there a reason there is no API implementing a simple in-kernel
> FIFO ? A linked list is a bit overkill...
> 
> Besides my sonypi and meye drivers which could use this, there are
> quite a few other drivers which re-implement the circular buffer
> over and over again...
> 
> An initial implementation follows below. Comments ?

Many.

- you don't need both size and len, just the length
- you don't need a count of what's in the fifo, calc from tail-head
- you don't need remaining, when the tail reaches the head
   you're out of data.
- you want to do at most two memcpy operations, the loop is just
   unproductive overhead.
- if the fifo goes empty set the head and tail back to zero so you don't
   wrap (assumes doing just two memcpy ops) when you don't need to

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
