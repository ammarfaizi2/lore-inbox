Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261743AbSJDTiR>; Fri, 4 Oct 2002 15:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbSJDTiR>; Fri, 4 Oct 2002 15:38:17 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:38155
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261743AbSJDTiR>; Fri, 4 Oct 2002 15:38:17 -0400
Subject: Re: export of sys_call_table
From: Robert Love <rml@tech9.net>
To: bidulock@openss7.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Pete Zaitcev <zaitcev@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021004131547.B2369@openss7.org>
References: <20021003222716.GB14919@suse.de.suse.lists.linux.kernel>
	<1033684027.1247.43.camel@phantasy.suse.lists.linux.kernel>
	<20021003233504.GA20570@suse.de.suse.lists.linux.kernel>
	<20021003235022.GA82187@compsoc.man.ac.uk.suse.lists.linux.kernel>
	<mailman.1033691043.6446.linux-kernel2news@redhat.com.suse.lists.linux.kerne
	<200210040403.g9443Vu03329@devserv.devel.redhat.com.suse.lists.linux.kernel>
	 <20021003233221.C31444@openss7.org.suse.lists.linux.kernel>
	<20021004133657.B17216@devserv.devel.redhat.com.suse.lists.linux.kernel>
	<p73fzvmqdg4.fsf@oldwotan.suse.de>
	<1033757193.31839.51.camel@irongate.swansea.linux.org.uk> 
	<20021004131547.B2369@openss7.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Oct 2002 15:43:54 -0400
Message-Id: <1033760635.742.99.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-04 at 15:15, Brian F. G. Bidulock wrote:

> Attached is an untested patch for LiS.  AK doesn't like the
> read/write_lock. AFAIK it will work for LiS but might not work
> for AFS.

It is not so much that he does not like it but you _cannot_ sleep while
holding a spinlock.  It is not just his style but common sense.

	grab lock -> sleep -> new task grabs same lock -> deadlock

You need to use a semaphore here or find some other way to provide
protection without becoming atomic.

	Robert Love

