Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTIKQ66 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 12:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbTIKQ66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 12:58:58 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:45713 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261373AbTIKQ65
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 12:58:57 -0400
Date: Thu, 11 Sep 2003 17:58:45 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: richard.brunner@amd.com, linux-kernel@vger.kernel.org, akpm@osdl.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Message-ID: <20030911165845.GE29532@mail.jlokier.co.uk>
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <20030911012708.GD3134@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911012708.GD3134@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> +static int is_prefetch(struct pt_regs *regs, unsigned long addr)

Do I understand that certain values of "addr" can't be due to the
erratum?

In which case, could you skip most of the is_prefetch() instruction
decoder with a test like this?:

	if ((addr & 3) == 0)
		return 0;

I'm not sure from the description of the erratum what, exactly, are
the possible addresses which can appear in the fault information.

-- Jamie
