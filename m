Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S133053AbQK0AP7>; Sun, 26 Nov 2000 19:15:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S133082AbQK0APt>; Sun, 26 Nov 2000 19:15:49 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:38271 "EHLO
        pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
        id <S133053AbQK0APl>; Sun, 26 Nov 2000 19:15:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: initdata for modules? 
In-Reply-To: Your message of "Sun, 26 Nov 2000 17:01:35 PDT."
             <20001126170135.A1787@vger.timpanogas.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 27 Nov 2000 10:45:34 +1100
Message-ID: <1887.975282334@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2000 17:01:35 -0700, 
"Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
>insmod ppp_deflate (should trigger load of all these modules).  I 
>know it's works this way if there's a modules.dep file laying 
>around, but it would be nice for it to work this way without 
>needing the external text file.

There is a clean split between modprobe and insmod, modprobe is the
high level command that does all the fancy checking for inter module
dependencies, handling aliases and extracting options from
modules.conf.  insmod is the low level command that does exactly what
you tell it to do, no more, no less.  The only smarts that insmod has
is the ability to take a module name without '/' and find it using the
patchs in modules.conf.  That split between high and low level commands
is too useful to contaminate.

modules.conf already supports "above" and "below" commands for
non-standard dependencies.  The problem of not having a module.dep on
the first boot of a new kernel was addressed in kernel 2.4.0-test5 or
thereabouts, make modules_install runs depmod to build modules.dep
ready for the first boot.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
