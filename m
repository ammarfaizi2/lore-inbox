Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269670AbTGJWu7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbTGJWu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:50:59 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:41999 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S269670AbTGJWu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:50:56 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
Date: Thu, 10 Jul 2003 23:05:37 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bekrg1$c9m$2@news.cistron.nl>
References: <bejhrj$dgg$1@news.cistron.nl> <20030710112728.GX15452@holomorphy.com> <bejnl9$m9l$1@news.cistron.nl> <20030710155643.GY15452@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1057878337 12598 62.216.29.200 (10 Jul 2003 23:05:37 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030710155643.GY15452@holomorphy.com>,
William Lee Irwin III  <wli@holomorphy.com> wrote:
>In article <20030710112728.GX15452@holomorphy.com>, William Lee Irwin
>III  <wli@holomorphy.com> wrote:
>>>        since = now - lastkill;
>>>        if (since < HZ*5)
>>>                goto out_unlock;
>>> try s/goto out_unlock/goto reset/ and let me know how it goes.
>
>On Thu, Jul 10, 2003 at 12:54:01PM +0000, Miquel van Smoorenburg wrote:
>> But that will only change the rate at which processes are killed,
>> not the fact that they are killed in the first place, right ?
>> As I said I've got plenty memory free ... perhaps I need to tune
>> /proc/sys/vm because I've got so much streaming I/O ? Possibly,
>> there are too many dirty pages so cleaning them out faster might
>> help (and let pflushd do it instead of my single-threaded app)
>
>That's not what it's supposed to do. The thought behind it is that since
>out_of_memory()'s count is not reset unless it's been 5s since the last
>time this was ever invoked, it will happen on a regular basis after the
>first kill if it is invoked regularly. It's actually a bit too late,
>since something's already been killed, but it should make a larger
>difference than merely altering the rate.

Well, that won't help in my case, as my problem is not that many
processes are killed - it's just that every few minutes (sometimes
3 minutes, sometimes 30, sometimes an hour) an innocent process
gets killed (just one) with 2.5.74-mm3. And that did not happen 
with 2.5.74 or 2.5.72-mm2

Mike.

