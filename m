Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422910AbWJPXJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422910AbWJPXJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422920AbWJPXJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 19:09:58 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:65350 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422915AbWJPXJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 19:09:55 -0400
Date: Mon, 16 Oct 2006 16:09:13 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061016230913.GN2747@ca-server1.us.oracle.com>
Mail-Followup-To: Chandra Seetharaman <sekharan@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <20061011131935.448a8696.akpm@osdl.org> <20061011221822.GD7911@ca-server1.us.oracle.com> <20061011154836.9befa359.akpm@osdl.org> <1160609233.6389.82.camel@linuxchandra> <20061014080107.GB19325@kroah.com> <20061014124351.63434962.akpm@osdl.org> <20061014201016.GG2747@ca-server1.us.oracle.com> <1161026675.6389.128.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161026675.6389.128.camel@linuxchandra>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 12:24:35PM -0700, Chandra Seetharaman wrote:
> On Sat, 2006-10-14 at 13:10 -0700, Joel Becker wrote:
> > 	Issues of PAGE_SIZE and attribute size aside, the patch posted
> > was incorrect.  While they used seq_file, they implemented it in a
> 
> I do not think it is incorrect. It provides a simplest interface to
> configfs's clients.

	I understand that it provides a simple sed(1)-based change for
existing clients.  However, it abuses seq_file in exactly the wrong way.

> > completely inefficent fashion, filling the entire buffer in one ->show()
> > call rather than letting multiple read(2) calls iterate their list.
> 
> So, are you suggesting that we should provide a generic seq_operations
> interface to configfs's clients ?

	Yes, if we provide a vector type in any way, it should be via
seq_operations or something like it.  If we're going to use seq_file, we
should use it correctly.

Joel

-- 

"What no boss of a programmer can ever understand is that a programmer
 is working when he's staring out of the window"
	- With apologies to Burton Rascoe


Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
