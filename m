Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTELMgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 08:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTELMgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 08:36:05 -0400
Received: from dp.samba.org ([66.70.73.150]:48273 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262110AbTELMgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 08:36:04 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16063.38221.73659.403481@argo.ozlabs.ibm.com>
Date: Mon, 12 May 2003 22:36:29 +1000
To: Frank Cusack <fcusack@fcusack.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MPPE in kernel?
In-Reply-To: <20030512045929.C29781@google.com>
References: <20030512045929.C29781@google.com>
X-Mailer: VM 7.15 under Emacs 21.3.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Cusack writes:

> What are the chances of getting MPPE (PPP encryption) into the 2.4.21
> and/or 2.5.x kernels?

First, are there any patent issues that you are aware of?

> I'm not so concerned about getting any of that included though; what
> I really want is for the changes to ppp_generic.c to be included.
> It's not so much fun to have to maintain patches.  The changes required
> are generic, don't require crypto, and are generally uneventful.  Getting
> the crypto bits and the mppe compressor itself included would just be
> a bonus.

The fundamental problem is that MPPE is misusing CCP (compression
control protocol) for something for which it was never intended.  The
specific place where this is a problem is that the compression code in
ppp_generic doesn't guarantee that it will never send a packet out
uncompressed, but MPPE requires that.  How do you get around that
problem?

Regards,
Paul.
