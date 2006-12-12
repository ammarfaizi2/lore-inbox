Return-Path: <linux-kernel-owner+w=401wt.eu-S1750764AbWLLAFn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWLLAFn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 19:05:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWLLAFn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 19:05:43 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:60193
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750764AbWLLAFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 19:05:43 -0500
Date: Mon, 11 Dec 2006 16:05:41 -0800 (PST)
Message-Id: <20061211.160541.111202759.davem@davemloft.net>
To: paulus@samba.org
Cc: torvalds@osdl.org, olaf@aepfle.de, herbert@13thfloor.at, apw@shadowen.org,
       ak@suse.de, akpm@osdl.org, linux-kernel@vger.kernel.org,
       drfickle@us.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: 2.6.19-git13: uts banner changes break SLES9 (at least)
From: David Miller <davem@davemloft.net>
In-Reply-To: <17789.54777.283849.950002@cargo.ozlabs.ibm.com>
References: <20061211185536.GA19338@aepfle.de>
	<Pine.LNX.4.64.0612111106310.12500@woody.osdl.org>
	<17789.54777.283849.950002@cargo.ozlabs.ibm.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Mackerras <paulus@samba.org>
Date: Tue, 12 Dec 2006 09:04:41 +1100

> If there is a reliable way to get the version string, great, I'll use
> that.

FWIW, on sparc and sparc64 we have this information block for
the boot loader.

The first two instructions at the entry point simply branch
over the boot loader information block header.

The information block starts with a known magic string "HdrS" which
does not match any valid Sparc instruction.  Any tool can search for
it starting at the symbol "_start" in the kernel image.

Inside this information block we stick a 32-bit word which contains
LINUX_VERSION_CODE.

That only gives you the version, not the whole version string, but you
could put the whole string in such a location when adding such a
facility to powerpc if you wanted to.

