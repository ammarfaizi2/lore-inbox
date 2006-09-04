Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964998AbWIDVmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998AbWIDVmp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 17:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964999AbWIDVmo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 17:42:44 -0400
Received: from mx.delair.de ([62.80.31.6]:27101 "EHLO mx.delair.de")
	by vger.kernel.org with ESMTP id S964998AbWIDVmn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 17:42:43 -0400
From: Andreas Hobein <ah2@delair.de>
Organization: delair Air Traffic Systems GmbH
To: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: Trouble with ptrace self-attach rule since kernel > 2.6.14
Date: Mon, 4 Sep 2006 23:42:40 +0200
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Markus Gutschke <markus@google.com>
References: <200608312305.47515.ah2@delair.de> <20060904152307.GA98@oleg> <200609041756.18343.ah2@delair.de>
In-Reply-To: <200609041756.18343.ah2@delair.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609042342.41184.ah2@delair.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Monday 04 September 2006 17:23, you wrote:
> > Could you test your application with 2.6.18-rc6 and this change
> >
> > 	-       if (task == current)
> > 	+       if (task->tgid == current->tgid)
> >
> > reverted? I think any report, positive or negative, would be useful.

Reverting this change in kernel 2.6.18-rc6 was successful, that means my 
application has the old behaviour as before 2.6.15. I don't know why patching 
the fedora kernel didn't lead to the same result.

I've tested tracing child threads from the parent thread as well as tracing 
siblings and parent threads from a child. All tests where successful when 
reverting the above mentioned changes.

I cannot judge wether reverting back to "if (task == current)" would cause 
trouble in other cases. On the other hand, I'm quite happy with my 
fork()/pipe() solution that works fine in my application so there is no need 
to go back from my point of view.

I started this discussion mainly to get more background information, why 
ptracing sibling threads is forbidden since kernel 2.6.15. I hope I 
understood correctly that this change was a trade-off between removing the 
self attach feature and elliminating many serious bugs. Thus I would 
understand if the change won't be reverted in future kernel versions.

Andreas
