Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbVK3GjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbVK3GjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 01:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVK3GjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 01:39:12 -0500
Received: from mail.tnnet.fi ([217.112.240.26]:945 "EHLO mail.tnnet.fi")
	by vger.kernel.org with ESMTP id S1751086AbVK3GjL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 01:39:11 -0500
Message-ID: <438D4905.9F023405@users.sourceforge.net>
Date: Wed, 30 Nov 2005 08:39:01 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
To: Benjamin LaHaise <bcrl@kvack.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] x86-64 put current in r10
References: <20051130042118.GA19112@kvack.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> The following emails contain the patches to convert x86-64 to store current
> in r10 (also at http://www.kvack.org/~bcrl/patches/v2.6.15-rc3/).
[snip]
> No benchmarks that I am aware of show regressions with this change.

Ben,
Your patch breaks all out-of-tree amd64 assembler code used in kernel. r10
register is one of those registers that does not need to be preserved across
function calls, and reserving that register for other purpose means that all
assembler code using r10 in kernel must be rewritten. This is deeply
unfunny.

Andi,
Please don't apply Ben's patch. It is already bad enough having to deal with
two incompatible calling conventions on 32 bit x86.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
