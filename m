Return-Path: <linux-kernel-owner+w=401wt.eu-S1753400AbWLOUQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753400AbWLOUQm (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 15:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbWLOUQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 15:16:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:53521 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753400AbWLOUQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 15:16:40 -0500
Subject: Re: sysfs file creation result nightmare
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, Olivier Galibert <galibert@pobox.com>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20061215154751.86a2dbdd.khali@linux-fr.org>
References: <20061209165606.2f026a6c.khali@linux-fr.org>
	 <1165694351.1103.133.camel@localhost.localdomain>
	 <20061209123817.f0117ad6.akpm@osdl.org>
	 <20061209214453.GA69320@dspnet.fr.eu.org>
	 <20061209135829.86038f32.akpm@osdl.org>
	 <20061209223418.GA76069@dspnet.fr.eu.org>
	 <20061209145303.3d5fe141.akpm@osdl.org>
	 <1165712131.1103.166.camel@localhost.localdomain>
	 <20061215154751.86a2dbdd.khali@linux-fr.org>
Content-Type: text/plain
Date: Sat, 16 Dec 2006 07:16:13 +1100
Message-Id: <1166213773.31351.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Beware that sysfs_remove_bin_file() will complain loudly if you later
> attempt to delete that file that was never created.

That's another problem... what is a driver that creates 15 files
supposed to do ? Have 15 booleans to remember which files where
successfully created and then test all of them on cleanup ? That sounds
like even more bloat to me...

What about making sysfs_remove_bin_file() not complain ? It's common
practice to have disposal things not complain ... like kfree(NULL), or
the changes done recently so that misc_deregister() can be called even
if misc_register() failed etc...

Ben.


