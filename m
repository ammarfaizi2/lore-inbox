Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932205AbVLUAbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbVLUAbv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 19:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVLUAbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 19:31:51 -0500
Received: from mail.dslreports.com ([209.123.192.187]:2203 "EHLO mail.dslr.net")
	by vger.kernel.org with ESMTP id S932135AbVLUAbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 19:31:50 -0500
From: Drew Winstel <raw@dslr.net>
To: linux-ide@vger.kernel.org
Subject: Re: ATA Write Error and Time-out Notification in User Space
Date: Tue, 20 Dec 2005 18:31:38 -0600
User-Agent: KMail/1.9
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Treubig <jtreubig@hotmail.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <BAY101-F33B48301330A7FFF7849A4DF3E0@phx.gbl> <1135119036.25010.21.camel@localhost.localdomain>
In-Reply-To: <1135119036.25010.21.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512201831.38592.raw@dslr.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tuesday, December 20, 2005 16:50, Alan Cox wrote:
> On Maw, 2005-12-20 at 15:55 -0600, John Treubig wrote:
> > Where would I look in the LibATA/SCSI chain to permit Write Error and
> > Time-out notification to be passed back to user space without hanging the
> > system?
>
> Some background first:
>
> The 2.6 block layer can generally handle passing errors back up. It has
> a load of problems with EOF on media that is variable size but block
> that need fixing but the fundamental errors get back to the block layer.
>
> Unfortunately although they get back to the block request the full error
> is not propogated further up the stack. Thats actually tricky for the
> general file system case as I/O as asynchronous to the actual file
> system accesses and we may even hit errors on pages we didn't actually
> need.
>
> One result of that is that on write errors we generally mark a volume
> offline and processes accessing it get stuck.
>

With the application that John is using (namely, it delivers reads and writes 
directly to the drive via various SG ioctls), the file system is not an 
issue, hence wanting the errors to be returned to userspace.  

I presume this means that John would have to look at the block level error 
handling as opposed to the SCSI level?

<snip>

Drew
