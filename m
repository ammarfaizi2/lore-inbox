Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132264AbRCZAsY>; Sun, 25 Mar 2001 19:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132267AbRCZAsN>; Sun, 25 Mar 2001 19:48:13 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:8749 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S132264AbRCZAsA>;
	Sun, 25 Mar 2001 19:48:00 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Stephen Satchell <satch@fluent-access.com>
cc: linas@linas.org, linux-kernel@vger.kernel.org
Subject: Re: mouse problems in 2.4.2 
In-Reply-To: Your message of "Sun, 25 Mar 2001 16:27:37 PST."
             <4.3.2.7.2.20010325162459.00b54620@mail.fluent-access.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Mar 2001 10:47:02 +1000
Message-ID: <12849.985567622@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2001 16:27:37 -0800, 
Stephen Satchell <satch@fluent-access.com> wrote:
>I'm experiencing the same thing with an ASUS P5A-B running a K6-2/266 with 
>Linux 2.2.17, and Windows 98.   Central problem appears to be the KVM 
>switch I'm using. Save yourself the problem.
>
>I had to reboot all the systems to get regular mouse operation back with 
>the Logitech.

I sometimes have keyboard and mouse problems after changing machines
using a mechanical KVM, on a Logitech mouse.  This script fixes it for
me.

/usr/local/bin/switched

#!/bin/sh
/etc/rc.d/init.d/gpm restart
/sbin/kbdrate -r 30

I run gpm in redirect -R mode as
  daemon gpm -t $MOUSETYPE -R -m /dev/ttyS0
and tell X11 to read from /dev/gpmdata as
   Protocol        "MouseSystems"
   Device          "/dev/gpmdata"
not directly from the mouse; the redirect protocol is always
MouseSystems, no matter what the underlying mouse type is.  Restarting
gpm after KVM switch then fixes everything else.

