Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTDRUr0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 16:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTDRUr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 16:47:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:62646 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S263235AbTDRUrZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 16:47:25 -0400
Date: Fri, 18 Apr 2003 13:49:05 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: linux-kernel <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 602] New: warnings on hcd rmmod:  "dangling refs(N) to bus B" (fwd)
Message-ID: <1382940000.1050698945@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=602

           Summary: warnings on hcd rmmod:  "dangling refs(N) to bus B"
    Kernel Version: 2.5.66
            Status: NEW
          Severity: low
             Owner: greg@kroah.com
         Submitter: dbrownell@users.sourceforge.net


The bus refcounting mechanism is broken, it often produces  warning messages like that one when modules are removed.    The problem appears to be an extremely long-standing one,  at least in terms of the how-to-reproduce I saw:     - connect a device that won't immediately enumerate,     so that setting its address needs to be retried (or     similar error, like set_configuration failing)     - unplug that device ... at this point the refcount     is wrong, but you can't tell until     - rmmod the relevant HCD.    This particular cause of that message is because the bus  refcount isn't released on error.  The fix isn't as  straightforward as it should be because of funky calling  conventions ("longstanding", likely since 2.4), but it's  not
complicated either.

