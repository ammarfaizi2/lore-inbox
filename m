Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264077AbTEGQmz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbTEGQmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:42:55 -0400
Received: from keckclus.cs.usfca.edu ([138.202.170.7]:37506 "EHLO
	keckclus.cs.usfca.edu") by vger.kernel.org with ESMTP
	id S264077AbTEGQmy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:42:54 -0400
Date: Wed, 7 May 2003 09:55:17 -0700
From: Amol P Dharmadhikari <apdharmadhikari@usfca.edu>
To: Sumit Narayan <sumit_uconn@lycos.com>
Cc: fdavis@si.rr.com, linux-kernel@vger.kernel.org
Subject: Re: Write file in EXT2
Message-ID: <20030507165517.GA24547@keckclus.cs.usfca.edu>
References: <JLODCPDJJDNBCDAA@mailcity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <JLODCPDJJDNBCDAA@mailcity.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Hi,
> 
> Thanks for the details.
> 
> I wish to know which application access which file, when.. etc etc. I would like to create a log of that. I am unable to write this log to the file from within the kernel. I would not like to go to the user level programs. I am doing this from within the kernel, as I would like to know exactly when things are being done.

As Richard said in reply to your earlier email, when you are doing file
I/O, you need to store the file descriptor of the open file in some
process's fd table. If you "simply open" a file in the kernel, it is
meaningless. The kernel just executes on behalf of the currently running
process and does not have an execution context itself.

So the idea is to create a kernel thread, and open the log file in its
context. Also, you want to be sure that the filesystem on which the file
you are accessing is mounted when you call the sys_open function. Else
the first write to it might cause a panic. 

-- 
Amol P Dharmadhikari <apdharmadhikari@usfca.edu>
