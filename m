Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264908AbUFHIun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264908AbUFHIun (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 04:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264900AbUFHIun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 04:50:43 -0400
Received: from main.gmane.org ([80.91.224.249]:60347 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264908AbUFHIug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 04:50:36 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nirendra Awasthi <linux@nirendra.net>
Subject: Core file getting corrupted
Date: Tue, 08 Jun 2004 14:16:44 +0530
Message-ID: <ca3uec$t4u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 61.16.153.178
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

    Sending SIBABRT (or any signal that causes core dump) to a process 
which is already having core dump results in corrupting core file.

Following is the output while analyzing core with gdb:

Reading symbols from /lib/tls/libc.so.6...done.
Loaded symbols for /lib/tls/libc.so.6
Reading symbols from /lib/ld-linux.so.2...done.
Loaded symbols for /lib/ld-linux.so.2
#0  0xffffe411 in ?? ()

I created the process with large core, and on sending SIGABRT and 
SIGQUIT signal to process successively, "most" of the time core file 
gets corrupted.

     Is there a way for a unrelated process to determine if another 
process is exiting and is in the state of having core dump, so it does 
not try to send another signal.



         In solaris, this can be determined using libkvm(checking 
process flags for SDOCORE and COREDUMP). Is there a way to do this in 
linux 2.6

     One of the things I observed is flag in /proc/<pid>/stat (9th 
attribute) is set to non-zero after process receives a signal to quit 
after core dump (SIGABRT, SIGQUIT etc.). Is it an indication that 
process is going to exit or what does it indicates.

-Nirendra

