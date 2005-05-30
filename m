Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVE3P0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVE3P0O (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 11:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVE3P0O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 11:26:14 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:62348 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261534AbVE3P0A
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 11:26:00 -0400
Subject: Re: [PROBLEM] Machine Freezes while Running Crossover Office
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pekka Enberg <penberg@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
References: <1117291619.9665.6.camel@localhost>
	 <Pine.LNX.4.58.0505291059540.10545@ppc970.osdl.org>
	 <84144f0205052911202863ecd5@mail.gmail.com>
	 <Pine.LNX.4.58.0505291143350.10545@ppc970.osdl.org>
	 <1117399764.9619.12.camel@localhost>
	 <Pine.LNX.4.58.0505291543070.10545@ppc970.osdl.org>
Date: Mon, 30 May 2005 18:23:30 +0300
Message-Id: <1117466611.9323.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2005-05-29 at 15:59 -0700, Linus Torvalds wrote:
> However, I don't understand how wine can block the X server from doing 
> even cursor updates. It might be a scheduler bug, of course. The one thing 
> a bigger pipe buffer does is end up changing scheduling behaviour. 
> 
> (On the other hand, I would not be surprised if Wine does something that 
> makes X pause, like use DGA or whatever and tells X not to update the 
> screen, including cursors).

It is not just X. Running the following shell script when hitting the
bug:

#!/bin/sh

while : ; do
  date
  sleep 1
done

shows the following output:

penberg ~/pipe-test 49 ./show-date
Mon May 30 18:16:52 EEST 2005
Mon May 30 18:16:53 EEST 2005
Mon May 30 18:16:54 EEST 2005
Mon May 30 18:16:55 EEST 2005
Mon May 30 18:17:15 EEST 2005
Mon May 30 18:17:16 EEST 2005

It looks like no other processes other than wineserver and
wine-preloader get any CPU time (also evident from Sysrq-P traces).

On Sun, 2005-05-29 at 15:59 -0700, Linus Torvalds wrote:
> Are you sure your oprofile PC map is correct?

Yes, the pipe_poll calls come from wineserver actually, not
wine-preloader (of which I showed strace output before).

Any suggestions on how to debug this further? I am not sure I understood
your point about watching poll timeouts.

			Pekka

