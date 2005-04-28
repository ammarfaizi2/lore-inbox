Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262215AbVD1STN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262215AbVD1STN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 14:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVD1STN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 14:19:13 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3242 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262215AbVD1SP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 14:15:29 -0400
In-Reply-To: <1114700283.24687.193.camel@localhost.localdomain>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: brace@hp.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, mike.miller@hp.com
MIME-Version: 1.0
Subject: Re: [Question] Does the kernel ignore errors writng to disk?
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFDD96A309.D5D89999-ON88256FF1.0062E298-88256FF1.00645C51@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 28 Apr 2005 11:14:53 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/28/2005 14:15:24,
	Serialize complete at 04/28/2005 14:15:24
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>See man fsync
>and also O_DIRECT if you need specific "to disk" support

Probably the most common way to get the simple but slow write function 
where the write() call actually writes to stable storage, and fails if it 
can't, is the O_SYNC open flag.

But even that, in some versions of Linux, can miss write errors.  It's not 
easy for Linux to catch them because the code that sees the I/O fail 
doesn't know if it's part of some synchronous procedure where the user 
will eventually find out about the error or the more common case where the 
application has optimistically walked away and nothing can be done but 
write off the loss.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
