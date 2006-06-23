Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964780AbWFWMdd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWFWMdd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 08:33:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWFWMdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 08:33:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:30147 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932585AbWFWMdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 08:33:09 -0400
From: Andi Kleen <ak@suse.de>
To: pageexec@freemail.hu
Subject: Re: [PATCH] x86_64: another fix for canonical RIPs during signal handling
Date: Fri, 23 Jun 2006 14:29:04 +0200
User-Agent: KMail/1.9.3
Cc: Willy Tarreau <w@1wt.eu>, marcelo@kvack.org, linux-kernel@vger.kernel.org
References: <20060622213313.GA22611@1wt.eu> <449BC808.4174.277D15CF@pageexec.freemail.hu>
In-Reply-To: <449BC808.4174.277D15CF@pageexec.freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606231429.04909.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> that's not true. if the application expects to crash due to a bad
> signal handler then rip=0 may or may not achieve that, depending on
> what mapping exists at that address - this is inconsistent behaviour
> (from userland's point of view) created by the kernel itself, hence
> this is a kernel bug and should be fixed.

If it "wants" to crash it can just jump to 0 (or whatever unmapped address
it has) by itself. No need to involve the kernel here.

The only point of the patch was to not make the kernel/CPU crash due 
to CPU bugs triggered by applications. But we really
don't care what happens to the application when it corrupts its stack frame.

-Andi
