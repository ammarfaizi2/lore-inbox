Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268146AbUIPPBv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268146AbUIPPBv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 11:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268105AbUIPO51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 10:57:27 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:51407 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S268115AbUIPO4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 10:56:12 -0400
Date: Thu, 16 Sep 2004 07:55:01 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch] cpusets: fix race in cpuset_add_file()
Message-Id: <20040916075501.20c3ee45.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0409161548040.5423@openx3.frec.bull.fr>
References: <20040916012913.8592.85271.16927@sam.engr.sgi.com>
	<Pine.LNX.4.61.0409161548040.5423@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Color me confused - this cpuset_sem down/up should not be needed,
and should deadlock.  In the call chain:

    cpuset_mkdir -> cpuset_create -> cpuset_populate_dir -> cpuset_add_file

cpuset_create() already holds the cpuset_sem for the duration, and you're
adding another cpuset_sem down in cpuset_add_file(), which should deadlock.

If you are seeing the duplicate invalid cpuset entries, then must be
something else going on, unfortunately.

That, or I'm confused.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
