Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265109AbUGCAC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265109AbUGCAC0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 20:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265371AbUGCACZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 20:02:25 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:36244 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265109AbUGCACX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 20:02:23 -0400
Subject: [PATCH] [0/2] acpiphp extension for 2.6.7 (take 3)
From: Vernon Mauery <vernux@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Greg KH <gregkh@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       Pat Gaughen <gone@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Jess Botts <botts@us.ibm.com>,
       pcihpd <pcihpd-discuss@lists.sourceforge.net>
In-Reply-To: <20040702205806.GF29580@kroah.com>
References: <1087934028.2068.57.camel@bluerat>
	 <20040624214555.GA1800@us.ibm.com> <1088553033.25961.63.camel@bluerat>
	 <20040702205806.GF29580@kroah.com>
Content-Type: text/plain
Message-Id: <1088812920.4446.24.camel@bluerat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 02 Jul 2004 17:02:01 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-02 at 13:58, Greg KH wrote:
> I'm going to hold off applying these till you address the issues raised
> on the mailing list.

Greg,

I think I have fixed the problems that have been discussed on the
lists.  Many of the fixes had to do with too many checks on pointers.  I
killed all the checks except for the ones that would make the machine
oops immediately.  That was the guideline I used to make the decision on
what was a worthy check or not.  Let me know what you think about the
new version

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


