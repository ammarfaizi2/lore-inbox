Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbTHYXBH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 19:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTHYXBD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 19:01:03 -0400
Received: from smtp.mailix.net ([216.148.213.132]:3432 "EHLO smtp.mailix.net")
	by vger.kernel.org with ESMTP id S262421AbTHYXAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 19:00:48 -0400
Date: Tue, 26 Aug 2003 01:00:44 +0200
From: Alex Riesen <fork0@users.sf.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, William Lee Irwin III <wli@holomorphy.com>
Subject: Re: [PATCH]O18.1int
Message-ID: <20030825230044.GA27016@steel.home>
Reply-To: Alex Riesen <fork0@users.sf.net>
References: <200308231555.24530.kernel@kolivas.org> <20030825102133.GA14402@Synopsys.COM> <20030825210254.GA12781@steel.home> <200308260848.23538.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308260848.23538.kernel@kolivas.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas, Tue, Aug 26, 2003 00:48:23 +0200:
> > Afaics, the application (rxvt) just sleeps at the beginning waiting for
> > input from X. As every terminal would do. At some point its inferior
> > process finishes, but it fails to notice this spinning madly in the
> > internal loop calling select, which returns immediately (because other
> > side of pty was closed. That is the error in rxvt). Probably it has
> > accumulated enough "priority" up to this moment to block other
> > applications (window manager, for example) when it suddenly starts running?
> 
> Something like that. Interesting you point out select as wli was 
> profiling/tracing the mozilla/acroread plugin combination that spins on wait 
> and also found select was causing grief. It was calling select with a 15ms 
> timeout and X was getting less than 5ms to do it's work and respond and it 
> was repeatedly timing out. Seems a common link there.
> 

Yes, looks similar. Probably a simplier test could be to let the
program loop using select on stdin with zero timeout (it is a pty
usually :)

