Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUHFS3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUHFS3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 14:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268226AbUHFS3e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 14:29:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:58818 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268196AbUHFS1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 14:27:16 -0400
Date: Fri, 6 Aug 2004 11:26:46 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jean-Luc Cooke <jlcooke@certainkey.com>
Cc: jmorris@redhat.com, yoshfuji@linux-ipv6.org, cryptoapi@lists.logix.cz,
       mludvig@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]
Message-Id: <20040806112646.7931585e.davem@redhat.com>
In-Reply-To: <20040806125427.GE23994@certainkey.com>
References: <20040806042852.GD23994@certainkey.com>
	<Xine.LNX.4.44.0408060040360.20834-100000@dhcp83-76.boston.redhat.com>
	<20040806125427.GE23994@certainkey.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004 08:54:27 -0400
Jean-Luc Cooke <jlcooke@certainkey.com> wrote:

> If I can avoid scatter-gather for what is effectively just mixing bytes with
> SHA256
> & AES256 then this would make things very neat and tidy (read: easier for
> peer review)

Why do you care about scatter gather at all?  You need to allocate
a kernel buffer to copy the user bits into _anyways_.  Once you
have a kernel buffer, doing a quick onstack one-entry scatter list
is simple.

If you're trying to use the user buffer directly, sorry we're not
going to add support for that, as Linus explained it's silly.
