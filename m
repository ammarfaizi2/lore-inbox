Return-Path: <linux-kernel-owner+w=401wt.eu-S1161014AbXALHRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161014AbXALHRJ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 02:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161015AbXALHRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 02:17:09 -0500
Received: from amsfep16-int.chello.nl ([62.179.120.11]:45379 "EHLO
	amsfep16-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161014AbXALHRI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 02:17:08 -0500
Subject: Re: [PATCH/RFC 2.6.20-rc4 1/1] fbdev,mm: hecuba/E-Ink fbdev driver
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
References: <20070111142427.GA1668@localhost>
	 <20070111133759.d17730a4.akpm@osdl.org>
	 <45a44e480701111622i32fffddcn3b4270d539620743@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 08:15:45 +0100
Message-Id: <1168586145.26496.35.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2007-01-11 at 19:22 -0500, Jaya Kumar wrote:

> Agreed. Though I may be misunderstanding what you mean by first-touch.
> Currently, I do a schedule_delayed_work and leave 1s between when the
> page_mkwrite callback indicating the first touch is received and when
> the deferred IO is processed to actually deliver the data to the
> display. I picked 1s because it rounds up the display latency. I
> imagine increasing the delay further may make it miss some desirable
> display activity. For example, a slider indicating progress of music
> may be slower than optimal. Perhaps I should make the delay a module
> parameter and leave the choice to the user?

How about implementing the sync_page() aop? Then you could force the
flush using msync(MS_SYNC). 

Hmm... that might require more surgery but the idea would work I think.

