Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbTH2OYh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 10:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbTH2OYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 10:24:37 -0400
Received: from user-0cal2fl.cable.mindspring.com ([24.170.137.245]:6053 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S261257AbTH2OYe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 10:24:34 -0400
Message-ID: <3F4F6233.5050809@davehollis.com>
Date: Fri, 29 Aug 2003 10:24:51 -0400
From: David T Hollis <dhollis@davehollis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 -> ext3 on the fly?
References: <20030829141619.GA12564@rdlg.net>
In-Reply-To: <20030829141619.GA12564@rdlg.net>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris wrote:

>I have a number of servers which are currently mounting /usr as ext2.  I 
>have a means of doing an tune2fs -j on all of them remotely en mass but
>I'd rather not reboot them all to enable journaling on machines that are
>up and not having issues.  I've tried to do a:
>
>mount -t ext3 -o remount /usr
>
>as well as just a mount -o remount after changing the fstab.
>
>on a test box but it just blows out a usage message.  Is there a way to
>do this remount without a complete reboot that'll be transparant to
>users?
>
>
>If not, is it dangerous to tune2fs the filesystems, change the fstab and
>then leave the box up for 2-6 months and let them reboot through
>atrrition, upgrades, etc?
>
>Current kernel is 2.4.21-ac3, getting outages and upgrades is a rather
>long process involving regression testing, etc.
>
>Robert
>
>:wq!
>---------------------------------------------------------------------------
>Robert L. Harris                     | GPG Key ID: E344DA3B
>                                         @ x-hkp://pgp.mit.edu
>DISCLAIMER:
>      These are MY OPINIONS ALONE.  I speak for no-one else.
>
>Life is not a destination, it's a journey.
>  Microsoft produces 15 car pileups on the highway.
>    Don't stop traffic to stand and gawk at the tragedy.
>  
>
I would be inclined to say it's not safe not from a code perspective but 
an administration perspective.  If you make a change as significant as 
the file system format but don't test it until you reboot the box six 
months from now (when you aren't thinking about how you changed it six 
months ago) problems are likely to happen.  Could be a simple typo or 
something else, but it can definitely come back to bite you in the 
backside.  Granted, if you forgot to change your fstab to ext3, you'd 
still boot and be fine running as ext2, you just never can tell what 
could happen.  Murphy always likes to visit on those occasions.

