Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280034AbRKITRt>; Fri, 9 Nov 2001 14:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280033AbRKITRb>; Fri, 9 Nov 2001 14:17:31 -0500
Received: from [195.66.192.167] ([195.66.192.167]:28690 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S280031AbRKITRT>; Fri, 9 Nov 2001 14:17:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
Subject: Re: [PATCH] Adding KERN_INFO to some printks
Date: Fri, 9 Nov 2001 21:17:00 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.40.0111091200310.2020-100000@filesrv1.baby-dragons.com>
In-Reply-To: <Pine.LNX.4.40.0111091200310.2020-100000@filesrv1.baby-dragons.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01110921170000.00807@nemo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 09 November 2001 17:02, 
"Mr. James W. Laferriere" <babydr@baby-dragons.com> wrote:

> Hello Vda ,  Would you share your /etc/syslog.conf  file ?
> 	I'd really like to see Good example of one .  Most of the docs
> 	describe what all the options do ,  But don't show how they relate
> 	in the config file .  Tia ,  JimL
>
> > I configured my syslog to sort all kernel msgs to
> > /var/log/syslog.N.debug|info|notice|warn|... (you got the idea)
> > and made it spew everything on tty12, and warnings only to tty11.
> >
> > I got tired of seeing purely informative messages on tty11 every
> > boot. They shouldn't be there.

# /etc/syslog.conf
#
# Message proirities:
# debug info notice warning err crit alert emerg

*.debug			/var/log/syslog.7.debug
*.info			/var/log/syslog.6.info
*.notice		/var/log/syslog.5.notice
*.warn			/var/log/syslog.4.warn
*.err			/var/log/syslog.3.err
*.crit			/var/log/syslog.2.crit
*.alert			/var/log/syslog.1.alert
*.emerg			/var/log/syslog.0.emerg

# >= crit: these will go to console too
# vda: had to comment it out: was dying on SAK 'coz held /dev/console open
# I hope syslogd maintainer will someday read this...
##*.crit			/dev/console

# Log everything on 12th console, log 'serious' things on 11th
*.*			/dev/tty12
*.warn			/dev/tty11

#
# This might work instead to log on a remote host:
# *.*			@hostname
