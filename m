Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbTELMzC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbTELMzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:55:02 -0400
Received: from dp.samba.org ([66.70.73.150]:19611 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262016AbTELMzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:55:01 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16063.40072.101121.244892@argo.ozlabs.ibm.com>
Date: Mon, 12 May 2003 23:07:20 +1000
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPPE in kernel?
In-Reply-To: <20030512060210.C29881@google.com>
References: <20030512045929.C29781@google.com>
	<16063.38221.73659.403481@argo.ozlabs.ibm.com>
	<20030512060210.C29881@google.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Cusack writes:

> I have the compressor return a 3-valued return code (<0, 0, >0) instead of
> two-valued (>0, other).  A negative value tells ppp_generic to drop the
> packet.  0 means the same as it does now--the compressor failed for some
> reason.  (All current compressors always return 0 or >0, so the negative
> return is compatible.)
> 
> 0 could also mean that CCP isn't up yet, but pppd userland doesn't allow
> NCP's to come up until CCP completes (iff trying to negotiate MPPE).

Hmmm, and are you sure that nothing can cause CCP to go down?  If it
does then ppp_generic will send data uncompressed.  What would happen
if an attacker managed to insert a CCP terminate-request into the
receive stream somehow?

I think the whole thing needs a careful audit.  The idea that you fall
back to sending and receiving uncompressed data if CCP goes down or a
compressor fails is pretty fundamental to the CCP implementation in
ppp_generic.

Paul.

