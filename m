Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318227AbSGWWWB>; Tue, 23 Jul 2002 18:22:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318231AbSGWWWB>; Tue, 23 Jul 2002 18:22:01 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:50186 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S318227AbSGWWWA>; Tue, 23 Jul 2002 18:22:00 -0400
Date: Tue, 23 Jul 2002 18:19:32 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Hildo.Biersma@morganstanley.com, linux-kernel@vger.kernel.org
Subject: Re: close return value
In-Reply-To: <20020718195501.A21027@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.3.96.1020723181210.2194D-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002, Pete Zaitcev wrote:


>  1. Make close to block indefinitely, retrying writes.

We went through this with sync() a while ago. You don't want things to
loop forever. That's what status returns are for, if the program wants to
retry it can. Consider the f/s being out of space, the write can't work,
the process can't die, the f/s can't unmount because there's i/o in
progress, the system can't shutdown cleanly.

Let the program handle the problems, and decide what to retry.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
  for (;;) exit(0);

