Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312772AbSDSSin>; Fri, 19 Apr 2002 14:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312791AbSDSSin>; Fri, 19 Apr 2002 14:38:43 -0400
Received: from relay1.pair.com ([209.68.1.20]:26376 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S312772AbSDSSim>;
	Fri, 19 Apr 2002 14:38:42 -0400
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CC06470.F05543C4@kegel.com>
Date: Fri, 19 Apr 2002 11:39:44 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: printk in init_module mixing with printf in insmod
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded my ppc405 embedded system
from 2.4.2 or so to 2.4.17 or so.  I use modutils-2.4.12.
When I insert a nongpl module, 
the 
  fprintf(stderr, "Warning: loading foo.o will taint kernel\n");
in insmod and the
  printk("Hello, world\n");
in the module are intermixed unpleasantly, yielding output like
    Warning: loHello,ading foo.o world
    will taint kernel

This garbled output makes reading the debugging printk's difficult.

I suppose this isn't terribly important, since printk's are
kind of a no-no in production, and this only affects printk's
in init_module, but it'd be nice to know what
the cleanest way to get rid of the mixing is.  Adding a sleep
inside insmod seems heavyhanded.  I suppose I could redirect
insmod's output to a file, sleep a bit, and then display the 
file... bleah.
- Dan
