Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbVJ3QPq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbVJ3QPq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 11:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbVJ3QPq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 11:15:46 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:31132 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751066AbVJ3QPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 11:15:46 -0500
To: Andi Kleen <ak@suse.de>
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.14-git1 (and -git2) build failure on AMD64
X-Message-Flag: Warning: May contain useful information
References: <16080000.1130681008@[10.10.2.4]> <200510301628.29560.ak@suse.de>
From: Roland Dreier <rolandd@cisco.com>
Date: Sun, 30 Oct 2005 08:15:40 -0800
In-Reply-To: <200510301628.29560.ak@suse.de> (Andi Kleen's message of "Sun,
 30 Oct 2005 16:28:29 +0100")
Message-ID: <52fyqjnfpv.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 30 Oct 2005 16:15:41.0609 (UTC) FILETIME=[2C67A190:01C5DD6D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Andi> What compiler do you use? I cannot make sense of the error -
    Andi> as far as I can see the function only has a single section
    Andi> attribute.  But gcc 4.0.2 reports the same error for me on a
    Andi> different function.

Yes, the gcc error is very strange.  The underlying cause is that
(with CONFIG_HOTPLUG=n so __devinit is not just defined away to
nothing) having toshiba_ohci1394_dmi_table[] declared __devinit makes
gcc think it has to put the array in a section along with code.  But
instead of complaining about the array declaration, gcc complains
about some random function earlier in the file -- and which function
it picks to complain about seems to change depending on gcc version
and the phase of the moon.

 - R.
