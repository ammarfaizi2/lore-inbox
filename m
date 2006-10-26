Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423552AbWJZPMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423552AbWJZPMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 11:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423553AbWJZPMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 11:12:18 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:39861 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1423552AbWJZPMR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 11:12:17 -0400
From: Darren Hart <dvhltc@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: PnP Bios activation of parallel port prior to request_region
Date: Thu, 26 Oct 2006 07:59:21 -0700
User-Agent: KMail/1.9.1
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610260759.22237.dvhltc@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While working with a very simple demo parallel port interrupt driver, I found 
that request_region() will successfully return, regardless of whether or not 
the pnp calls have been made to activite the parallel port on a pnp system.  

The driver worked by just calling request_region() on another system, but on 
my laptop it wouldn't work unless I made the pnp activation calls before 
hand.  The confusion came because the io range got assigned to my module, 
showed up in /proc/ioports, etc.  So it appeared to be properly configured, 
but all the inb() calls returned 0xff.

I know have something working, but just wanted to ask if it is considered 
correct behavior for request_region() to succeed on an io range pertaining to 
a device that needs to be initialized by the pnp system and hasn't been.


-- 
Darren Hart
IBM Linux Technology Center
Realtime Linux Team
