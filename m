Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262118AbTIWRWm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 13:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbTIWRWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 13:22:42 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18949 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S262118AbTIWRWT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 13:22:19 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: suid bit behaviour modification in 2.6.0-test5
Date: 23 Sep 2003 17:12:59 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bkpuur$e63$1@gatekeeper.tmr.com>
References: <3F6CF491.9030205@free.fr> <200309220425.21862.lkml@ordinal.freeserve.co.uk>
X-Trace: gatekeeper.tmr.com 1064337179 14531 192.168.12.62 (23 Sep 2003 17:12:59 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200309220425.21862.lkml@ordinal.freeserve.co.uk>,
Ian Hastie  <lkml@ordinal.freeserve.co.uk> wrote:
| On Sunday 21 Sep 2003 01:45, Jean-pierre Cartal wrote:
| > Hello,
| >
| > I'm running a standard RH 9 installation upgraded to kernel 2.6.0-test5
| > with rpms from http://people.redhat.com/arjanv/2.5/RPMS.kernel/.
| >
| > I noticed that contrary to what was happening with 2.4.x kernel, suid
| > root files don't loose their suid bit when they get overwritten by a
| > normal user (see example below)
| >
| > Is this the intended behaviour or a bug ?
| 
| I got the same results.  However it seems the bug is something to do with a 
| directory listing cache somewhere.  If you sync after copying over the file 
| the suid bit is shown as having been cleared.

Well, if ls gets that bit as still set, what would happen if someone
actually ran the program before the sync was done? COuld the file be
modified and then run? Is there a window? Still smells bugish.
| 
| $ touch suid_test
| 
| # chown root suid_test
| # chmod 4775 suid_test
| 
| $ ls -l
| total 0
| -rwsrwxr-x    1 root     ianh            0 Sep 22 04:21 suid_test
| $ cp /bin/ls suid_test
| $ ls -l
| total 68
| -rwsrwxr-x    1 root     ianh        69228 Sep 22 04:22 suid_test
| $ sync
| $ ls -l
| total 68
| -rwxrwxr-x    1 root     ianh        69228 Sep 22 04:22 suid_test
| 
| -- 
| Ian.
| 
| -
| To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
| the body of a message to majordomo@vger.kernel.org
| More majordomo info at  http://vger.kernel.org/majordomo-info.html
| Please read the FAQ at  http://www.tux.org/lkml/
| 


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
