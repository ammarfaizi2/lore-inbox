Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263114AbTDFVrb (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263115AbTDFVrb (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:47:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9616
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263114AbTDFVr3 (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 17:47:29 -0400
Subject: Re: PATCH: Fixes for ide-disk.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049663520.8403.26.camel@laptop-linux.cunninghams>
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
	 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
	 <1049570711.3320.2.camel@laptop-linux.cunninghams>
	 <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
	 <1049663520.8403.26.camel@laptop-linux.cunninghams>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049662835.1600.31.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 22:00:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 22:12, Nigel Cunningham wrote:
> Hi again.
> 
> I've just reread your message. Isn't it used as a lock at the moment?
> IIRC, you get a BUG if you try to use the driver while its blocked.
> Perhaps that's where I'm getting confused.

There are multiple "blocked" fields to deal with. drive->blocked
indicates we can't feed it commands because it is blocked due to
power management.

idedisk_suspend sets the drive->blocked field so that we panic if
anything is sent to the disk after we turned it off (since it
would be a corrupter).

idedisk_resume is called on the resume path and marks the drive
as safe to use.

So if you hit that bug, you did I/O after shutting the drive down,
which is not allowed.

