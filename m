Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVBYPOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVBYPOK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 10:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262733AbVBYPOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 10:14:09 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:30677 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262734AbVBYPMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 10:12:55 -0500
Message-ID: <421F4042.3020302@nortel.com>
Date: Fri, 25 Feb 2005 09:12:02 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Oeser <ioe-lkml@axxeo.de>
CC: "Chad N. Tindel" <chad@tindel.net>, Paulo Marques <pmarques@grupopie.com>,
       Mike Galbraith <EFAULT@gmx.de>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Xterm Hangs - Possible scheduler defect?
References: <20050224075756.GA18639@calma.pair.com> <421E2EF9.9010209@nortel.com> <20050224200802.GA39590@calma.pair.com> <200502250151.41793.ioe-lkml@axxeo.de>
In-Reply-To: <200502250151.41793.ioe-lkml@axxeo.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Oeser wrote:

> Stupid applications can starve other applications for a while, but not
> forever, because the kernel is still running and deciding.

Not so.



task 1: sched_rr, priority 1, takes mutex
task 2: sched_rr, priority 2, cpu hog, infinite loop
task 3: sched_rr, priority 99, tries to get mutex

And now tasks 1 and 3 are starved forever.  Arguably bad application 
design, but it demonstrates a case where applications can starve other 
applications.

Chris
