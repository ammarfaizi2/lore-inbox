Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbUCWQPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 11:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbUCWQPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 11:15:44 -0500
Received: from news.cistron.nl ([62.216.30.38]:40629 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S262751AbUCWQPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 11:15:34 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Hidden PIDs in /proc
Date: Tue, 23 Mar 2004 16:15:33 +0000 (UTC)
Organization: Cistron Group
Message-ID: <c3pnr5$29f$1@news.cistron.nl>
References: <200403231708.15812.AlberT@agilemovement.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1080058533 2351 62.216.29.200 (23 Mar 2004 16:15:33 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200403231708.15812.AlberT@agilemovement.it>,
Emiliano 'AlberT' Gabrielli <AlberT@agilemovement.it> wrote:
>
>Hi all,
>
>   I discovered some "hidden" pid dirs in /proc :
>
>root@emc2:# ls -lha /proc/ | grep 4673
>root@emc2:# ls -lha /proc/4673/
>totale 0
>dr-xr-xr-x    3 albert   albert          0 2004-03-23 17:02 .
>dr-xr-xr-x  108 root     root            0 2004-03-23 16:10 ..

It's just a thread. For a threaded process, only the thread group
leader is listed in /proc directly. The other threads are visible
under /proc/<tgid>/task  (try it).

>After 2 days of headhake searching for possible rootkits, reinstalling all the 
>basic system, libs and so on (from a clean live-CD boot) ...
>I noticed that these process seem all to use pthreads ... so, the question is:
>
>is my problem related/solved by the initramfs-search-for-init-zombie-fix.patch
>in the -mm1 tree ??

No, by upgrading to a more recent procps.

# ps ax | grep mozilla
16252 ?        S     10:21 /usr/lib/mozilla-firefox/firefox-bin
$ ps ax -T | grep moz
16252 16252 ?        S     10:21 /usr/lib/mozilla-firefox/firefox-bin
16252 16264 ?        S      0:01 /usr/lib/mozilla-firefox/firefox-bin
16252 16266 ?        S      0:03 /usr/lib/mozilla-firefox/firefox-bin
16252 21530 ?        S      0:00 /usr/lib/mozilla-firefox/firefox-bin

Also note:

# ls /proc/16252/task
16252/  16264/  16266/  21530/

Mike.
-- 
Netu, v qba'g yvxr gur cynvagrkg :)

