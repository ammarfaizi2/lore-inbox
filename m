Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262157AbUKDKYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262157AbUKDKYc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 05:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbUKDKYc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 05:24:32 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:37249 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S262157AbUKDKYY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 05:24:24 -0500
Date: Thu, 4 Nov 2004 11:26:55 +0100
From: DervishD <lkml@dervishd.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Gene Heskett <gheskett@wdtv.com>, linux-kernel@vger.kernel.org,
       Valdis.Kletnieks@vt.edu,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
Message-ID: <20041104102655.GB23673@DervishD>
Mail-Followup-To: Bill Davidsen <davidsen@tmr.com>,
	Gene Heskett <gheskett@wdtv.com>, linux-kernel@vger.kernel.org,
	Valdis.Kletnieks@vt.edu,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
References: <20041103194226.GA23379@DervishD> <418965E0.8070508@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <418965E0.8070508@tmr.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
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
> >    I think that the parent (which is whatever process did the fork
> >when you clicked your mouse) is still alive and forgetting to do the
> >'wait()' for its children.
> It would be good to know what the PPID is, from ps or similar. Things 
> from X are a pain, the parent is often something you don't want to kill. 
> Sometimes you can reparent from command line, "bash -c foo&" or similar, 
> so the parent can be killed without logging out.

    Just use ps to reveal the family tree. Is not that hard ;)
 
> I would swear that the parent *is* init in some cases, which is puzzling 
> since they should be reaped.

    But that's OK :))) When a parent dies without waiting for its
children, the zombies are reparented to init. That's correct. Then
init will wait for them. The problem is that sometimes the signals
doesn't arrive or the like. Then the zombies are laying around a bit,
until a timer in 'init' reaps them. That's correct too: init can only
wait for children when it receives SIGCHLD or periodically, using a
timer. I've written a init program and that's the way I do it, just
in case some signal gets lost.

    If init is the parent, all works ok, just wait a bit and all
those zombies will really die ;)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
