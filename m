Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262785AbUKRRK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262785AbUKRRK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:10:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUKRRIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:08:15 -0500
Received: from fw.osdl.org ([65.172.181.6]:56542 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262781AbUKRRHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:07:08 -0500
Date: Thu, 18 Nov 2004 09:07:06 -0800
From: Chris Wright <chrisw@osdl.org>
To: James Morris <jmorris@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>,
       Ross Kendall Axe <ross.axe@blueyonder.co.uk>, netdev@oss.sgi.com,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when using SELinux and SOCK_SEQPACKET
Message-ID: <20041118090706.O2357@build.pdx.osdl.net>
References: <20041118084449.Z14339@build.pdx.osdl.net> <Xine.LNX.4.44.0411181158110.5096-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Xine.LNX.4.44.0411181158110.5096-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Thu, Nov 18, 2004 at 12:01:34PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@redhat.com) wrote:
> On Thu, 18 Nov 2004, Chris Wright wrote:
> 
> > Why not make a unix_seq_sendmsg, which is a very small wrapper?
> 
> Good idea, patch forthcoming.
> 
> > Does the above stop the other issue?  My laptop died, so I'm not able to
> > test ATM.
> 
> No, it seems to be caused when addrlen in sendto() is non-zero, causing 
> unix_find_other() to be called instead of unix_peer_get(), which is 
> screwing up reference counts.

Right, but the snippet I posted guards against that I think.  It forces
unix_peer_get() in dgram_sendmsg.

> As for MSG_EOR, apart from the generic socket code, nothing is being done.  
> This would be a separate issue.

Yup, just noting the bits that looked broken to me.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
