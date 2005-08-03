Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVHCLtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVHCLtI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262233AbVHCLrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:47:31 -0400
Received: from gate.crashing.org ([63.228.1.57]:18350 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262229AbVHCLpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:45:05 -0400
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050802095401.GB1442@elf.ucw.cz>
References: <1122908972.18835.153.camel@gaston>
	 <20050801203728.2012f058.Ballarin.Marc@gmx.de>
	 <1122926885.30257.4.camel@gaston>  <20050802095401.GB1442@elf.ucw.cz>
Content-Type: text/plain
Date: Wed, 03 Aug 2005 13:40:54 +0200
Message-Id: <1123069255.30257.27.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'd like to get rid of shutdown callback. Having two copies of code
> (one in callback, one in suspend) is ugly.

Well, it's obviously not a good time for this. First, suspend and
shutdown don't necessarily do the same thing, then it just doesn't work
in practice. So either do it right completely or not at all, but 2.6.13
isn't the place for an half-assed hack that looks like a solution to
you.

I do agree that there are enough similarities between the suspend and
shutdown process that we could use the same callback, but then, please,
at least with a different argument and with drivers beeing fixed to
handle it. Most drivers should probably just "ignore" shutdown anyway.

BTW. I suppose we still have the same constant for PMSG_FREEZE and
PMSG_SUSPEND ? That could have been fixed ages ago and is more important
imho....

Ben.


