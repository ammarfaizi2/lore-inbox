Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262469AbVCIU6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262469AbVCIU6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 15:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVCIUzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 15:55:23 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:40587 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262453AbVCIUw5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 15:52:57 -0500
Subject: Re: [PATCH] make st seekable again
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200503081911.j28JBlxi016013@hera.kernel.org>
References: <200503081911.j28JBlxi016013@hera.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110401474.3116.241.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 09 Mar 2005 20:51:15 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-08 at 17:25, Linux Kernel Mailing List wrote:
> ChangeSet 1.2030, 2005/03/08 09:25:05-08:00, kai.makisara@kolumbus.fi
> 
> 	[PATCH] make st seekable again
> 	
> 	Apparently `tar' errors out if it cannot perform lseek() against a tape.  Work
> 	around that in-kernel.

Unfortunately this isn't a good idea. Allowing tar to read the tape
position makes sense, allowing it to zero the position might but you
have to do major surgery on the driver first because

1.	It doesn't use ppos
2.	It doesn't do locking on the ppos at all

Also allowing apps to randomly seek and report "ok" when they are
backing up to tape and might really need to see the error is not what
I'd call stable, professional or quality code.

I oppose this change for 2.6.11.3, I think 2.6.12 needs to address the
rest of the mess in that code to make it work (or implement a 'read
only' llseek and
use ppos right)

And -ac won't carry this change.

