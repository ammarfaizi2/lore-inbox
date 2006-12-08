Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424059AbWLHC15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424059AbWLHC15 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 21:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424093AbWLHC15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 21:27:57 -0500
Received: from ns.suse.de ([195.135.220.2]:34855 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424059AbWLHC14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 21:27:56 -0500
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: Re: [patch] speed up single bio_vec allocation
References: <000301c717da$3ecf4970$2589030a@amr.corp.intel.com>
From: Andi Kleen <ak@suse.de>
Date: 08 Dec 2006 03:27:54 +0100
In-Reply-To: <000301c717da$3ecf4970$2589030a@amr.corp.intel.com>
Message-ID: <p733b7rdsut.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Chen, Kenneth W" <kenneth.w.chen@intel.com> writes:
> 
> I tried to use cache_line_size() to find out the alignment of struct bio, but
> stumbled on that it is a runtime function for x86_64.

It's a single global variable access:

#define cache_line_size() (boot_cpu_data.x86_cache_alignment)

Or do you mean it caused cache misses?  boot_cpu_data is cache aligned
and practically read only, so there shouldn't be any false sharing at least.

-Andi

