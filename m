Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUDNQKl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 12:10:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264268AbUDNQKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 12:10:41 -0400
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25]:6054 "HELO
	cenedra.office") by vger.kernel.org with SMTP id S261422AbUDNQKj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 12:10:39 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: select returns unexpected errno 514 on signal (Linus was going to fix this?)
Date: Wed, 14 Apr 2004 17:10:36 +0100
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141710.36465.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When debugging (with gdb) a usermode program which receives a signal during 
select(), select returns -1 and sets errno to 514, rather than the expected 
EINTR.

Googling finds this reply from Linus to a similar thread a couple years ago, 
which seems to suggest a patch was to be applied. If so, it hasn't been (this 
machine is running 2.6.3)

--------------------------
On Thu, 15 Aug 2002, Brian Wellington wrote: 
 > 
 > If that's the case, then how does 
 > fprintf(stderr, "select: %s\n", strerror(errno)); 
 > print 
 > select: Unknown error 514 
 > ? 
 > 
 > That's the traced process printing the error, not the tracing process. 
 
Ahh, dang, there's a patch floating around for this case. Basically, 
 tracing interferes with the normal behaviour (ie you _shouldn't_ see this 
 normally, only when tracing system calls). 

                linus 
-------------------------

Andrew Walrond
