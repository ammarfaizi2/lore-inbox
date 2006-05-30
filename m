Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWE3XRA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWE3XRA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWE3XRA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:17:00 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:19585 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S964815AbWE3XQ7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:16:59 -0400
Date: Tue, 30 May 2006 16:19:17 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [stable] [PATCH 2.6.16.18 0/4] sbp2: workaround for buggy iPods
Message-ID: <20060530231917.GI18769@moss.sous-sol.org>
References: <tkrat.b9bf60697156ef7b@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tkrat.b9bf60697156ef7b@s5r6.in-berlin.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Stefan Richter (stefanr@s5r6.in-berlin.de) wrote:
> There is a firmware bug in several Apple iPods which prevents access to
> these iPods under certain conditions. The disk size reported by the iPod
> is one sector too big. Once access to the end of the disk is attempted,
> the iPod becomes inaccessible. This problem has been known for USB iPods
> for some time and has recently been discovered to exist with
> FireWire/USB combo iPods too.
> 
> The following patchset is the fix as it exists in Linux 2.6.17-rc. Alas
> it is rather large, therefore it may be unfit for -stable as it is. If
> there are objections, I would appreciate suggestions how to better adapt
> this fix for -stable.

Just to be clear, we're talking about this fix:

+	if (scsi_id->workarounds & SBP2_WORKAROUND_FIX_CAPACITY)
+		sdev->fix_capacity = 1;

with patches 1 and 2 consolidating workaround logic, and 4 adding the
command line override.

I'd feel better to let this bit diverge in -stable to have the two-line
patch rather than all 4 patches.  Could you do detection sbp2_probe(),
set a flag in scsi_id_instance_data, and use that in slave_configure?

thanks,
-chris
