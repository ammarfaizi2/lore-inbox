Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUIJQbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUIJQbp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267599AbUIJQad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:30:33 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26531 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267582AbUIJQ2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:28:01 -0400
Date: Fri, 10 Sep 2004 17:27:56 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.9-rc1 - 2004-09-09.21.30) - 2 New warnings (gcc 3.2.2)
Message-ID: <20040910162756.GO23987@parcelfarce.linux.theplanet.co.uk>
References: <200409101418.i8AEIjjJ020039@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409101418.i8AEIjjJ020039@cherrypit.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 07:18:45AM -0700, John Cherry wrote:
> drivers/net/tulip/dmfe.c:1808: warning: passing arg 1 of `__le16_to_cpup' from incompatible pointer type
> drivers/net/tulip/dmfe.c:1820: warning: passing arg 1 of `__le32_to_cpup' from incompatible pointer type

Real alignment bugs, BTW.  The first one happens to be OK, but line 1820 is
guaranteed to be misaligned (32bit reads on addresses that differ by 2, so
at least one is guaranteed to fsck up).  The value we are calculating there
looks bogus, while we are at it...
