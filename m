Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWEZU1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWEZU1Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 16:27:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWEZU1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 16:27:25 -0400
Received: from h-66-166-126-70.lsanca54.covad.net ([66.166.126.70]:61424 "EHLO
	myri.com") by vger.kernel.org with ESMTP id S1750728AbWEZU1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 16:27:24 -0400
Message-ID: <44776491.1080506@myri.com>
Date: Fri, 26 May 2006 22:26:57 +0200
From: Brice Goglin <brice@myri.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060516)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Shaohua Li <shaohua.li@intel.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, greg@kroah.com, tom.l.nguyen@intel.com,
       rajesh.shah@intel.com
Subject: Re: [RFC]disable msi mode in pci_disable_device
References: <1148612307.32046.132.camel@sli10-desk.sh.intel.com> <20060526125440.0897aef5.akpm@osdl.org>
In-Reply-To: <20060526125440.0897aef5.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
>> In
>> his usage, pci_save_state will be called at runtime, and later (after
>> the device operates for some time and has an error) pci_restore_state
>> will be called.
>
> Is that a sane thing for a driver to be doing? (Not relevant to this issue
> though).

The aim is to be able to recover from a memory parity error in the NIC.
Such errors happen sometimes, especially when a cosmic ray comes by. To
recover, we restore the state that we saved at the end of the
initialization. As saving currently disables MSI, we currently have to
restore the state right after saving it at the end of the initialization
(see the end of
myri10ge_probe in http://lkml.org/lkml/2006/5/23/24).

I just tried, the patch fixes our problem (no need to restore right
after saving to reenable MSI).

Brice

