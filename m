Return-Path: <linux-kernel-owner+w=401wt.eu-S1161134AbXAHXCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161134AbXAHXCj (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161098AbXAHXCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:02:38 -0500
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:33113 "EHLO
	pne-smtpout1-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161083AbXAHXCh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:02:37 -0500
To: Patrick McHardy <kaber@trash.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Linux 2.6.20-rc4
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<m37ivyr1v6.fsf@telia.com>
	<Pine.LNX.4.64.0701071442580.3661@woody.osdl.org>
	<45A2C6AE.5080400@trash.net>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Jan 2007 00:02:30 +0100
In-Reply-To: <45A2C6AE.5080400@trash.net>
Message-ID: <m3ps9pp1fd.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick McHardy <kaber@trash.net> writes:

> Linus Torvalds wrote:
> > On Sun, 7 Jan 2007, Peter Osterlund wrote:
> > 
> >>I get kernel panics when doing large ethernet transfers. A loop doing

> >>  EFALLGS: 00010206 (2.6.20-rc4 #13)
> >>  EIP is at ipv4_conntrack_help+0x6b/0x83
> >>  eax: c0475e44 ebx: 9f5cea37 ecx: d1dcebb0 edx: 00000014
> >>  esi: d1dcebb0 edi: c0475e44 ebp: c0475dd8 esp: c0475dc4
> > 
> > which is ipv4_conntrack_help():
> > 
> > 	return help->helper->help(pskb,
> > 		(*pskb)->nh.raw - (*pskb)->data
> > 				+ (*pskb)->nh.iph->ihl*4,
> > 		ct, ctinfo);
> > 
> > and that call instruction is the one that oopses because "help->helper" is 
> > corrupt (it's 0x9f5cea37 - not a valid kernel pointer).
> 
> I guess its because of an uninitialized helper field in struct
> nf_conntrack_expect, which is then copied from the expectation to
> the conntrack entry.
> 
> Peter, do you have locally generated netbios ns queries on the machine
> running nf_conntrack?

I have samba running on both machines. I guess that generates some
netbios traffic even though it isn't currently in active use.

> If so, please try this patch.

Thanks, the patch appears to help. The kernel has now survived much
longer with this patch than it used to do without it.

I will recompile with gcc 4.1.1 too just to make sure, but if you
don't hear anything more from me, consider the case closed. :)

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
