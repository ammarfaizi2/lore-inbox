Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUJSIdY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUJSIdY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 04:33:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268070AbUJSIdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 04:33:24 -0400
Received: from gate.crashing.org ([63.228.1.57]:21906 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S268058AbUJSIdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 04:33:22 -0400
Subject: Re: [PATCH] generic irq subsystem: ppc64 port
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: mingo@elte.hu
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>,
       Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <200410190714.i9J7Elnx027734@hera.kernel.org>
References: <200410190714.i9J7Elnx027734@hera.kernel.org>
Content-Type: text/plain
Message-Id: <1098174500.11449.65.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 19 Oct 2004 18:28:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

That patch will unfortunately break a load of ppc64 boxes.

If you look closely at the ppc64 code, you'll notice we don't
use the irq_desc array directly but go through a get_irq_desc()
accessor. This is because our interrupt numbers can be very
large and scattered, and thus we have a remapping tree.

I still like the idea of the patch, so it would be useful if
you added the possibility for us to just change that behaviour,
that is replace all occursences of irq_descs + i with get_irq_desc()
and provide a generic one that just does that, with a #ifndef so
that the architecture can provide it's own. 

If you agree with the principle, though, I suppose I can do it
and send a proposed patch tomorrow.

Ben.



