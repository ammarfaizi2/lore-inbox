Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUCKV4j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 16:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261780AbUCKV4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 16:56:38 -0500
Received: from fw.osdl.org ([65.172.181.6]:47533 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261779AbUCKV4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 16:56:31 -0500
Date: Thu, 11 Mar 2004 13:57:29 -0800
From: Andrew Morton <akpm@osdl.org>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1: 3c59x-xcvr-xif breaks 3CCFE575CT
Message-Id: <20040311135729.2fbcdc2a.akpm@osdl.org>
In-Reply-To: <1079040485.856.4.camel@teapot.felipe-alfaro.com>
References: <1079040485.856.4.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:
>
> 2.6.4-mm1 has turned to be a tricky kernel...: it breaks the 3c9x
> transceiver making my 3CCFE575CT CardBus NIC unable to process any
> incoming network frames, that is, no network communication takes place.
> 
> Reverting 3c59x-xcvr-fix.patch fixes the problem for me.

Sorry, I meant to check that one against the docs.

The patch is wrong.  For 3c905B, the transceiver select bits are
InternalConfig:20-23 and for 3c590 the transceiver select bit are
InternalConfig:20-22.

That patch thinks the transceiver select bits are bits 21 to 36 of a 32-bit
register so no, it won't work very well.

