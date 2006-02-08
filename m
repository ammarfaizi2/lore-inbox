Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030470AbWBHDAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030470AbWBHDAV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 22:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWBHDAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 22:00:21 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:23460 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1030470AbWBHDAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 22:00:19 -0500
From: Con Kolivas <kernel@kolivas.org>
To: gcoady@gmail.com
Subject: Re: 2.6 vs 2.4, ssh terminal slowdown
Date: Wed, 8 Feb 2006 14:00:59 +1100
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
References: <j4kiu1de3tnck2bs7609ckmt89pfoumlbe@4ax.com> <200602081335.18256.kernel@kolivas.org> <24niu1hrom6udfa2km18b8bagad62kjamc@4ax.com>
In-Reply-To: <24niu1hrom6udfa2km18b8bagad62kjamc@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602081400.59931.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Feb 2006 01:55 pm, Grant Coady wrote:
> On Wed, 8 Feb 2006 13:35:18 +1100, Con Kolivas <kernel@kolivas.org> wrote:
> >On Wed, 8 Feb 2006 01:11 pm, Grant Coady wrote:
> >> Hi there,
> >>
> >> grant@deltree:~$ uname -r
> >> 2.6.15.3a
> >> grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log| cut
> >> -c-95 ...
> >> 2006-02-08 12:38:13 +1100: bugsplatter.mine.nu 193.196.182.215 "GET
> >> /test/linux-2.6/tosh/ HTTP/
> >>
> >> real    0m8.537s
> >> user    0m0.970s
> >> sys     0m1.100s
> >>
> >> --> reboot to 2.4.32-hf32.2
> >>
> >> grant@deltree:~$ uname -r
> >> 2.4.32-hf32.2
> >> grant@deltree:~$ time grep -v 192\.168\. /var/log/apache/access_log| cut
> >> -c-95 ...
> >> 2006-02-08 12:38:13 +1100: bugsplatter.mine.nu 193.196.182.215 "GET
> >> /test/linux-2.6/tosh/ HTTP/
> >>
> >> real    0m2.271s
> >> user    0m0.730s
> >> sys     0m0.540s
> >>
> >> Still a 4:1 slowdown, machine .config and dmesg info:
> >>   http://bugsplatter.mine.nu/test/boxen/deltree/
> >
> >What happens if you add "| cat" on the end of your command?
>
> It gets faster with 2.4.32-hf32.2 by a little bit (I forgot to copy)
>
> reboot to 2.6.15.3a, without...
>
> real    0m8.737s
> user    0m1.030s
> sys     0m1.200s
>
> with...  oh shit / surprise!!
>
> real    0m1.861s
> user    0m0.560s
> sys     0m0.370s
>
> What is that telling me / you / us?

Heh.

This is the terminal's fault. xterm et al use an algorithm to determine how 
fast your machine is and decide whether to jump scroll or smooth scroll. This 
algorithm is basically broken with the 2.6 scheduler and it decides to mostly 
smooth scroll.

Cheers,
Con
