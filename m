Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964873AbWGSXk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964873AbWGSXk6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 19:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964874AbWGSXk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 19:40:58 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59553 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964873AbWGSXk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 19:40:57 -0400
From: Neil Brown <neilb@suse.de>
To: Janos Farkas <chexum+dev@gmail.com>
Date: Wed, 19 Jul 2006 09:29:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17597.28376.805867.197599@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net
Subject: Re: nfs problems with 2.6.18-rc1
In-Reply-To: message from Janos Farkas on Tuesday July 18
References: <priv$8d118c145575$b19af6759a@200607.shadow.banki.hu>
	<17594.51834.20365.820166@cse.unsw.edu.au>
	<priv$efbe06145615$0a94d550eb@200607.gmail.com>
	<priv$8d118c145627$464a3143cd@200607.shadow.banki.hu>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 18, chexum+dev@gmail.com wrote:
> > On 2006-07-17 at 09:23:38, Neil Brown wrote:
> > > The standard answer for tracing nfs problems if 'tcpdump'.
> > > e.g. 
> > >   tcpdump -s 0 -w /tmp/trace host $CLIENT and host $SERVER and port 2049
> > > 
> > > that should show whether the error is coming from the server, or if
> > > the client is generating it all by itself.
> 
> Closing in, I have a dump between these two machines running 18-rc2 that
> has the error on the wire, but I'm not sure how much more would be
> relevant:

Hmmm...
Interesting, but confusing.
The filehandle of the directory seems to keep changing.  Maybe tcpdump
is showing too many bytes.  Access to the raw dump would help.

> 13:37:51.254708 access fh Unknown/0100000100FD000002000000755104000AA487A20000001F0AA487A200030001 001f
> 13:37:51.255375 reply ok 32 access ERROR: Permission denied attr:

'access' should never return 'Permission denied' so there is
definitely something wrong here.  I was expected nfserr_acces rather
than nfserr_perm...
The server logs at the same time would help a lot.

NeilBrown
