Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbREaOHB>; Thu, 31 May 2001 10:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbREaOGv>; Thu, 31 May 2001 10:06:51 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:14857
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S263096AbREaOGl>; Thu, 31 May 2001 10:06:41 -0400
Date: Thu, 31 May 2001 09:56:53 -0400
From: Chris Mason <mason@suse.com>
To: Andrej Borsenkow <Andrej.Borsenkow@mow.siemens.ru>,
        linux-kernel@vger.kernel.org
Subject: Re: NULL characters in file on ReiserFS again.
Message-ID: <874280000.991317413@tiny>
In-Reply-To: <000201c0e9c5$7643d540$21c9ca95@mow.siemens.ru>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, May 31, 2001 03:33:06 PM +0400 Andrej Borsenkow
<Andrej.Borsenkow@mow.siemens.ru> wrote:

> This happened to me yesterday on kernel-2.4.4-6mdk (Mandrake cooker, based
> on 2.4.4-ac14), single reiser root filesystem, mounted with default
> options. Hardware - ASUS CUSL2 (i815e chipset), Fujitsu UDMA-4 drive.
> 
> I tried to change hostname and did not have the corresponding entry in
> /etc/hosts (or anywhere). As a tesult, startx hung starting X server; it
> was not possible to switch to alpha console or kill X server. I pressed
> reset and after reboot looked into /var/log/XFree86*log - and there were
> a bunch of ^@ there.
> 

There are two ways to get nulls in log files.  reiserfs bugs, and a crash
before data blocks are flushed to disk.  You've probably hit the second.
Reiserfs only logs metadata, so it is possible for newly allocated data
blocks to have null bytes after a crash.

Patches are in progress to flush new data blocks before transaction commit.
I'm about to send out the first building block for this...

-chris


