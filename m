Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269413AbTGJPlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbTGJPlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:41:04 -0400
Received: from holomorphy.com ([66.224.33.161]:26034 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S269413AbTGJPko (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:40:44 -0400
Date: Thu, 10 Jul 2003 08:56:43 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.74-mm3 OOM killer fubared ?
Message-ID: <20030710155643.GY15452@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miquel van Smoorenburg <miquels@cistron.nl>,
	linux-kernel@vger.kernel.org
References: <bejhrj$dgg$1@news.cistron.nl> <20030710112728.GX15452@holomorphy.com> <bejnl9$m9l$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bejnl9$m9l$1@news.cistron.nl>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030710112728.GX15452@holomorphy.com>, William Lee Irwin III  <wli@holomorphy.com> wrote:
>>        since = now - lastkill;
>>        if (since < HZ*5)
>>                goto out_unlock;
>> try s/goto out_unlock/goto reset/ and let me know how it goes.

On Thu, Jul 10, 2003 at 12:54:01PM +0000, Miquel van Smoorenburg wrote:
> But that will only change the rate at which processes are killed,
> not the fact that they are killed in the first place, right ?
> As I said I've got plenty memory free ... perhaps I need to tune
> /proc/sys/vm because I've got so much streaming I/O ? Possibly,
> there are too many dirty pages so cleaning them out faster might
> help (and let pflushd do it instead of my single-threaded app)

That's not what it's supposed to do. The thought behind it is that since
out_of_memory()'s count is not reset unless it's been 5s since the last
time this was ever invoked, it will happen on a regular basis after the
first kill if it is invoked regularly. It's actually a bit too late,
since something's already been killed, but it should make a larger
difference than merely altering the rate.

-- wli
