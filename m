Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWBVU6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWBVU6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 15:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWBVU6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 15:58:51 -0500
Received: from uproxy.gmail.com ([66.249.92.204]:7381 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751451AbWBVU6u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 15:58:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=PRPpR3HjnsdFS3FM1Fl1/pxH3B1VjVoVVMwl5Ug8BdAylIH6l6mdsjUZraUO1s6zWbzflbBNjI8+KYW6kUixmlKJD7vWNd3f0StscMFoYaZZhtSt4o5K4jBqjaYB08scPaKxL7kY2wDvWQq1T2UllgW2cPjfzk7+w666Cq1/JDU=
Date: Wed, 22 Feb 2006 21:57:07 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Joel.Becker@oracle.com, gombasg@sztaki.hu, tytso@mit.edu,
       torvalds@osdl.org, kay.sievers@suse.de, penberg@cs.helsinki.fi,
       gregkh@suse.de, bunk@stusta.de, rml@novell.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: 2.6.16-rc4: known regressions
Message-Id: <20060222215707.701669fe.diegocg@gmail.com>
In-Reply-To: <20060222115410.1394ff82.akpm@osdl.org>
References: <20060221225718.GA12480@vrfy.org>
	<20060221153305.5d0b123f.akpm@osdl.org>
	<20060222000429.GB12480@vrfy.org>
	<20060221162104.6b8c35b1.akpm@osdl.org>
	<Pine.LNX.4.64.0602211631310.30245@g5.osdl.org>
	<Pine.LNX.4.64.0602211700580.30245@g5.osdl.org>
	<20060222112158.GB26268@thunk.org>
	<20060222154820.GJ16648@ca-server1.us.oracle.com>
	<20060222162533.GA30316@thunk.org>
	<20060222173354.GJ14447@boogie.lpds.sztaki.hu>
	<20060222185923.GL16648@ca-server1.us.oracle.com>
	<20060222115410.1394ff82.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.8.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 22 Feb 2006 11:54:10 -0800,
Andrew Morton <akpm@osdl.org> escribió:

> Yes, I tend to think that insmod should just block until all devices are
> ready to be used.  insmod doesn't just "insert a module".  It runs that
> module's init function.

However, in current systems a device is ready only iff the corresponding
sysfs tree has been created or a hotplug event has be launched, and that's
the one sane place where userspace can wait for "something". Drivers need to
setup the name of the sysfs classes, so if modules could <crack smoking> 
export some of that info to insmod maybe insmod could be taught to do wait
for things in userspace or wait for events coming from the $FOO.ko module

(ok, maybe ugly but sounds somewhat cleaner than just adding a
"sleep(magicnumber)" to insmod)
