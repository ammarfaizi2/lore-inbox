Return-Path: <linux-kernel-owner+w=401wt.eu-S1030394AbWLTWUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWLTWUp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWLTWUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:20:45 -0500
Received: from blue.stonehenge.com ([209.223.236.162]:31875 "EHLO
	blue.stonehenge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030382AbWLTWUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:20:44 -0500
X-Greylist: delayed 925 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 17:20:44 EST
To: Linus Torvalds <torvalds@osdl.org>
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [BUG] daemon.c blows up on OSX (was Re: What's in git.git (stable), and Announcing GIT 1.4.4.3)
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
x-mayan-date: Long count = 12.19.13.16.7; tzolkin = 8 Manik; haab = 0 Kankin
From: merlyn@stonehenge.com (Randal L. Schwartz)
Date: 20 Dec 2006 14:20:42 -0800
In-Reply-To: <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
Message-ID: <86irg6yzt1.fsf_-_@blue.stonehenge.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Linus" == Linus Torvalds <torvalds@osdl.org> writes:

>> Is this really in master?  I'm still seeing one-hour times on
>> my Mac, using 8336afa563fbeff35e531396273065161181f04c.

Linus> Master right  now is at 54851157ac.

Yeah, 54 objects just pulled down.  Here we go.  Time for a test...

Nope... can't compile:

    gcc -o daemon.o -c -g -O2 -Wall  -I/sw/include -I/opt/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRLCPY daemon.c
    daemon.c: In function 'parse_extra_args':
    daemon.c:414: warning: implicit declaration of function 'strncasecmp'
    daemon.c: In function 'socksetup':
    daemon.c:766: error: 'NI_MAXSERV' undeclared (first use in this function)
    daemon.c:766: error: (Each undeclared identifier is reported only once
    daemon.c:766: error: for each function it appears in.)
    daemon.c:766: warning: unused variable 'pbuf'
    daemon.c: In function 'serve':
    daemon.c:970: warning: implicit declaration of function 'initgroups'
    make: *** [daemon.o] Error 1

This smells like we've seen this before.  Regression introduced with
some of the cleanup?

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
