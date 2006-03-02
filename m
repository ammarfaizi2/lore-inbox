Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWCBFQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWCBFQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 00:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbWCBFQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 00:16:44 -0500
Received: from ozlabs.org ([203.10.76.45]:6113 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750861AbWCBFQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 00:16:44 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17414.32686.589133.160989@cargo.ozlabs.ibm.com>
Date: Thu, 2 Mar 2006 16:16:30 +1100
From: Paul Mackerras <paulus@samba.org>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] Fix powerpc bad_page_fault output  (Re: 2.6.16-rc5-mm1)
In-Reply-To: <440646ED.2030108@mbligh.org>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<4404E328.7070807@mbligh.org>
	<20060301164531.GA17755@pb15.lixom.net>
	<17414.15814.146349.883153@cargo.ozlabs.ibm.com>
	<440646ED.2030108@mbligh.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Bligh writes:

> He's removing KERN_ALERT ... I guess it could get switched from 
> KERN_ALERT to KERN_ERR, but ...
> 
> Either way, KERN_ALERT seems way too low to me. I object to getting
> half the oops, and not the other half ;-)

KERN_ALERT is two steps higher in priority (lower number) than
KERN_ERR.  Why on earth would we see KERN_ERR messages but not
KERN_ALERT messages?

In fact die() should probably be using KERN_EMERG.

Messages without a loglevel are by default logged at KERN_WARNING
level, one step lower in priority than KERN_ERR.

This all sounds to me like there is something wacky going on
somewhere, and we need to get to the bottom of it rather than just
remove printk tags.

Paul.


