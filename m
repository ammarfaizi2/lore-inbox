Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVDFNAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVDFNAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 09:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVDFNAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 09:00:09 -0400
Received: from orb.pobox.com ([207.8.226.5]:40382 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262194AbVDFNAC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 09:00:02 -0400
Date: Wed, 6 Apr 2005 05:59:58 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Barry K. Nathan" <barryn@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc2-mm1
Message-ID: <20050406125958.GA8150@ip68-4-98-123.oc.oc.cox.net>
References: <20050405000524.592fc125.akpm@osdl.org> <20050405134408.GB10733@ip68-4-98-123.oc.oc.cox.net> <20050405141445.GA5170@ip68-4-98-123.oc.oc.cox.net> <20050405175600.644e2453.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405175600.644e2453.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 05:56:00PM -0700, Andrew Morton wrote:
> > I'll see if I can isolate it any further.
> 
> Please, that would help.

[Right now I'm in a race against my lack of sleep. I'm trying to send
this e-mail before I involuntarily fall asleep, so the contents
and/or recipient list may be incomplete...]

Ok, I've narrowed the problem down to one patch. In 2.6.11-mm3, the
problem goes away if I remove this patch:
swsusp-enable-resume-from-initrd.patch

(Recap of the problem in case this gets forwarded: Resume is almost
instant without the apparently-guilty patch. With the patch, resume
takes almost half an hour.)

BTW, there's another strange thing that's introduced by 2.6.11-rc2-mm1:
With that kernel, suspend is also ridiculously slow (speed is comparable
to the slow resume with the aforementioned patch). 2.6.11-rc2 does not
have that problem.

Also, with 2.6.12-rc2-mm1, this computer happens to hit the bug where
all the printk timestamps are 0000000.0000000 (don't take the # of
digits too literally). Probably unrelated, but I may as well mention it.
(System is an Athlon XP 2200+ with SiS chipset. I can't remember which
model of SiS chipset.)

-Barry K. Nathan <barryn@pobox.com>
