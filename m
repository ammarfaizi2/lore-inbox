Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbUBHXOf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 18:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbUBHXOf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 18:14:35 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:9088 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S264391AbUBHXOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 18:14:33 -0500
Subject: Re: When should we use likely() / unlikely() / get_unaligned() ?
From: David Woodhouse <dwmw2@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       matthew@wil.cx
In-Reply-To: <20040208151121.1e63a8f2.davem@redhat.com>
References: <1076238833.12587.229.camel@imladris.demon.co.uk>
	 <20040208230331.79FEB2C003@lists.samba.org>
	 <20040208151121.1e63a8f2.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1076282070.8563.5.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Sun, 08 Feb 2004 23:14:30 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-02-08 at 15:11 -0800, David S. Miller wrote:
> That's right, for the old old ARMs they've always been broken
> with certain types of encapsulations due to this.  Even just feed
> them certain kinds of odd TCP/IP option sequences and watch the
> packet handling work on corrupted header data on such older ARMs.

With the merge of uCLinux there are more machines like this too. I've
been playing with one recently where alignment exceptions are imprecise
:)

Adding a probability to get_unaligned() lets _all_ architectures set
their own optimal threshold for when to emit inline load/store code, and
when to take the exception.... and the ones which will set that
threshold at 0% become an arch-specific special case which you really
don't have to care about.

-- 
dwmw2


