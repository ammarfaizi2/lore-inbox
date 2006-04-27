Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751649AbWD0VHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbWD0VHF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 17:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWD0VHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 17:07:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28353 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751649AbWD0VHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 17:07:03 -0400
Date: Thu, 27 Apr 2006 14:09:21 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: dsp@llnl.gov, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       riel@surriel.com, nickpiggin@yahoo.com.au, ak@suse.de
Subject: Re: [PATCH 1/2 (repost)] mm: serialize OOM kill operations
Message-Id: <20060427140921.249a00b0.akpm@osdl.org>
In-Reply-To: <20060427134442.639a6d19.pj@sgi.com>
References: <200604271308.10080.dsp@llnl.gov>
	<20060427134442.639a6d19.pj@sgi.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Adding a 'oom_notify' bitfield after the existing 'dumpable'
> bitfield in mm_struct would save that slot:
> 
>         unsigned dumpable:2;
> 	unsigned oom_notify:1;

Note that these will occupy the same machine word.  So they'll need
locking.  (Good luck trying to demonstrate the race though!)

