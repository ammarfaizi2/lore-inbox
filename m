Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbUCSAJa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 19:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbUCSAFy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 19:05:54 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:58277 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S263337AbUCSAC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 19:02:27 -0500
Date: Thu, 18 Mar 2004 16:00:43 -0800
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: hch@infradead.org, mingo@elte.hu, drepper@redhat.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: sched_setaffinity usability
Message-Id: <20040318160043.79643111.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org>
References: <40595842.5070708@redhat.com>
	<20040318112913.GA13981@elte.hu>
	<20040318120709.A27841@infradead.org>
	<Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Or make a "/etc/sysconf/array" file, and just map it and look up the 
> values there.

On our [SGI's] Linux 2.4 kernel versions, we have a file called

   /var/cpuset/cpu-node-map

that is built by an init script each boot, and lists each CPU, and the
corresponding Node number.  Our user level library code reads that file
in as need be (caching the results of parsing it), and provides a
convenient way of asking how many CPUs, how many Memory Nodes, and on
which Node each CPU is located.

As we have worked our way through various hardware configuration
and devfs changes, the init script has changed how it pokes around
to obtain this information.

But the user level stuff that uses this file, via some library calls,
has not seen these problems - and enjoys having a convenient place from
which to obtain this information.

Our above choice of pathname for this file is a botch, but the idea
sounds like an instance of what Linus is suggesting.

The file is formatted with two whitespace separated ascii numbers per
line, a CPU number and the number of the associated Memory Node.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
