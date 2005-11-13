Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVKMRMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVKMRMF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 12:12:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964946AbVKMRMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 12:12:05 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:54545 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S964944AbVKMRMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 12:12:02 -0500
Date: Sun, 13 Nov 2005 10:29:30 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Tony <tony.uestc@gmail.com>
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: MOD_INC_USE_COUNT
Message-ID: <20051113102930.GA16973@linux-mips.org>
References: <437347B5.6080201@gmail.com> <Pine.LNX.4.61.0511100859400.18912@chaos.analogic.com> <43735766.3070205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43735766.3070205@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 10:21:26PM +0800, Tony wrote:

> But when the module is used by a net_device(interface is up), rmmod also 
> works. Strange, isn't it?

Not strange at all.  The typical network driver is implemented using
pci_register_driver which will set the owner filed of the driver's struct
driver which then is being used for internal reference counting.  Other
busses or line disciplines (SLIP, PPP, AX.25 ...) need to do the equivalent
or the kernel will believe reference counting isn't necessary and it's
ok to unload the module at any time.

In which driver did you hit this problem?

  Ralf
