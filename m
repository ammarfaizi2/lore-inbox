Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTEME0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 00:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262850AbTEME0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 00:26:17 -0400
Received: from dp.samba.org ([66.70.73.150]:48348 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262827AbTEME0Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 00:26:16 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16064.30407.556492.770195@argo.ozlabs.ibm.com>
Date: Tue, 13 May 2003 14:38:31 +1000
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPPE in kernel?
In-Reply-To: <20030512151312.C30310@google.com>
References: <20030512045929.C29781@google.com>
	<16063.38221.73659.403481@argo.ozlabs.ibm.com>
	<20030512060210.C29881@google.com>
	<16063.40072.101121.244892@argo.ozlabs.ibm.com>
	<20030512151312.C30310@google.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Cusack writes:

> When (if) CCP goes down, pppd shuts down LCP if MPPE was running.

Not good enough - you have a window when the kernel will be
transmitting unencrypted datagrams while pppd responds.

Look at the places in ppp_generic.c where the driver clears
SC_COMP_RUN or SC_DECOMP_RUN - for example when it receives a CCP
terminate-request or configure-request.  You need to do something to
make sure that the kernel never transmits data packets when
SC_COMP_RUN is clear if you are doing MPPE.  Similarly, if you are
doing MPPE you probably need to discard received unencrypted data
packets.

Paul.
