Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030224AbWARLYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030224AbWARLYO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 06:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbWARLYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 06:24:14 -0500
Received: from ihug-mail.icp-qv1-irony1.iinet.net.au ([203.59.1.195]:57860
	"EHLO mail-ihug.icp-qv1-irony1.iinet.net.au") by vger.kernel.org
	with ESMTP id S1030224AbWARLYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 06:24:13 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
Message-ID: <43CE2556.9070700@eyal.emu.id.au>
Date: Wed, 18 Jan 2006 22:24:06 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Debian Thunderbird 1.0.2 (X11/20051002)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: Jean Delvare <khali@linux-fr.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.16-rc1
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org> <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org> <20060118085936.4773dd77.khali@linux-fr.org> <20060118091543.GA8277@mars.ravnborg.org>
In-Reply-To: <20060118091543.GA8277@mars.ravnborg.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Could you please confirm that the above command is the one that trashes
> /dev/null, then I will try to cook up something better.

scripts/kconfig/lxdialog/check-lxdialog.sh with debug
=====================================================

ldflags()
{
echo "ldflags 1" >>/tmp/xxx 2>&1
ls -l /dev/null >>/tmp/xxx 2>&1
        echo "main() {}" | $cc -lncursesw -xc - -o /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
echo "ldflags 2" >>/tmp/xxx 2>&1
ls -l /dev/null >>/tmp/xxx 2>&1
                echo '-lncursesw'
                exit
        fi
echo "ldflags 3" >>/tmp/xxx 2>&1
ls -l /dev/null >>/tmp/xxx 2>&1
        echo "main() {}" | $cc -lncurses -xc - -o /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
echo "ldflags 4" >>/tmp/xxx 2>&1
ls -l /dev/null >>/tmp/xxx 2>&1
                echo '-lncurses'
                exit
        fi
echo "ldflags 5" >>/tmp/xxx 2>&1
ls -l /dev/null >>/tmp/xxx 2>&1
        echo "main() {}" | $cc -lcurses -xc - -o /dev/null 2> /dev/null
        if [ $? -eq 0 ]; then
echo "ldflags 6" >>/tmp/xxx 2>&1
ls -l /dev/null >>/tmp/xxx 2>&1
                echo '-lcurses'
                exit
        fi
echo "ldflags 7" >>/tmp/xxx 2>&1
ls -l /dev/null >>/tmp/xxx 2>&1
        exit 1
}


content of /tmp/xxx
===================

ldflags 1
crw-rw-rw-  1 root root 1, 3 Jan 18 22:20 /dev/null
ldflags 3
ls: /dev/null: No such file or directory
ldflags 4
-rwxr-xr-x  1 root root 11650 Jan 18 22:20 /dev/null

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	attach .zip as .dat
