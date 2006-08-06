Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWHFOFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWHFOFA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 10:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbWHFOFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 10:05:00 -0400
Received: from cantor.suse.de ([195.135.220.2]:33172 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751174AbWHFOFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 10:05:00 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: fix one case of stuck dwarf2 unwinder II
Date: Sun, 6 Aug 2006 16:04:40 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Jan Beulich <jbeulich@novell.com>, Dave Jones <davej@redhat.com>,
       Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>
References: <200608060314_MC3-1-C73C-AEAE@compuserve.com>
In-Reply-To: <200608060314_MC3-1-C73C-AEAE@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608061604.40452.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> And the backtraces I saw ended up at L6:
> 
> | DWARF2 unwinder stuck at 0xc0100210
> 
> System.map on i386 SMP says:
> 
> | c0100210 t L6


Yes that's the problem. If you check for <= stext/_stext then the unwinder
won't catch the L6 (which is above it) and report a "stuck" again

-Andi

