Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbUGIAMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbUGIAMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 20:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUGIAMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 20:12:17 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:29585 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261378AbUGIAMP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 20:12:15 -0400
Subject: [PATCH] [0/2] acpiphp extension for 2.6.7 (final)
From: Vernon Mauery <vernux@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: pcihpd <pcihpd-discuss@lists.sourceforge.net>, Greg KH <gregkh@us.ibm.com>,
       lkml <linux-kernel@vger.kernel.org>, Pat Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Jess Botts <botts@us.ibm.com>
In-Reply-To: <20040708232827.GA20755@kroah.com>
References: <1087934028.2068.57.camel@bluerat>
	 <200407071147.57604@bilbo.math.uni-mannheim.de>
	 <1089216410.24908.5.camel@bluerat>
	 <200407081209.42927@bilbo.math.uni-mannheim.de>
	 <1089328415.2089.194.camel@bluerat>  <20040708232827.GA20755@kroah.com>
Content-Type: text/plain
Message-Id: <1089331908.2089.249.camel@bluerat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 08 Jul 2004 17:11:48 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-08 at 16:28, Greg KH wrote:
> Those checks are fine with me, I don't have a problem with them.
> 
> > Either way, after I make the other fixes (and possibly this one), should
> > I resubmit both patches together or just 1 of 2 alone?
> 
> Resend both of them, that way I'm reminded that they both need to be
> applied :)
> 

Just for good measure, the description is included below again. :)

The two patches are to follow

--Vernon


After much discussion, dissection, rewriting and reading (documentation
of course), I finally think this patch is ready to be included in the
kernel.  I have chosen to split it into 2 parts because really, that's
what it is -- a patch to acpiphp that allows other modules to register
attention LED callback functions and also a new module that does just
that for the IBM ACPI systems.  These patches were made against the
2.6.7 kernel tree.

01 - acpiphp-attention-v0.1d.patch

        This patch adds the ability to register callback functions with
        the acpiphp core to set and get the current attention LED
        status.  The reason this is needed is because there is not set
        ACPI standard for how this is done so each hardware platform may
        implement it differently.  To keep hardware specific code out of
        acpiphp, we allow other modules to register their code with it.


02 - acpiphp_ibm-v1.0.1d.patch

        This patch adds the first driver that actually uses the callback
        function for attention LEDs that the acpiphp-attention patch
        adds.  It searches the ACPI namespace for IBM hardware, sets up
        the callbacks and sets up a handler to read ACPI events and
        forward them on to /proc/acpi/event.  It also exports an ACPI
        table that shows current hotplug status to userland.



