Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262939AbVGNHm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262939AbVGNHm4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 03:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbVGNHm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 03:42:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48533 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262939AbVGNHmz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 03:42:55 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Arjan van de Ven <arjan@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Lee Revell <rlrevell@joe-job.com>,
       dean gaudet <dean-list-linux-kernel@arctic.org>,
       Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
       "Brown, Len" <len.brown@intel.com>, dtor_core@ameritech.net,
       vojtech@suse.cz, david.lang@digitalinsight.com, davidsen@tmr.com,
       kernel@kolivas.org, linux-kernel@vger.kernel.org, mbligh@mbligh.org,
       diegocg@gmail.com, azarah@nosferatu.za.org, christoph@lameter.com
In-Reply-To: <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
References: <42D540C2.9060201@tmr.com>
	 <Pine.LNX.4.62.0507131022230.11024@qynat.qvtvafvgr.pbz>
	 <20050713184227.GB2072@ucw.cz>
	 <Pine.LNX.4.58.0507131203300.17536@g5.osdl.org>
	 <1121282025.4435.70.camel@mindpipe>
	 <d120d50005071312322b5d4bff@mail.gmail.com>
	 <1121286258.4435.98.camel@mindpipe> <20050713134857.354e697c.akpm@osdl.org>
	 <20050713211650.GA12127@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131639130.13193@twinlark.arctic.org>
	 <20050714005106.GA16085@taniwha.stupidest.org>
	 <Pine.LNX.4.63.0507131810430.13193@twinlark.arctic.org>
	 <1121304825.4435.126.camel@mindpipe>
	 <Pine.LNX.4.58.0507131847000.17536@g5.osdl.org>
Content-Type: text/plain
Date: Thu, 14 Jul 2005 09:42:18 +0200
Message-Id: <1121326938.3967.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> IOW, nothing ever sees any "variable frequency", and there's never any 
> question about what the timer tick is: the timer tick is 2kHz as far as 
> everybody is concerned. It's just that the ticks sometimes come in 
> "bunches of 20".

btw we can hide all of this a lot nicer from just about the entire
kernel by reducing the usage of both HZ and jiffies in drivers/non
platform code. That isn't hard; msleep() is a good step forward there
already; the next step is a nicer api for add_timer/mod_timer that is
both relative and in miliseconds; with those 2 the majority of code that
has "knowledge" about this shrinks to near zero. Once we have that the
actual implementation of this in the background matters a whole lot
less.

