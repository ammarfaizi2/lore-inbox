Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932173AbVKESZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932173AbVKESZK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbVKESZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:25:09 -0500
Received: from mail.dvmed.net ([216.237.124.58]:45503 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932169AbVKESZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:25:07 -0500
Message-ID: <436CF8FC.5070906@pobox.com>
Date: Sat, 05 Nov 2005 13:25:00 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [GIT PATCH] SCSI updates for 2.6.14
References: <1131207491.3614.5.camel@mulgrave>	 <Pine.LNX.4.64.0511050942490.3316@g5.osdl.org> <1131214408.3614.11.camel@mulgrave>
In-Reply-To: <1131214408.3614.11.camel@mulgrave>
Content-Type: multipart/mixed;
 boundary="------------040103030006050702040901"
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040103030006050702040901
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

James Bottomley wrote:
> Heh, they're all drwx--S--- 
> 
> I've had no end of strange trouble like this since I moved from my own
> version of git to the one installed on hera.
> 
> I think I've found and changed all the directories and verified the
> individual object permissions.  Could you try again?

With the latest git...

> [jgarzik@pretzel scsi-misc-2.6]$ git pull
> fatal: unexpected EOF
> Fetch failure: master.kernel.org:/pub/scm/linux/kernel/git/jejb/scsi-misc-2.6.git

Do you have standard permissions (chmod -R og+rX) on your repo, and, are 
you using rsync to push to kernel.org?

I've attached my rsync-based push script.  git people seem to dislike 
rsync, but this tends to work every time, for all users.

	Jeff



--------------040103030006050702040901
Content-Type: application/x-sh;
 name="push.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="push.sh"

#!/bin/sh

echo Updating server info...
git-update-server-info

echo Uploading...
rsync -e ssh --verbose --delete --stats --progress -az .git/ master.kernel.org:/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git

--------------040103030006050702040901--
