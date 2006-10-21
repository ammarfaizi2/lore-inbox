Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161473AbWJUNW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161473AbWJUNW7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 09:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161486AbWJUNW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 09:22:59 -0400
Received: from ns2.suse.de ([195.135.220.15]:34719 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161473AbWJUNW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 09:22:58 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Date: Sat, 21 Oct 2006 15:22:53 +0200
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20061006081607.GB8793@frankl.hpl.hp.com> <200610161636.52721.ak@suse.de> <20061021091837.GA24670@frankl.hpl.hp.com>
In-Reply-To: <20061021091837.GA24670@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610211522.53938.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I finally found the culprit for this. The current code is wrong for the
> simple reason that the cpu_idle() function is NOT always the lowest level
> idle loop function. For enter_idle()/__exit_idle() to work correctly they
> must be placed in the lowest-level idle loop. The cpu_idle() eventually ends
> up in the idle() function, but this one may have a loop in it! This is the
> case when idle()=cpu_default_idle() and idle()=poll_idle(), for instance. 

Ah now I remember - i had actually fixed that (it was the cleanup-idle-loops
patch) that moved the loops one level up. But then I disabled the patch
at the request of Andrew because it conflicted with some ACPI idle changes.

I'll readd it for .20, then things should be ok.

-Andi
