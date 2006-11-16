Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031202AbWKPQ7D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031202AbWKPQ7D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:59:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031203AbWKPQ7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:59:03 -0500
Received: from cantor.suse.de ([195.135.220.2]:53131 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031202AbWKPQ7B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:59:01 -0500
From: Andi Kleen <ak@suse.de>
To: Jiri Bohac <jbohac@suse.cz>
Subject: Re: [PATCH for 2.6.19] Fix xtime losing ticks
Date: Thu, 16 Nov 2006 17:58:56 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz
References: <20061116165201.GA18128@dwarf.suse.cz>
In-Reply-To: <20061116165201.GA18128@dwarf.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611161758.56348.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 November 2006 17:52, Jiri Bohac wrote:
> xtime is not properly incremented when main timer ticks are lost.
> Whatever the number of ticks elapsed is, only one tick worth of time
> is added to xtime. This patch fixes that.

Normally it is supposed to be called as often as there are missing
ticks (e.g. see s390 implementation of noidletick). This is also
true for non no idle tick - the hardware is not supposed to lose
interrupts.

You would need to change at least the existing noidletick implementations
in tree too.

Anyways, i'm sure it could be improved, but in .20 with dyntick
everything will be different anyways. I don't think it makes sense
to change now.

-Andi 
