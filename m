Return-Path: <linux-kernel-owner+w=401wt.eu-S1750770AbWLLAgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWLLAgx (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 19:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWLLAgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 19:36:53 -0500
Received: from gate.crashing.org ([63.228.1.57]:54130 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbWLLAgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 19:36:53 -0500
Subject: Re: [patch] pipe: Don't oops when pipe filesystem isn't mounted
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Al Viro <viro@ftp.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Andrew MChuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0612110834520.12500@woody.osdl.org>
References: <20061211011327.f9478117.akpm@osdl.org>
	 <20061211092130.GB4587@ftp.linux.org.uk>
	 <20061211012545.ed945cbd.akpm@osdl.org>
	 <20061211093314.GC4587@ftp.linux.org.uk>
	 <20061211014727.21c4ab25.akpm@osdl.org>
	 <20061211100301.GD4587@ftp.linux.org.uk>
	 <20061211021718.a6954106.akpm@osdl.org>
	 <20061211022746.9ec80c03.akpm@osdl.org>
	 <20061211104556.GF4587@ftp.linux.org.uk>
	 <Pine.LNX.4.64.0612110748570.12500@woody.osdl.org>
	 <20061211161212.GJ4587@ftp.linux.org.uk>
	 <Pine.LNX.4.64.0612110834520.12500@woody.osdl.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 11:33:58 +1100
Message-Id: <1165883638.7260.71.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So it makes perfect sense to say
> 
>    "you won't be getting any notification by anything built-in, until 
>     'device_initcall' (which is the default module_init, of course)".
> 
> which in the case of certain drivers obviously _does_ mean that they had 
> better not try to use any early initcalls to load firmware.

And that will fix some other issues I think I've seen (a while ago, I
might have a memory mixup here) related to /sbin/hotplug being called
before /dev/null & /dev/zero are initialized (they are fs_initcall). At
least with that patch, it won't happen.

Ben.


