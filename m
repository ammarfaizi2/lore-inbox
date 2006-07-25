Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932386AbWGYBsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932386AbWGYBsz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 21:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWGYBsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 21:48:55 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:5012 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932386AbWGYBsy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 21:48:54 -0400
Date: Mon, 24 Jul 2006 18:48:47 -0700
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kamezawa.hiroyu@jp.fujitsu.com, linux-kernel@vger.kernel.org,
       ebiederm@xmission.com
Subject: Re: [RFC] ps command race fix
Message-Id: <20060724184847.3ff6be7d.pj@sgi.com>
In-Reply-To: <20060724182000.2ab0364a.akpm@osdl.org>
References: <20060714203939.ddbc4918.kamezawa.hiroyu@jp.fujitsu.com>
	<20060724182000.2ab0364a.akpm@osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another possibility (perhaps a really stupid idea ;) would be to
snapshot the list of pids on the open, and let the readdir() just
access that fixed array.

The kernel/cpuset.c cpuset_tasks_open() routine that displays the
pids of tasks in a cpuset (the per-cpuset 'tasks' file) does this.

Then the seek and read and such semantics are nice and stable and
simple.

Throw out the snapshot on the last close.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
