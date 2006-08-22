Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750852AbWHVGLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWHVGLv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 02:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWHVGLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 02:11:51 -0400
Received: from xenotime.net ([66.160.160.81]:42715 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750794AbWHVGLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 02:11:50 -0400
Date: Mon, 21 Aug 2006 23:14:55 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: romieu@fr.zoreil.com, penberg@cs.Helsinki.FI, akpm@osdl.org,
       dvrabel@cantab.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, david@pleyades.net
Subject: Re: [PATCH] IP1000A: IC Plus update 2006-08-22
Message-Id: <20060821231455.1ce9474d.rdunlap@xenotime.net>
In-Reply-To: <1156268234.3622.1.camel@localhost.localdomain>
References: <1156268234.3622.1.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Aug 2006 13:37:14 -0400 Jesse Huang wrote:

> Dear All:
> I had regenerate this patch from:
> git://git.kernel.org/pub/scm/linux/kernel/git/penberg/netdev-ipg-2.6.git
> 
> And, submit those modifications as one patch.
> 
> Add: "Remove and add some whitespace"
> 
> From: Jesse Huang <jesse@icplus.com.tw>
> 
> Change Logs:
>    - update maintainer information
>    - remove some default phy params
>    - remove threshold config from ipg_io_config
>    - ip1000 ipg_config_autoneg rewrite
>    - modify coding style of ipg_config_autoneg
>    - Add IPG_AC_FIFO flag when Tx reset
>    - For compatible at PCI 66MHz issue
>    - Remove and add some whitespace
> 
> Signed-off-by: Jesse Huang <jesse@icplus.com.tw>


-	u8 phyctrl;
+	long mac_ctrl_value;

Should mac_ctrl_value be unsigned long or u32 instead of signed long?

We try to keep source lines limited to < 80 columns when feasible
so that they fit nicely into an xterm.  There are a few lines here
that are > 80 columns.

+		if((NextToFree != sp->CurrentTFD) && (NextToFree != CurrentTxTFDPtr))
+		{

Style:  need space after if; opening brace not on line by itself.

+		// Re-configure after DMA reset. 

Line ends with a space. :(

+	if (sp->ResetCurrentTFD != 0)
+	{

Opening brace not on line by itself -- put it on the previous line,
with a space between ) and {.

+		if (sp->LastTFDHoldAddr == sp->CurrentTFD) sp->LastTFDHoldCnt++;
+		else {sp->LastTFDHoldAddr = sp->CurrentTFD; sp->LastTFDHoldCnt=0; }

Split lines as:
		if (condition)
			action;
		else {
			action2;
		}


---
~Randy
