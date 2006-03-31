Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWCaH3S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWCaH3S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 02:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWCaH3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 02:29:18 -0500
Received: from smop.co.uk ([81.5.177.201]:29608 "EHLO hades.smop.co.uk")
	by vger.kernel.org with ESMTP id S1751086AbWCaH3S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 02:29:18 -0500
Date: Fri, 31 Mar 2006 08:28:59 +0100
To: Andi Kleen <ak@muc.de>
Cc: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-mm1 leaks in dvb playback (found)
Message-ID: <20060331072859.GA5389@smop.co.uk>
Reply-To: adrian@smop.co.uk
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	"David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060330004518.GA23404@smop.co.uk> <20060330225830.GA24009@smop.co.uk> <20060330231131.GA25029@smop.co.uk> <20060330.152821.24959319.davem@davemloft.net> <20060331012235.GB45568@muc.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060331012235.GB45568@muc.de>
User-Agent: Mutt/1.5.11+cvs20060126
From: Adrian Bridgett <adrian@smop.co.uk>
X-smop.co.uk-MailScanner: Found to be clean
X-smop.co.uk-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.665,
	required 5, autolearn=not spam, AWL -0.07, BAYES_00 -2.60,
	NO_RELAYS -0.00)
X-smop.co.uk-MailScanner-From: adrian@smop.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2006 at 03:22:35 +0200 (+0200), Andi Kleen wrote:
> On Thu, Mar 30, 2006 at 03:28:21PM -0800, David S. Miller wrote:
> > From: Adrian Bridgett <adrian@smop.co.uk>
> > Date: Fri, 31 Mar 2006 00:11:31 +0100
> > 
> > > Hmm - it looks like it was meant to be reverted in 2.6.16-rc1-mm4,5 FWIW.
> > 
> > So is the current version in Linus's tree causing this problem?

I'm taking 2.6.16(.0) adding -mm1.  When running dvbstream I get
dentry_cache and sock_inode_cache leaking about 4MB/s.

I then revert this ENFILE/EMFILE patch and both leaks stop.

I've just compiled up 2.6.16-git18 and that leaks in an identical
manner.   I'm suprised no-one else has seen it, so I've been putting
it down to the specific hardware (dvb-usb-vp7045), but then I saw that
it was a bad memory leak and then that 2.6.16 was fine and finally
started trying to isolate the patch that broke it for me (tm).

Maybe it's just exposed a bug in dvb-usb-vp7045, but given that it
appears to add a sock_alloc_fd without any matching deallocate code
AFAICT...

Adrian
