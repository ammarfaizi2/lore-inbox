Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbTKKHeV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 02:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263389AbTKKHeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 02:34:20 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:52099 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S263388AbTKKHeT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 02:34:19 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 10 Nov 2003 23:34:18 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: jw schultz <jw@pegasys.ws>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
In-Reply-To: <20031111034815.GA17240@pegasys.ws>
Message-ID: <Pine.LNX.4.44.0311102323240.980-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003, jw schultz wrote:

> If not you can test the directory.
> 
>         ls -l $CVSROOT/CVSROOT >$TMPFILE.start
>         touch $TMPFILE.test
> 
>         until diff -q $TMPFILE.start $TMPFILE.test >/dev/null
>         do
> 		ls -l $CVSROOT/CVSROOT >$TMPFILE.start
>                 rsync .....
>                 ls -l $CVSROOT/CVSROOT >$TMPFILE.test
>         done
>         rm -f $TMPFILE.start $TMPFILE.test

It does not work either. If CVSROOT files are updated at the end, you can 
still fetch some new files and be able to fetch the old CVSROOT before the 
update process will be able to do it. I believe that the LOCK file idea 
should work pretty nicely. The update process goes like:

create LOCK
update repo
remove LOCK

While the client can simply:

do
    rsync
while exist LOCK



- Davide



