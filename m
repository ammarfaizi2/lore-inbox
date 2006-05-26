Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWEZTv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWEZTv6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 15:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbWEZTv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 15:51:58 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44772 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751401AbWEZTv6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 15:51:58 -0400
Date: Fri, 26 May 2006 12:54:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       greg@kroah.com, tom.l.nguyen@intel.com, brice@myri.com,
       rajesh.shah@intel.com
Subject: Re: [RFC]disable msi mode in pci_disable_device
Message-Id: <20060526125440.0897aef5.akpm@osdl.org>
In-Reply-To: <1148612307.32046.132.camel@sli10-desk.sh.intel.com>
References: <1148612307.32046.132.camel@sli10-desk.sh.intel.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shaohua Li <shaohua.li@intel.com> wrote:
>
> Brice said the pci_save_msi_state breaks his driver in his special usage
> (not in suspend/resume), as pci_save_msi_state will disable msi mode.

That sounds wrong of pci_save_msi_state().  It's supposed to save the
state, not to go fiddling with it.

> In
> his usage, pci_save_state will be called at runtime, and later (after
> the device operates for some time and has an error) pci_restore_state
> will be called.

Is that a sane thing for a driver to be doing?  (Not relevant to this issue
though).

> In another hand, suspend/resume needs disable msi mode, as device should
> stop working completely. This patch try to workaround this issue.
> Drivers are expected call pci_disable_device in suspend time after
> pci_save_state.

Surely the drivers should be calling pci_disable_msix() or something after
saving the state rather than relying upon magical side-effects of
pci_save_msi_state().  Or we do disable_msi_mode() or whatever in
pci_disable_device().

