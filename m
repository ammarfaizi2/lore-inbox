Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUCRL0D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:26:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbUCRL0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:26:03 -0500
Received: from main.gmane.org ([80.91.224.249]:49297 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262521AbUCRL0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:26:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [BUG] alignment problem in net/core/flow.c:flow_key_compare
Date: Thu, 18 Mar 2004 12:25:57 +0100
Message-ID: <yw1x4qsmv1kq.fsf@kth.se>
References: <yw1x8yhyv33l.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:orjOYv6B4DxAH8YFMi2lhnl03S8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> There is a problem with alignment in the flow_key_compare function in
> net/core/flow.c.  It takes arguments of type struct flowi * and casts
> them to flow_compare_t *, which is 64 bits on 64-bit machines.  It
> then proceeds to read and compare 64-bit values from these pointers.
> The problem is that struct flowi only requires 32-bit alignment, so
> these reads cause numerous unaligned exceptions.  On average, I get
> nearly 1000 unaligned exceptions per second.
>
> The solutions I see are either to force the alignment of struct flowi
> to 64 bits, or to use 32-bit access in flow_key_compare.

I forgot to mention that this is kernel 2.6.4.

-- 
Måns Rullgård
mru@kth.se

