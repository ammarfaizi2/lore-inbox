Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVGLXLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVGLXLz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbVGLXLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:11:47 -0400
Received: from ausc60pc101.us.dell.com ([143.166.85.206]:31377 "EHLO
	ausc60pc101.us.dell.com") by vger.kernel.org with ESMTP
	id S262467AbVGLXJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:09:28 -0400
X-IronPort-AV: i="3.94,192,1118034000"; 
   d="scan'208"; a="285137545:sNHT20897930"
Date: Tue, 12 Jul 2005 18:17:29 -0500
From: Doug Warzecha <Douglas_Warzecha@dell.com>
To: Chris Wedgwood <cw@f00f.org>, rdunlap@xenotime.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: Add Dell Systems Management Base driver
Message-ID: <20050712231729.GA15062@sysman-doug.us.dell.com>
References: <20050706001333.GA3569@sysman-doug.us.dell.com> <20050706005320.GA23709@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706005320.GA23709@taniwha.stupidest.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2005 at 07:53:20PM -0500, Chris Wedgwood wrote:
>    On Tue, Jul 05, 2005 at 07:13:34PM -0500, Doug Warzecha wrote:
> 
>    > This patch adds the Dell Systems Management Base driver.
> 
>    You keep posting this driver without explaining/showing how it's used.
>    Could you perhaps give some more details here please?

Here's some more information on the driver and the systems that it supports.  Because the hardware interfaces on those systems and the Dell systems management software that access the interfaces are proprietary, I can't provide specifications for the interfaces or source code for the software.

The systems that are supported by the dcdbas driver contain the following Dell proprietary hardware systems management interfaces:  Temperature Voltage Monitor (TVM) and Calling Interface.  These interfaces are supported by older Dell PowerEdge systems.  The latest shipping PowerEdge systems support the standard IPMI hardware systems management interface which can be accessed by the in-kernel standard IPMI driver on Linux.  Future PowerEdge systems are expected to support the IPMI systems management interface as well.

The Dell TVM and Calling Interface interfaces are accessed through the use of Systems Management Interrupts.  The dcdbas driver acts primarily as a pass-through mechanism for Dell systems management software to generate those interrupts.  Dell systems management software (which is proprietary) loads and uses the driver if it is needed.  The dcdbas driver provides access to the TVM and Calling Interface systems management interfaces through the use of ioctls.

Here is a brief description of each ioctl request that is supported:

ESM_TVM_ALLOC_MEM - used to allocate a buffer for systems management requests on systems that contain the TVM systems management interface.  The physical address of the buffer is needed to generate the request.

ESM_TVM_WRITE_MEM - used to put systems management request data in the TVM buffer.  After this is done, Dell systems management software generates the request.

ESM_TVM_READ_MEM - used to get systems management response data from the TVM buffer after the systems management request has completed.

ESM_CALLINTF_REQ - used to generate a systems management request on systems that contain the Calling Interface systems management interface.

ESM_TVM_HC_ACTION - used to tell the driver what host control action to perform on systems that contain the TVM systems management interface.

ESM_HOLD_OS_ON_SHUTDOWN - used to tell the driver to perform the previously set host control action when it is notified that the OS has finished shutting down.  Dell systems management software initiates the OS shutdown after this request.

ESM_CANCEL_HOLD_OS_ON_SHUTDOWN - used to cancel ESM_HOLD_OS_ON_SHUTDOWN if the systems management software encounters a problem in the host control process.
