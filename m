Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWIMTIR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWIMTIR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 15:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbWIMTIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 15:08:17 -0400
Received: from gw.goop.org ([64.81.55.164]:46019 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751120AbWIMTIQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 15:08:16 -0400
Message-ID: <450854F3.20603@goop.org>
Date: Wed, 13 Sep 2006 11:58:59 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Zachary Amsden <zach@vmware.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael A Fetterman <Michael.Fetterman@cl.cam.ac.uk>
Subject: Assignment of GDT entries
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the rationale for the current assignment of GDT entries?  In 
particular, this section:

 *   0 - null
 *   1 - reserved
 *   2 - reserved
 *   3 - reserved
 *
 *   4 - unused			<==== new cacheline
 *   5 - unused
 *
 *  ------- start of TLS (Thread-Local Storage) segments:
 *
 *   6 - TLS segment #1			[ glibc's TLS segment ]
 *   7 - TLS segment #2			[ Wine's %fs Win32 segment ]
 *   8 - TLS segment #3
 *   9 - reserved
 *  10 - reserved
 *  11 - reserved


What are entries 1-3 and 9-11 reserved for?  Must they be unused for 
some reason, or is there some proposed use that has not been impemented yet?

Also, is there a particular reason kernel GDT entries start at 12?  
Would there be a problem in using either 4 or 5 for a kernel GDT descriptor?

I'm asking because I'd like to use one of these entries for the PDA 
descriptor, so that it is on the same cache line as the TLS 
descriptors.  That way, the entry/exit segment register reloads would 
still only need to touch two GDT cache lines.  Would there be a real 
problem in doing this?

Thanks,
    J

