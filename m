Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbUKJJ3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbUKJJ3o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 04:29:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbUKJJ3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 04:29:44 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:32923 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261552AbUKJJ3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 04:29:10 -0500
Date: Wed, 10 Nov 2004 10:11:16 +0100
From: DervishD <lkml@dervishd.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041110091116.GF29302@DervishD>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>,
	linux-kernel@vger.kernel.org
References: <20041104211138.GB25290@DervishD> <41915353.1070507@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41915353.1070507@tmr.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Bill :)

 * Bill Davidsen <davidsen@tmr.com> dixit:
> >    Probably it won't do. If the zombies are there due to a signal
> >delivery problem, sending a SIGCHLD to the parent will (probably)
> >solve the problem. But the common case is that the parent is screwed
> >up or simply so badly programmed that the only way of getting rid of
> >the zombies is to kill the parent...
> Wait a minute, in another message you just suggested that a SIGCHLD to 
> init would cause the status to be reaped.

    I don't consider init the parent of such processes. It just
'adopts' them when the real parent doesn't care for them. I was
talking, in the paragraph above, about the *real* parent. I don't see
any contradiction, although sending SIGCHLD to a program that has not
waited for a children is risky: if the programmer was so clueless
that children were not waited for in the first place, chances are
that SIGCHLD handling is damaged, too.

> >    Anyway I suppose that sending the SIGCHLD won't do any harm so it
> >may be worth trying.
> It won't hurt init, but some processes do use the SIGCHLD to trigger a 
> wait(), which might hang the parent.

    If a parent does 'wait()' instead of 'waitpid', that's lazy
programming. The signal won't hurt anyway: if the parent blocks (bug
in the program), then a 'kill -9' is the correct medication (it's
what I use for buggy programs), the children are reparented to init
and correctly handled (because a good init should, IMHO, use waitpid
instead of wait). Let's say that sending SIGCHLD is 'mostly harmless'
;))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
