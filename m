Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbTHZR5C (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 13:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262965AbTHZR5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 13:57:01 -0400
Received: from almesberger.net ([63.105.73.239]:55050 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262920AbTHZR46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 13:56:58 -0400
Date: Tue, 26 Aug 2003 14:56:36 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Juergen Quade <quade@hsnr.de>, kuznet@ms2.inr.ac.ru
Cc: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>,
       linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030826145636.E1212@almesberger.net>
References: <20030826024808.B3448@almesberger.net> <Pine.LNX.4.44.0308260010480.31955-100000@localhost.localdomain> <20030826043802.D1212@almesberger.net> <20030826083200.GB13812@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826083200.GB13812@hsnr.de>; from quade@hsnr.de on Tue, Aug 26, 2003 at 10:32:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Juergen Quade wrote:
> Can this work reliable?

Hmm, actually, no. On UP, yes. But on SMP, you might tasklet_kill
while the tasklet is running, but before it has had a chance to
tasklet_schedule itself. tasklet_schedule will have no effect in
this case.

Alexey, if my observation is correct, the property

| * If tasklet_schedule() is called, then tasklet is guaranteed
|   to be executed on some cpu at least once after this.

does not hold if using tasklet_kill on SMP.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
