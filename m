Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266144AbUF2Xu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266144AbUF2Xu4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUF2Xu4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:50:56 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:50093 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266144AbUF2Xuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:50:54 -0400
Subject: [PATCH] [0/2] acpiphp extension for 2.6.7
From: Vernon Mauery <vernux@us.ibm.com>
To: Greg KH <gregkh@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Pat Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Jess Botts <botts@us.ibm.com>,
       pcihpd-discuss@lists.sourceforge.net
In-Reply-To: <20040624214555.GA1800@us.ibm.com>
References: <1087934028.2068.57.camel@bluerat>
	 <20040624214555.GA1800@us.ibm.com>
Content-Type: text/plain
Message-Id: <1088553033.25961.63.camel@bluerat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 29 Jun 2004 16:50:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After much discussion, dissection, rewriting and reading (documentation
of course), I finally think this patch is ready to be included in the
kernel.  I have chosen to split it into 2 parts because really, that's
what it is -- a patch to acpiphp that allows other modules to register
attention LED callback functions and also a new module that does just
that for the IBM ACPI systems.  These patches were made against the
2.6.7 kernel tree.

01 - acpiphp-attention.patch

        This patch adds the ability to register callback functions with
        the acpiphp core to set and get the current attention LED
        status.  The reason this is needed is because there is not set
        ACPI standard for how this is done so each hardware platform may
        implement it differently.  To keep hardware specific code out of
        acpiphp, we allow other modules to register their code with it.


02 - acpiphp_ibm-v1.0.1c.patch

        This patch adds the first driver that actually uses the callback
        function for attention LEDs that the acpiphp-attention patch
        adds.  It searches the ACPI namespace for IBM hardware, sets up
        the callbacks and sets up a handler to read ACPI events and
        forward them on to /proc/acpi/event.  It also exports an ACPI
        table that shows current hotplug status to userland.


The two patches are to follow.

--Vernon


