Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267697AbUBTC2w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267702AbUBTC2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:28:52 -0500
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:33695 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S267697AbUBTC2u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:28:50 -0500
X-Analyze: Velop Mail Shield v0.0.3
Date: Thu, 19 Feb 2004 23:28:47 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net
Subject: Re: HOWTO use udev to manage /dev
In-Reply-To: <20040220015433.GC3134@kroah.com>
Message-ID: <Pine.LNX.4.58.0402192306110.694@pervalidus.dyndns.org>
References: <20040219185932.GA10527@kroah.com> <20040219191636.GC10527@kroah.com>
 <Pine.LNX.4.58.0402191918440.688@pervalidus.dyndns.org> <20040219230749.GA15848@kroah.com>
 <Pine.LNX.4.58.0402192033490.694@pervalidus.dyndns.org> <20040219235602.GI15848@kroah.com>
 <Pine.LNX.4.58.0402192057590.694@pervalidus.dyndns.org> <20040220015433.GC3134@kroah.com>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004, Greg KH wrote:

> On Thu, Feb 19, 2004 at 09:51:52PM -0300, Frédéric L. W. Meunier wrote:
> > On Thu, 19 Feb 2004, Greg KH wrote:
> >
> > > How about changing the #!/bin/bash to #!/bin/sash in the
> > > first line for the start_udev script?
> >
> > I didn't have it, but compiled and changed. Yes, it works.
>
> > OK, I'll later boot with it and see if it works. If it does,
> > I'll run strace with the other.
>
> How about using sash?  That is statically linked.

As I reported, it works with it.

> > I forgot to run it, but noticed there was a /dev/null, but
> > a text file (0644). And I didn't create it anywhere.

> That sounds like some program is trying to write to it.

I bet it was fsck. It was the last to run before sulogin.

> Hm, there is a patch in the Red Hat version of udev that basically makes
> udev do the start_udev logic, in the .c file because they do not have a
> shell in their initrd.  If you can dig it out of there, that might be a
> solution for you to use.

Sounds good to get rid of the script. I'll see.

> Other than that, how about running strace on start_udev when your rc.S
> script calls it?  That might help out.

I did it, and guess what, it worked.

-[ ! -e /dev/.devfsd -a -d /sys/block ] && /etc/rc.d/start_udev
+[ ! -e /dev/.devfsd -a -d /sys/block ] && strace -o /tmp/udev.txt /etc/rc.d/start_udev

-- 
http://www.pervalidus.net/contact.html
