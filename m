Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVGLO2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVGLO2o (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 10:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVGLO0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 10:26:51 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:7566 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261458AbVGLOZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 10:25:01 -0400
Subject: Re: [PATCH] i386: Selectable Frequency of the Timer Interrupt
From: Lee Revell <rlrevell@joe-job.com>
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Chris Friesen <cfriesen@nortel.com>, Diego Calleja <diegocg@gmail.com>,
       azarah@nosferatu.za.org, akpm@osdl.org, cw@f00f.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, christoph@lameter.org
In-Reply-To: <188690000.1121142633@[10.10.2.4]>
References: <200506231828.j5NISlCe020350@hera.kernel.org>
	 <20050708214908.GA31225@taniwha.stupidest.org>
	 <20050708145953.0b2d8030.akpm@osdl.org>
	 <1120928891.17184.10.camel@lycan.lan> <1120932991.6488.64.camel@mindpipe>
	 <20050709203920.394e970d.diegocg@gmail.com>
	 <1120934466.6488.77.camel@mindpipe>  <176640000.1121107087@flay>
	 <1121113532.2383.6.camel@mindpipe>  <42D2D912.3090505@nortel.com>
	 <1121128260.2632.12.camel@mindpipe>  <165840000.1121141256@[10.10.2.4]>
	 <1121141602.2632.31.camel@mindpipe>  <188690000.1121142633@[10.10.2.4]>
Content-Type: text/plain
Date: Tue, 12 Jul 2005 10:24:59 -0400
Message-Id: <1121178300.2632.51.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-11 at 21:30 -0700, Martin J. Bligh wrote:
> Exactly what problems
> *does* it cause (in visible effect, not "timers are less granular").
> Jittery audio/video? How much worse is it?

Yes, exactly.  Say you need to deliver a frame of audio or video every
5ms.  You have a rendering thread and a display thread that communicate
via FIFOs.  The main thread waits in select() for the next frame to
complete rendering or for the deadline to expire.  That's next to
impossible with HZ=100, because the best you can do is the deadline
+-10ms.  With HZ=1000 it's no problem.

Lee

