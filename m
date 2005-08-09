Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVHIIGe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVHIIGe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 04:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVHIIGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 04:06:34 -0400
Received: from gw.exalead.com ([84.233.148.29]:26098 "EHLO exalead.com")
	by vger.kernel.org with ESMTP id S932226AbVHIIGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 04:06:33 -0400
Message-ID: <42F863EC.3040908@exalead.com>
Date: Tue, 09 Aug 2005 10:06:04 +0200
From: Xavier Roche <roche+kml2@exalead.com>
Organization: Exalead
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: fr, en-us, en, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernels Out Of Memoy(OOM) killer Problem ?
References: <W727852995526691123573922@burntmail>
In-Reply-To: <W727852995526691123573922@burntmail>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

vinay wrote:
> I have a problem with linux kernel's Out Of Memory (OOM) killer.
> I wanted to know, is there any way that we can force OOM killer to send a signal other than SIGKILL to kill a process when ever OOM detects a system memory crunch. 

As far as I understand the kernel, oom is called when the system has no
memory pages left, and MUST get one to continue normal (ie. kernel)
processing. The kernel just do not have the time to execute some
user-space code, it MUST get free pages where they are (and hence, kill
immediately some innocent process).

This condition should not occur without using overcommit. Are you sure
you are not using overcommit ? (cat /proc/sys/vm/overcommit_memory)

To dasable it:
echo 0 > /proc/sys/vm/overcommit_memory

Overcommit is quite dangerous on production systems, because it leads to
oom kills on heavy loads (at least, this is what I experienced).

