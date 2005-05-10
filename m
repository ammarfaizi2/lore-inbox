Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVEJM6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVEJM6e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 08:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261633AbVEJM6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 08:58:33 -0400
Received: from relay3.usu.ru ([194.226.235.17]:42407 "EHLO relay3.usu.ru")
	by vger.kernel.org with ESMTP id S261632AbVEJM6b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 08:58:31 -0400
Message-ID: <4280AFF4.6080108@ums.usu.ru>
Date: Tue, 10 May 2005 18:58:28 +0600
From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marco d'Itri" <md@Linux.IT>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Greg KH <gregkh@suse.de>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] hotplug-ng 002 release
References: <20050506212227.GA24066@kroah.com> <1115611034.14447.11.camel@localhost.localdomain> <20050509232103.GA24238@suse.de> <1115717357.10222.1.camel@localhost.localdomain> <20050510094339.GC6346@wonderland.linux.it>
In-Reply-To: <20050510094339.GC6346@wonderland.linux.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.30.0.12; VDF: 6.30.0.168; host: usu2.usu.ru)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco d'Itri wrote:

>On May 10, Rusty Russell <rusty@rustcorp.com.au> wrote:
>
>  
>
>>So I rewrote it yesterday, so now it passes the testsuite.  I also added
>>a test.  It's in 3.2-pre4: if there are no more requests/bugs in the
>>next couple of days, I'll make that 3.3.
>>    
>>
>My major request is support for /etc/hotplug/blacklist.d/ in modprobe:
>now that the hotplug subsystem does not know anymore the name of the
>module to be loaded, it's up to modprobe to check the system blacklist.
>IME, without this feature users will not accept hotplug-ng.
>  
>
Why not this or something similar (e.g. I want to blacklist the xxx and 
yyy modules)? (note, untested)

in /etc/modprobe.d/hotplug_blacklist:

install xxx /sbin/blacklisted xxx
install yyy /sbin/blacklisted yyy

In /sbin/blacklisted:

#!/bin/sh
if [ -z "$SEQNUM" ] ; then
    /sbin/modprobe -i "$@"
else
    exit 1
fi

Any other variable that is certainly present in hotplug events will also 
work instead of $SEQNUM.

-- 
Alexander E. Patrakov

