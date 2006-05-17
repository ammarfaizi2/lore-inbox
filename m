Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750797AbWEQWgY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750797AbWEQWgY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 18:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWEQWgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 18:36:24 -0400
Received: from sj-iport-5.cisco.com ([171.68.10.87]:27548 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750797AbWEQWgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 18:36:22 -0400
X-IronPort-AV: i="4.05,139,1146466800"; 
   d="scan'208"; a="278590654:sNHT29972356"
To: Brice Goglin <brice@myri.com>
Cc: netdev@vger.kernel.org, gallatin@myri.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] myri10ge - Driver core
X-Message-Flag: Warning: May contain useful information
References: <20060517220218.GA13411@myri.com>
	<20060517220608.GD13411@myri.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 17 May 2006 15:36:20 -0700
In-Reply-To: <20060517220608.GD13411@myri.com> (Brice Goglin's message of "Wed, 17 May 2006 18:06:10 -0400")
Message-ID: <adairo446u3.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 17 May 2006 22:36:21.0537 (UTC) FILETIME=[52445110:01C67A02]
Authentication-Results: sj-dkim-4.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still some suspicious uses of volatile here.

For example:

> +struct myri10ge_priv {
 ...
> +	volatile u8 __iomem *sram;

as far as I can see this is always used with proper __iomem accessors,
often with casts to strip the volatile anyway.  So why is volatile needed?

I would suggest an audit of all uses of volatile in the driver, since
"volatile" in drivers really should be read "there's probably a bug
here, and if not something very tricky is going on."  If there are any
valid uses of volatile then a comment should explain why, so that
future reviewers don't have to try and puzzle out which of the
two possible translations of volatile is correct.

 - R.
