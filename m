Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbTHZIhO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 04:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263284AbTHZIhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 04:37:14 -0400
Received: from postman4.arcor-online.net ([151.189.0.189]:8098 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S263486AbTHZIex
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 04:34:53 -0400
Date: Tue, 26 Aug 2003 10:32:00 +0200
From: Juergen Quade <quade@hsnr.de>
To: Werner Almesberger <wa@almesberger.net>
Cc: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>,
       linux-kernel@vger.kernel.org
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
Message-ID: <20030826083200.GB13812@hsnr.de>
References: <20030826024808.B3448@almesberger.net> <Pine.LNX.4.44.0308260010480.31955-100000@localhost.localdomain> <20030826043802.D1212@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20030826043802.D1212@almesberger.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 04:38:02AM -0300, Werner Almesberger wrote:
> Nagendra Singh Tomar wrote:
> > I fail to understand this. How can we say that its not a bug. If we 
> > support recursive tasklets, we should support killing them also. If we can 
> > do it why not do it. Is there any reason for that.
> 
> It's just a question of how you define "to kill" :-) But the
> naming is ambiguous, because people may indeed expect
> tasklet_kill to work like kill(2).
> ...
> Example: if a tasklet allocates some resources, and frees
> them when running the next time, you'd need a flag that
> tells the caller(s) of tasklet_kill whether there are
> still such resources that need freeing.

Is it really used in this way somewhere?

I always thought, a tasklet is a self-contained
(lets say stateless) function.

For more we have kernel-threads.

> The current mechanism makes sure that the tasklet will
> execute one last time, if scheduled before tasklet_kill.

If your tasklet has states, you can't know, in which
state it is, when you call "tasklet_kill".
Can this work reliable?

        Juergen.
