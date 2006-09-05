Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965099AbWIECi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965099AbWIECi2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 22:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965100AbWIECi2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 22:38:28 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:11164 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S965099AbWIECi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 22:38:27 -0400
Date: Tue, 5 Sep 2006 11:41:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       saito.tadashi@soft.fujitsu.com, ak@suse.de, oleg@tv-sign.ru,
       jdelvare@suse.de
Subject: Re: [PATCH] proc: readdir race fix.
Message-Id: <20060905114139.3af9254a.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060905103010.5f744bee.kamezawa.hiroyu@jp.fujitsu.com>
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
	<20060905103010.5f744bee.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.10; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Sep 2006 10:30:10 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> Hi,
> 
> On Mon, 04 Sep 2006 17:13:10 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> > These better semantics are implemented by scanning through the
> > pids in numerical order and by making the file offset a pid
> > plus a fixed offset.
> I think this is very sane/solid approach.
> Maybe this is the way to go. I'll test and ack later, thank you.
> 
Just a memo:

One interesting aspect of this patch is..

- default result of ps with current(old) kernel is naturally sorted by  starttime.
  then, ps command itself comes at the bottom of the result, as the newest process.

- default result of ps with this patch is sorted by pid, regardless of starttime.

==
kamezawa  3770  0.0  0.0  5156  996 tty1     S+   11:17   0:00 /bin/bash ./testp
kawamura  3989  0.0  0.0  2168  832 pts/3    S+   11:32   0:00 sh -c (cd /usr/sh
kawamura  3990  0.0  0.0  2168  408 pts/3    S+   11:32   0:00 sh -c (cd /usr/sh
kawamura  4002  0.0  0.0  1924  680 pts/3    S+   11:32   0:00 /usr/bin/less -iR
root     10772  0.0  0.0  6912 2188 ?        Ss   11:31   0:00 sshd: kawamura [p
kamezawa 12341  0.6  0.0  5336 1476 tty2     Ss   11:17   0:06 -bash
kamezawa 15308  0.0  0.0  4788  544 tty1     S+   11:32   0:00 sleep 1
kamezawa 15315  0.0  0.0  2380  756 pts/0    R+   11:32   0:00 ps aux
kamezawa 17322  0.0  0.0  5332 1472 tty3     Ss+  11:18   0:00 -bash
root     22194  0.0  0.0  1760  744 ?        Ss   11:20   0:00 in.telnetd: awork
root     22198  0.0  0.0  2992 1476 ?        Ss   11:20   0:00 login -- kamezawa
kawamura 24526  0.0  0.0  6912 1544 ?        S    11:31   0:00 sshd: kawamura@pt
kawamura 24529  0.0  0.0  5336 1456 pts/3    Ss   11:31   0:00 -bash
satoshi  26239  2.2  0.3 40292 13696 ?       Sl   11:30   0:02 /usr/bin/gnome-te
==

But 'ps --sort start_time' is available.

-Kame

