Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWIEB1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWIEB1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 21:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWIEB1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 21:27:37 -0400
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:37343 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1751527AbWIEB1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 21:27:36 -0400
Date: Tue, 5 Sep 2006 10:30:10 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       saito.tadashi@soft.fujitsu.com, ak@suse.de, oleg@tv-sign.ru,
       jdelvare@suse.de
Subject: Re: [PATCH] proc: readdir race fix.
Message-Id: <20060905103010.5f744bee.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 04 Sep 2006 17:13:10 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:
> These better semantics are implemented by scanning through the
> pids in numerical order and by making the file offset a pid
> plus a fixed offset.
I think this is very sane/solid approach.
Maybe this is the way to go. I'll test and ack later, thank you.

> The pid scan happens on the pid bitmap, which when you look at it is
> remarkably efficient for a brute force algorithm.  Given that a typical
> cache line is 64 bytes and thus covers space for 64*8 == 200 pids.  There
> are only 40 cache lines for the entire 32K pid space.  A typical system
> will have 100 pids or more so this is actually fewer cache lines we have
> to look at to scan a linked list, and the worst case of having to scan
> the entire pid bitmap is pretty reasonable.

I agree with you but..
Becasue this approach has to access *all* task structs in a system,
and have to scan pidhash many times. I'm not sure that this scan & lookup
is good for future implementation. But this patch is obviously better than
current implementation.



>  /*
> + * Used by proc to find the pid with the first
> + * pid that is greater than or equal to number.
> + *
> + * If there is a pid at nr this function is exactly the same as find_pid.
> + */
> +struct pid *find_next_pid(int nr)
> +{

How about find_first_used_pid(int nr) ?

-Kame

