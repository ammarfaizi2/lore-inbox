Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWARRZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWARRZs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 12:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWARRZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 12:25:48 -0500
Received: from spooner.celestial.com ([192.136.111.35]:53122 "EHLO
	spooner.celestial.com") by vger.kernel.org with ESMTP
	id S1751392AbWARRZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 12:25:48 -0500
Date: Wed, 18 Jan 2006 05:01:33 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
Message-ID: <20060118100133.GE6980@kurtwerks.com>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org> <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060118091543.GA8277@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.16-rc1krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2006 at 10:15:43AM +0100, Sam Ravnborg took 0 lines to write:

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

Seems to be okay here with both gcc 3.4.4 and gcc 4.0.2:

[~]$ ls -l /dev/null
crw-rw-rw-  1 root sys 1, 3 1994-07-17 19:46 /dev/null
[~]$ echo "main() {}" | gcc -xc - -o /dev/null
[~]$ gcc -v
Reading specs from /usr/lib/gcc/x86_64-slackware-linux/3.4.4/specs
Configured with: ../gcc-3.4.4/configure --prefix=/usr --enable-shared
--enable-threads=posix --enable-__cxa_atexit --disable-checking
--with-gnu-ld --verbose --target=x86_64-slackware-linux
--host=x86_64-slackware-linux
Thread model: posix
gcc version 3.4.4
[~]$ ls -l /dev/null
crw-rw-rw-  1 root sys 1, 3 1994-07-17 19:46 /dev/null
[~]$ echo "main() {}" | /usr/local/gcc4/bin/gcc -xc - -o /dev/null
[~]$ /usr/local/gcc4/bin/gcc -v
Using built-in specs.
Target: x86_64-slackware-linux
Configured with: ../gcc-4.0.2/configure --prefix=/usr/local/gcc4
--enable-shared --enable-threads=posix --enable-__cxa_atexit
--disable-checking --with-gn-ld --verbose
--target=x86_64-slackware-linux --host=x86_64-slackware-linux
Thread model: posix
gcc version 4.0.2
[~]$ ls -l /dev/null
crw-rw-rw-  1 root sys 1, 3 1994-07-17 19:46 /dev/null

Kurt
-- 
"The National Association of Theater Concessionaires reported that in
1986, 60% of all candy sold in movie theaters was sold to Roger Ebert."
	-- D. Letterman
