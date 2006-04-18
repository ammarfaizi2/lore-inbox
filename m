Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWDRUNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWDRUNj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932311AbWDRUNj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:13:39 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:35720 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S932309AbWDRUNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:13:38 -0400
Message-ID: <4445484F.1050006@novell.com>
Date: Tue, 18 Apr 2006 13:13:03 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>,
       James Morris <jmorris@namei.org>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Stephen Smalley <sds@tycho.nsa.gov>,
       T?r?k Edwin <edwin@gurde.com>, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
References: <200604021240.21290.edwin@gurde.com> <200604072138.35201.edwin@gurde.com> <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil> <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com>            <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
In-Reply-To: <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> If we heave the LSM stuff overboard, there's one thing that *will* need
> addressing - what to do with kernel support of Posix-y capabilities.  Currently
> some of the heavy lifting is done by security/commoncap.c.
>
> Frankly, that's *another* thing that we need to either *fix* so it works right,
> or rip out of the kernel entirely.  As far as I know, there's no in-tree way
> to make /usr/bin/ping be set-CAP_NET_RAW and have it DTRT.
>   
This has actually been one of the interesting developments in AppArmor.
I also had no use for POSIX.1e capabilities; I thought they were so
awkward as to be useless. That is, until we integrated capabilities into
AppArmor profiles.

Consider this profile for /bin/stty
/bin/stty {
  #include <abstractions/base>

  capability sys_tty_config,

  /bin/stty r,
}

This policy basically allows stty to run, read its own text file, and
use the capability sys_tty_config. Even though it may run as root, this
profile confines it to *only* have sys_tty_config.

This gives the system administrator the ability to force applications to
"drop" privs even when the application developer didn't bother, or (as
was the case in a Sendmail vulnerability several years ago) the
application *tried* to drop privs and got it wrong, so was running as
full root anyway.

Capabilities are very easy and natural to use in an AppArmor system. And
they don't require any upstream filesystem support. SELinux provides
similar support for Capabilities, so they are worth keeping even without
upstream filesystem support.

Crispin

-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

