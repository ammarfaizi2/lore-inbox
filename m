Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWAZNzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWAZNzu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 08:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbWAZNzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 08:55:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:21947 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932161AbWAZNzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 08:55:49 -0500
From: Andi Kleen <ak@suse.de>
To: Ashok Raj <ashok.raj@intel.com>
Subject: Re: Dont record local apic ids when they are disabled in MADT
Date: Thu, 26 Jan 2006 14:55:11 +0100
User-Agent: KMail/1.8.2
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de,
       ronald@hummelink.net, DiegoCG@teleline.es,
       venkatesh.pallipadi@intel.com
References: <20060126054842.A11917@unix-os.sc.intel.com>
In-Reply-To: <20060126054842.A11917@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601261455.11981.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 January 2006 14:48, Ashok Raj wrote:
> Hi Andrew,
> 
> We had added additional_cpus=xx for x86_64, but apparently there were some
> BIOSs that had duplicate apic ids when they were reported disabled.
> 
> It seems fair not to record them, this was causing some bad behaviour due to
> the duplicate apic id. More details in the bugzilla recorded in the log.

This means CPU hotplug will require additional non existing code again - or who
will set up the APIC IDs etc. for the new CPUs then?

An alternative might be to reject any entries that have the APIC ID of
an existing entry. That would require that the entries are sorted with disabled
after enabled
(in the worst case Linux could sort again)

-Andi

