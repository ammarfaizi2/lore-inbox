Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422985AbWJQDAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422985AbWJQDAW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 23:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030215AbWJQDAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 23:00:22 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8609 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030212AbWJQDAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 23:00:20 -0400
Date: Mon, 16 Oct 2006 19:59:52 -0700
From: Paul Jackson <pj@sgi.com>
To: sekharan@us.ibm.com
Cc: greg@kroah.com, menage@google.com, ckrm-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, matthltc@us.ibm.com
Subject: Re: [ckrm-tech] [PATCH 0/5] Allow more than PAGESIZE data read in
 configfs
Message-Id: <20061016195952.415f4939.pj@sgi.com>
In-Reply-To: <1161037741.5057.2.camel@linuxchandra>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain>
	<20061010203511.GF7911@ca-server1.us.oracle.com>
	<6599ad830610101431j33a5dc55h6878d5bc6db91e85@mail.gmail.com>
	<20061010215808.GK7911@ca-server1.us.oracle.com>
	<1160527799.1674.91.camel@localhost.localdomain>
	<20061011012851.GR7911@ca-server1.us.oracle.com>
	<20061011223927.GA29943@kroah.com>
	<1160609160.6389.80.camel@linuxchandra>
	<20061012235127.GA15767@kroah.com>
	<1161025825.6389.119.camel@linuxchandra>
	<20061016133256.e09e76ac.pj@sgi.com>
	<1161037741.5057.2.camel@linuxchandra>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Quick look at the seq_file interfaces shows there is no such capability.

Perhaps a seq file size limit could be added.  Not sure if that's
a good idea or not ...

Ah - cap the count + ppos the user passed in to configfs_read_file,
before passing these values to flush_read_buffer().

If the user asks for more than is allowed, give them only what they are
allowed, by passing a smaller count to flush_read_buffer().  If they
start at a position past what's allowed, force a huge ppos and let them
see the resulting EOF.  Disclaimer - I too am no seq_file expert ;).

This should be just a few more lines in configfs_read_file() on
top of your current patches adapting it to seq_file.

Granted - it is not going in directly in one step to the objective you
seek, that being a configfs suitable for displaying a long vector of
process id's, so that Resource Groups can make use of it (and maybe
someday cpusets, too.)

But it gains the code reduction and reuse benefits of your patch
set, and gets this conversation unwedged, so we can go on to discuss
whether or not it would be a good idea go add a suitable vector
interface to seq_file, without threatening the excellent improvements
that sysfs/configfs have made over the old /proc style mess.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
