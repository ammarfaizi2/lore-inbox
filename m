Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965076AbVIAHnF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965076AbVIAHnF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 03:43:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965077AbVIAHnF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 03:43:05 -0400
Received: from smtp05.web.de ([217.72.192.209]:61658 "EHLO smtp05.web.de")
	by vger.kernel.org with ESMTP id S965076AbVIAHnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 03:43:04 -0400
From: Thomas Schlichter <thomas.schlichter@web.de>
To: vatsa@in.ibm.com
Subject: Re: [PATCH 1/3] Updated dynamic tick patches - Fix lost tick
Date: Thu, 1 Sep 2005 09:42:23 +0200
User-Agent: KMail/1.6.2
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
References: <200509010829.35958.thomas.schlichter@web.de> <20050901072303.GB9760@in.ibm.com>
In-Reply-To: <20050901072303.GB9760@in.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509010942.24026.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 1. September 2005 09:23 schrieb Srivatsa Vaddagiri:
> On Thu, Sep 01, 2005 at 08:29:32AM +0200, Thomas Schlichter wrote:
> > I tested the attached patch during the last night and it sems to work...
>
> A quick feedback on your patch:
>
> A litmus test that I use is if "zero" lost ticks are being hit,
> which we should not w/o a patch like dynamic tick.
> 
> I still see zero lost ticks being reported with your patch (during
> bootup atleast) which means all is still not well?

I think this can happen due to this:
  http://bugzilla.kernel.org/show_bug.cgi?id=5127

Think about two adjacent regular timer interrupts. Now consider the first one 
is handled very late (indeed even after the second interrupt already 
occoured). Then will see two "lost" ticks.

Now directly the second timer interrupt handler is executed and, well it sees 
there has _nearly_ no time passed, so no "lost" ticks are reported.

I think this could explain it, right?!

Best regards
  Thomas Schlichter
