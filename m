Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261575AbVB1MLy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbVB1MLy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 07:11:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVB1MLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 07:11:54 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:64703 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S261577AbVB1MLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 07:11:02 -0500
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Andrew Morton <akpm@osdl.org>
Cc: Guillaume Thouvenin <guillaume.thouvenin@bull.net>, kaigai@ak.jp.nec.com,
       marcelo.tosatti@cyclades.com, "David S. Miller" <davem@redhat.com>,
       jlan@sgi.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       elsa-devel@lists.sourceforge.net
In-Reply-To: <20050227233943.6cb89226.akpm@osdl.org>
References: <42168D9E.1010900@sgi.com>
	 <20050218171610.757ba9c9.akpm@osdl.org> <421993A2.4020308@ak.jp.nec.com>
	 <421B955A.9060000@sgi.com> <421C2B99.2040600@ak.jp.nec.com>
	 <421CEC38.7010008@sgi.com> <421EB299.4010906@ak.jp.nec.com>
	 <20050224212839.7953167c.akpm@osdl.org> <20050227094949.GA22439@logos.cnet>
	 <4221E548.4000008@ak.jp.nec.com> <20050227140355.GA23055@logos.cnet>
	 <42227AEA.6050002@ak.jp.nec.com>
	 <1109575236.8549.14.camel@frecb000711.frec.bull.fr>
	 <20050227233943.6cb89226.akpm@osdl.org>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1109592658.2188.924.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 28 Feb 2005 07:10:58 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Havent seen the beginnings of this thread. But whatever you are trying
to do seems to suggest some complexity that you are trying to
workaround. What was wrong with just going ahead and just always
invoking your netlink_send()? If there are nobody in user space (or
kernel) listening, it wont go anywhere.

cheers,
jamal

On Mon, 2005-02-28 at 02:39, Andrew Morton wrote:
> Guillaume Thouvenin <guillaume.thouvenin@bull.net> wrote:
> >
> >    Ok the protocol is maybe too "basic" but with this mechanism the user
> >  space application that uses the fork connector can start and stop the
> >  send of messages. This implementation needs somme improvements because
> >  currently, if two application are using the fork connector one can
> >  enable it and the other don't know if it is enable or not, but the idea
> >  is here I think.
> 
> Yes.  But this problem can be solved in userspace, with a little library
> function and a bit of locking.
> 
> IOW: use the library to enable/disable the fork connector rather than
> directly doing syscalls.
> 
> It has the problem that if a client of that library crashes, the counter
> gets out of whack, but really, it's not all _that_ important, and to handle
> this properly in-kernel each client would need an open fd against some
> object so we can do the close-on-exit thing properly.  You'd need to create
> a separate netlink socket for the purpose.
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Lse-tech mailing list
> Lse-tech@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/lse-tech
> 

