Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262778AbUKRRCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbUKRRCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 12:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262780AbUKRRCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 12:02:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51883 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262778AbUKRRCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 12:02:01 -0500
Date: Thu, 18 Nov 2004 12:01:34 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Chris Wright <chrisw@osdl.org>
cc: Ross Kendall Axe <ross.axe@blueyonder.co.uk>, <netdev@oss.sgi.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>,
       lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] linux 2.9.10-rc1: Fix oops in unix_dgram_sendmsg when
 using SELinux and SOCK_SEQPACKET
In-Reply-To: <20041118084449.Z14339@build.pdx.osdl.net>
Message-ID: <Xine.LNX.4.44.0411181158110.5096-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, Chris Wright wrote:

> Why not make a unix_seq_sendmsg, which is a very small wrapper?

Good idea, patch forthcoming.

> Does the above stop the other issue?  My laptop died, so I'm not able to
> test ATM.

No, it seems to be caused when addrlen in sendto() is non-zero, causing 
unix_find_other() to be called instead of unix_peer_get(), which is 
screwing up reference counts.

As for MSG_EOR, apart from the generic socket code, nothing is being done.  
This would be a separate issue.


- James
-- 
James Morris
<jmorris@redhat.com>


