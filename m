Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750996AbWDWDvD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996AbWDWDvD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 23:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWDWDvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 23:51:01 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:13520 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1750985AbWDWDvA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 23:51:00 -0400
Message-ID: <444AF977.5050201@novell.com>
Date: Sat, 22 Apr 2006 20:50:15 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Valdis.Kletnieks@vt.edu, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
References: <200604142301.10188.edwin@gurde.com> <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil> <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei> <20060417195146.GA8875@kroah.com> <1145309184.14497.1.camel@localhost.localdomain> <200604180229.k3I2TXXA017777@turing-police.cc.vt.edu> <4445484F.1050006@novell.com> <20060420211308.GB2360@ucw.cz>
In-Reply-To: <20060420211308.GB2360@ucw.cz>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> On Tue 18-04-06 13:13:03, Crispin Cowan wrote:
>   
>> This has actually been one of the interesting developments in AppArmor.
>> I also had no use for POSIX.1e capabilities; I thought they were so
>> awkward as to be useless. That is, until we integrated capabilities into
>> AppArmor profiles.
>>
>> Consider this profile for /bin/stty
>> /bin/stty {
>>   #include <abstractions/base>
>>
>>   capability sys_tty_config,
>>
>>   /bin/stty r,
>> }
>>
>> This policy basically allows stty to run, read its own text file, and
>> use the capability sys_tty_config. Even though it may run as root, this
>> profile confines it to *only* have sys_tty_config.
>>     
> What happens if I ln /bin/stty /tmp/evilstty, then exploit
> vulnerability in stty? 
>   
Two things:

   1. You don't get to create such a link unless you have an unconfined
      (trusted) shell or you have a policy that says you get to create
      such a link, and
   2. You don't have permission to execute /tmp/evilstty at all, unless
      you have an unconfined (trusted) shell.

This is a really basic misunderstanding of AppArmor. All unconfined
processes are considered trusted, so attacks that suppose an unconfined
user did something very evil/stupid are not interesting. An AppArmor
policy is supposed to prevent the attacker from ever obtaining control
of an unconfined process, so just assuming that you have one doesn't
demonstrate breaking the model.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

