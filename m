Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbUCJOci (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 09:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262623AbUCJOci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 09:32:38 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:45770 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S262622AbUCJOcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 09:32:33 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Brice Figureau <brice@daysofwonder.com>
Date: Wed, 10 Mar 2004 15:32:00 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: PROBLEM: task->tty->driver problem/oops in proc_pid_sta
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, wli@holomorphy.com
X-mailer: Pegasus Mail v3.50
Message-ID: <48F1C131BD@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Mar 04 at 11:54, Brice Figureau wrote:

> I've digged a little deeper into the following oops that occurs every
> night on my servers (see my previous mail):

Or you could dig LKML archives - I reported it in jan & feb three times.

> Something interesting: the oops occurs always in a thread (either mysql
> or java), not in a principal process (verified by finding the only task
> that is locked by doing some cat in /proc/<pid>/task/).

wli has a patch, unfortunately for some reason it did not hit
main kernel yet. I've put it (without Wli's permission) at 
http://platan.vc.cvut.cz/ftp/pub/linux/pidstat.patch.
For unknown reason patch did not find its way to Linus's kernel yet,
although it renders 2.6.x unusable in any multiuser environment.

> Then I tried to reproduce it exactly and found the following:
> 1) log in with ssh on the server (this allocates a tty: /dev/pts/0)
> 2) launch a java application using some threads, the application in
> question uses /dev/pts/0 as tty
> 3) log-out, this releases /dev/pts/0
> 4) log in again (this session uses /dev/pts/1)
> 5) run chkrootkit or a 'ps mauxgww' -> the previous oops is reported.

I have simple C program which you run under normal account on any
2.6.x kernel and it will turn box into dead piece of metal if SMP
kernel is used, or at least all 'ps' services stop (on UP kernel).
Not useful as exploit, but quite sufficient as a DoS.
                                                            Petr Vandrovec
                                                            

