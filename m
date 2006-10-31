Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946020AbWJaV0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946020AbWJaV0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:26:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946024AbWJaV0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:26:05 -0500
Received: from cantor2.suse.de ([195.135.220.15]:35006 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946023AbWJaV0D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:26:03 -0500
To: Daniel Yeisley <dan.yeisley@unisys.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init_reap_node() initialization fix
References: <1162328719.12872.39.camel@localhost.localdomain>
From: Andi Kleen <ak@suse.de>
Date: 31 Oct 2006 22:25:53 +0100
In-Reply-To: <1162328719.12872.39.camel@localhost.localdomain>
Message-ID: <p738xiwkwim.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Yeisley <dan.yeisley@unisys.com> writes:

> It looks like there is a bug in init_reap_node() in slab.c that can
> cause multiple oops's on certain ES7000 configurations.  The variable
> reap_node is defined per cpu, but only initialized on a single CPU.
> This causes an oops in next_reap_node() when __get_cpu_var(reap_node)
> returns the wrong value.  Fix is below.

Agreed. The cpu up call back is usually called on the BP only,
so __get_cpu_var which uses a local variable is wrong here.

-Andi
