Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWKEVfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWKEVfS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 16:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422699AbWKEVfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 16:35:18 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:3772 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422702AbWKEVfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 16:35:17 -0500
Date: Sun, 5 Nov 2006 13:34:21 -0800
From: Paul Jackson <pj@sgi.com>
To: balbir@in.ibm.com
Cc: menage@google.com, sekharan@us.ibm.com, ckrm-tech@lists.sourceforge.net,
       akpm@osdl.org, jlan@sgi.com, mbligh@google.com, rohitseth@google.com,
       winget@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [ckrm-tech] [PATCH 6/6] Resource Groups over generic containers
Message-Id: <20061105133421.6cea9734.pj@sgi.com>
In-Reply-To: <454E5437.1020909@in.ibm.com>
References: <20061004234316.677837000@menage.corp.google.com>
	<20061004235752.935272000@menage.corp.google.com>
	<454E5437.1020909@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Balbir wrote:
> This should be kmalloc(nbytes), an echo ".." has a "\n" associated
> with it.

But a:
  write(1, "..", 2);
does not have a trialing newline.

If some consumer of this kernel buffer copy of what the
user wrote cannot handle the possible trailing whitespace,
they will have to chomp (Perl phrase) it off.  You can't
just whack one byte blindly.

At least for the kernel/cpuset.c code, from whence this
came, the consumers of this kernel buffer copy are such
routines as simple_strtoul() and cpulist_parse(), both
of which cope with trailing newlines.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
