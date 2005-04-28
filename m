Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262197AbVD1R7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbVD1R7E (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262201AbVD1R7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:59:04 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:37092 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262197AbVD1R66 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:58:58 -0400
In-Reply-To: <1114688117.10083.7.camel@lade.trondhjem.org>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: 7eggert@gmx.de, Andrew Morton <akpm@osdl.org>, bulb@ucw.cz,
       hch@infradead.org, jamie@shareable.org,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com,
       Miklos Szeredi <miklos@szeredi.hu>, Pavel Machek <pavel@ucw.cz>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Subject: Re: [PATCH] private mounts
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFF95431C8.830FB697-ON88256FF1.006112B7-88256FF1.0062D7C3@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 28 Apr 2005 10:58:18 -0700
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M4_01112005 Beta 3|January
 11, 2005) at 04/28/2005 13:58:55,
	Serialize complete at 04/28/2005 13:58:55
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is why you have identity squashing and/or strong security: to stop
>the CLIENT administrator impersonating whoever he wants and working
>around your security measures.

That's more of a confirmation than a refutation of the statement that NFS 
root squashing is broken.  Root squashing itself simply does not squash a 
typical system administrator's ability to get at other people's files. 
"broken" isn't the right word, because as long as you recognize root 
squashing for what it is, it's working as designed.  It just isn't what it 
appears to be.

But, in the context of the current thread, I think the perception of NFS 
root squashing as something broken and not to be built upon with private 
mounts has to do with the fact that it messes up Linux's basic file 
permission scheme:  a process with CAP_DAC_OVERRIDE can get EACCES. 
EACCESS means discretionary access controls (DAC) prevent access.  So this 
behavior is unexpected and unnatural.  Worse, an operation can succeed 
_without_ CAP_DAC_OVERRIDE, but not _with_ it.  I've seen this behavior 
cause trouble a number of times -- mostly because it's entirely 
unanticipated.

--
Bryan Henderson                          IBM Almaden Research Center
San Jose CA                              Filesystems
