Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269621AbTHDTsy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 15:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272166AbTHDTsy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 15:48:54 -0400
Received: from pc3-cmbg5-6-cust177.cmbg.cable.ntl.com ([81.104.203.177]:58616
	"EHLO cray") by vger.kernel.org with ESMTP id S269621AbTHDTsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 15:48:53 -0400
Date: Mon, 4 Aug 2003 20:50:58 +0100
From: Charlie Baylis <cb-lkml@fish.zetnet.co.uk>
To: linux-kernel@vger.kernel.org
Cc: kernel@kolivas.org
Subject: Re: [PATCH] O12.2int for interactivity
Message-ID: <20030804195058.GA8267@cray.fish.zetnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I tried them aggressively; irman2 and thud don't hurt here. The idle
> detection limits both of them from gaining too much sleep_avg while waiting
> around and they dont get better dynamic priority than 17. 

Sounds like you've taken the teeth out of the thud program :) The original aim
was to demonstrate what happens when a maximally interactive task suddenly
becomes a CPU hog - similar to a web browser starting to render and causing
intense X activity in the process. Stopping thud getting maximum priority is
addressing the symptom, not the cause. (That's not to say the idle detection
is a bad idea - but it's not the complete answer)

What happens if you change the line
  struct timespec st={10,50000000}; 
to
  struct timespec st={0,250000000}; 

and the line
    nanosleep(&st, 0); 
to
    for (n=0; n<40; n++) nanosleep(&st, 0); 

the idea is to do a little bit of work so that the idle detection doesn't kick
in and thud can reach the max interactive bonus. (I haven't tried your patch
yet to see if this change achieves this)

Charlie

