Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTEFTpu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 15:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbTEFTpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 15:45:14 -0400
Received: from zero.aec.at ([193.170.194.10]:17420 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261292AbTEFToy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 15:44:54 -0400
Date: Tue, 6 May 2003 21:56:14 +0200
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andi Kleen <ak@muc.de>, torvalds@transmeta.com, akpm@digeo.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix .altinstructions linking failures
Message-ID: <20030506195614.GA23831@averell>
References: <20030506063055.GA15424@averell> <20030506164441.GO9794@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506164441.GO9794@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 06:44:41PM +0200, Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
> #ifdef MODULE
> static void proc_cpia_destroy(void)
> {
>         remove_proc_entry("cpia", 0);
> }
> #endif /*MODULE*/
> ...
> static void __exit cpia_exit(void)
> {
> #ifdef CONFIG_PROC_FS
>         proc_cpia_destroy();
> #endif
> }

The driver is buggy. The #ifdef MODULE needs to be removed and proc_cpia_destroy 
be marked __exit instead, then things will be ok.

-Andi
