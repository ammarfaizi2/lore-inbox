Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261340AbSIZQAY>; Thu, 26 Sep 2002 12:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261352AbSIZQAY>; Thu, 26 Sep 2002 12:00:24 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:59897
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261340AbSIZQAX>; Thu, 26 Sep 2002 12:00:23 -0400
Subject: Re: [PATCH][RFC] oprofile 2.5.38 patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Levon <movement@marcelothewonderpenguin.com>
Cc: linux-kernel@vger.kernel.org, bobm@fc.hp.com, phil.el@wanadoo.fr,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020923222933.GA33523@compsoc.man.ac.uk>
References: <20020923222933.GA33523@compsoc.man.ac.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 17:08:29 +0100
Message-Id: <1033056509.11848.61.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok comments


Security:
enable_write with a count of 0xFFFFFFFF again repeated everywhere

Major
The buffer_read function doesnt seem to be SMP safe
Doesnt seem to know about Intel pmc errata
Assumes it will get PM notifiers reliably (it wont)

Minor
Massive duplication of code in each read/write handler - build some
helpers which actually do the thing right and you'd also have less bugs
cpu_type_read doesnt handle partial read
cpu_type_read scribbles on more data than the user requested
 (fun to feed as stdin to a setuid app)
similar errors permeate the rest of that code

Trivial
In the event of an -EFAULT data is lost (nothing illegal about it)


Basically its a nice prototype, but with the prototype working could do
with some auditing and a cleanup. I think if you replace all the
read/write functions with some clean helpers and fix the messes in the
helpers it'll clean up really nicely


