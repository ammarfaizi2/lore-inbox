Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbWARMM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbWARMM3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 07:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWARMM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 07:12:29 -0500
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:1540 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1030270AbWARMM2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 07:12:28 -0500
Date: Wed, 18 Jan 2006 13:13:04 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Eyal Lebedinsky <eyal@eyal.emu.id.au>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-Id: <20060118131304.23088492.khali@linux-fr.org>
In-Reply-To: <20060118091543.GA8277@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	<43CD67AE.9030501@eyal.emu.id.au>
	<20060117232701.GA7606@mars.ravnborg.org>
	<20060118085936.4773dd77.khali@linux-fr.org>
	<20060118091543.GA8277@mars.ravnborg.org>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

> The shell script check-dialog.sh is called which again do:
> echo "main() {}" | gcc -xc - -o /dev/null
> 
> And it seems that gcc will trash /dev/null in your setup when doing
> this.
> One fix would be to avoid the two lines during distclean,
> but I may have to resort to a temporary file.
> 
> Could you please confirm that the above command is the one that trashes
> /dev/null, then I will try to cook up something better.

I confirm that this one line is causing the trouble:

root@arrakis:~> ls -l /dev/null
crw-rw-rw-  1 root root 1, 3 2006-01-18 13:34 /dev/null
root@arrakis:~> echo "main() {}" | gcc -xc - -o /dev/null
root@arrakis:~> ls -l /dev/null
crwxrwxrwx  1 root root 1, 3 2006-01-18 13:34 /dev/null
root@arrakis:~> 

This is with both gcc 3.3.6 from Slackware 10.2 and gcc 4.0.2 from Suse
10.0. Didn't try with self-compiled gcc versions on these systems.

BTW, I have noticed recently an "a.out" file at the root of my linux
sources tree when I build a kernel.

-rwxr-xr-x   1 khali users  11K 2006-01-16 19:51 a.out*

Running it doesn't seem to do anything useful. Is this file generated
here on purpose? Is it somehow related to the current issue?

Thanks,
-- 
Jean Delvare
