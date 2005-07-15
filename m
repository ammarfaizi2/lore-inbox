Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263258AbVGOJh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263258AbVGOJh2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 05:37:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263262AbVGOJh2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 05:37:28 -0400
Received: from main.gmane.org ([80.91.229.2]:58576 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S263258AbVGOJhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 05:37:24 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
Date: Fri, 15 Jul 2005 11:36:16 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.07.15.09.36.14.672407@smurf.noris.de>
References: <42D3E852.5060704@mvista.com> <42D540C2.9060201@tmr.com> <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz> <20050713184227.GB2072@ucw.cz> <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org> <1121282025.4435.70.camel@mindpipe> <d120d50005071312322b5d4bff@mail.gmail.com> <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org> <20050713211650.GA12127@taniwha.stupidest.org> <9a874849050714170465c979c3@mail.gmail.com> <1121386505.4535.98.camel@mindpipe> <Pine.LNX.4.58.0507141718350.19183@g5.osdl.org> <42D71A68.6030701@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bill Davidsen wrote:

> Do you actually have something against tickless, or just don't think it 
> can be done in reasonable time?

You can do it in small steps.

When you have that jiffies_increment variable, you can add code to
dynamically adjust it at runtime -- just reprogram the system timer
(which may not be cheap).

After you've done *that*, you can teach the add_timer code to optionally
adjust jiffies_increment when demand changes; add an estimate on timer
tick cost vs. reprogramming cost (which could return "always" when you're
running UML); you might want to take user prefs into account ("always
reprogram if the timeout would arrive more than 10 msec late, because
otherwise my Doom3 game lags too much").

There you are. Tickless, and nobody even notices.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Caesar had his Brutus -- charles the First, his Cromwell -- and George the
Third ("Treason!" cried the Speaker) -- may profit by their example. If this
be treason, make the most of it.
					-- Patrick Henry


