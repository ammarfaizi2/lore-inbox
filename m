Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268290AbUGXFKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268290AbUGXFKw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268291AbUGXFKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:10:52 -0400
Received: from main.gmane.org ([80.91.224.249]:1961 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S268290AbUGXFKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:10:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: clearing filesystem cache for I/O benchmarks
Date: Fri, 23 Jul 2004 18:54:54 -0400
Message-ID: <87vfgeuyf5.fsf@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dhcp160177114.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:ZsP9Hu2AYgbDCcubAaP81lNrEE4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I purge all of the kernel's filesystem caches, so I can trust
that my I/O (read) requests I'm trying to benchmark bypass the kernel
filesystem cache?

Unfortunately, I cannot:

1) reboot the system

2) re-mount the filesystem where the reads are occuring

So I propose that I am left with the following options:

3) Reading through a file sufficiently larger than the RAM installed
   on the system?  e.g. read through a 10GB file on a machine with 8GB
   of RAM

4) Since I can create the files fresh every time, I would write() them
   out using O_DIRECT flag to open(), then the immediately following
   read of that file would be guaranteed to avoid pulling it from
   cache.

So, can someone evaluate whether how whether options 3 and 4 would
work, or offer other suggestons?  And I wouldn't object if the issue
of clearing disk and controller cache entered into the discussion (I'm
thinking #3 would do a better job at clearing disk/controller caches).

In case it is relevant, here are the two relevant kernel versions I'm
using, both under the distribution "Red Hat Enterprise Linux AS
release 3 (Taroon)":

    Linux xio11 2.6.6 #2 SMP Wed Jun 9 10:37:24 EDT 2004 i686 i686 i386 GNU/Linux
    
    Linux xio06 2.4.21-9.ELhugemem #1 SMP Tue Apr 27 13:52:32 EDT 2004 i686 i686 i386 GNU/Linux
    
Thank you,
-- 
Benjamin Rutt

