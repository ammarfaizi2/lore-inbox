Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264119AbTDJRvC (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 13:51:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264120AbTDJRvC (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 13:51:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18850
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264119AbTDJRvB (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 13:51:01 -0400
Subject: Re: bdflush flushing memory mapped pages.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Ansell <keitha@edp.fastfreenet.com>
Cc: Andrew Morton <akpm@digeo.com>, Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, axboe@suse.de
In-Reply-To: <01bc01c2ff9d$0dc1aca0$230110ac@kaws>
References: <007601c2fecd$12209070$230110ac@kaws>
	 <Pine.LNX.4.10.10304090209440.12558-100000@master.linux-ide.org>
	 <20030409022726.1ec93a0f.akpm@digeo.com>
	 <01bc01c2ff9d$0dc1aca0$230110ac@kaws>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049994246.10869.20.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Apr 2003 18:04:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-10 at 21:09, Keith Ansell wrote:
> I am porting a Database solution to Linux from Unix SVR4, Sco OpenServer and
> AIX, where all write required memory mapped files are flushed to disk with
> the system flusher, my users have large systems (some in excess of 600
> concurrent connections) flushing memory mapped files is a big part of are
> systems performance.  This ensures that in the event of a catastrophic
> system failure the customers vitual business data has been written to disk .

Well maybe you should fix the other ports, because they aren't required
to flush that data and you may get burned nastily from it.

Also understand _why_ the policy is the way it is. Flushing mapped files
is bad for performance of the app. Its also useless for most apps
because there are no ordering guarantees implied by it.

If you have a case that needs it all you have to do is fork/clone a 
thread which does the needed msync's. If we enforce broken behaviour on
applications they cant fork a thread to stop the msyncs...


