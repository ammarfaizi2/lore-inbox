Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263881AbUEHCQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263881AbUEHCQB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 22:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbUEHCQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 22:16:01 -0400
Received: from fw.osdl.org ([65.172.181.6]:53390 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263881AbUEHCP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 22:15:59 -0400
Date: Fri, 7 May 2004 19:15:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Bird <tim.bird@am.sony.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: get_cmos_time() takes up to a second on boot
In-Reply-To: <409C2CBA.8040709@am.sony.com>
Message-ID: <Pine.LNX.4.58.0405071908060.3271@ppc970.osdl.org>
References: <409C2CBA.8040709@am.sony.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 May 2004, Tim Bird wrote:
> 
> What is the downside of disabling this
> synchronization with the clock edge?

It might not matter any more, but if I remember correctly, the real 
problem was that we used to always write back the time to the CMOS clock 
too, and then booting a few times and consistently getting the time wrong 
the same way made the clock drift quite noticeably.

These days, I think we do the write-back only if we use an external clock 
(NTP), so we probably _could_ just remove the synchronization at 
read-time (removing it at write-time doesn't sound like a good idea).

Does anybody remember better?

> 1 second of variability is unnacceptable
> when you're requirement is to boot in
> .5 seconds.  :)

Heh. And yes, it could be handled other ways (you could check the cmos
time in the timer interrupt during boot, and correct it there rather than
busy-waiting).

> Would it be bad to disable this synchronization
> completely?  How about just during boot?

I don't think we should necessarily disable the synchronization, but we
could certainly make it optional for cases that don't care about it. We
might even make the default be "don't care about the read
synchronization".

		Linus
