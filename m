Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132807AbRDQXgy>; Tue, 17 Apr 2001 19:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132853AbRDQXgn>; Tue, 17 Apr 2001 19:36:43 -0400
Received: from t2.redhat.com ([199.183.24.243]:33269 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132807AbRDQXga>; Tue, 17 Apr 2001 19:36:30 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200104172104.RAA08013@mailhost.eng.mc.xerox.com> 
In-Reply-To: <200104172104.RAA08013@mailhost.eng.mc.xerox.com> 
To: "Marty Leisner" <mleisner@eng.mc.xerox.com>
Cc: linux-kernel@vger.kernel.org, leisner@rochester.rr.com
Subject: Re: kernel threads and close method in a device driver 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Apr 2001 00:32:48 +0100
Message-ID: <12080.987550368@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mleisner@eng.mc.xerox.com said:
> The architecture is currently:
> 	open device
> 	do IOCTL (spinning a kernel thread and doing initialization)
> There is currently an IOCTL which short-circuits to the close method.
> Turns out it seems necessary to do this IOCTL -- close never gets
> invoked. 

Your kernel thread is probably sharing filedescriptors with the parent 
process, so although your application closes its copy, because the kernel 
thread hasn't closed its copy, the ->release() method never gets called.

Make sure you're cleaning up properly when starting the kernel thread. See 
how other kernel threads do it. As Andi says, daemonize() is a good start, 
although it's not always sufficient.

--
dwmw2


