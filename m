Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275287AbTHMRxG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 13:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275298AbTHMRxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 13:53:06 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:39950 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S275287AbTHMRw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 13:52:59 -0400
Date: Wed, 13 Aug 2003 20:00:20 +0200
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3-mm1 interactivity scheduling mistakes (smp)
Message-ID: <20030813180020.GA1339@hh.idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I ran a "nice make -j3 bzImage" on 2.6.9-test3-mm1 in order
to compile 2.6.0-test3-mm2 on my dual celeron.

While waiting I played cuyo, a lightweight game similiar to tetris.

This mostly behaved as expected, with a responsive game.
But mozilla (on some other virtual desktop) occationally
refreshed its page, causing several seconds with jerky response
in the game.

This is wrong for two reasons:
1. There should be enough cpu with two processors,
   one running the game and another the heavy mozilla stuff.
   The make was niced after all.  No guessing, I told it explicitly.

2. The game has very interactive behaviour, it uses  4-10% cpu
   and cause X to use about 20%.  Mozilla may have been idle for a 
   while, getting "interactive".  But it shouldn't remain
   interactive  for so long,  it sat at 100% till it went
   idle again.   

X runs with elevated priority, (std. debian testing setup)
but that shouldn't matter - X only used 20% and that was
for the game and two xterms.  Mozilla wasn't visible
at all.

Helge Hafting 
