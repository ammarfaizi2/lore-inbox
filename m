Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUC3O53 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUC3O53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:57:29 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:37388 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S263695AbUC3O5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:57:24 -0500
Date: Tue, 30 Mar 2004 16:50:13 +0200
From: DervishD <raul@pleyades.net>
To: Matthew Reppert <repp0017@tc.umn.edu>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
Subject: Re: older kernels + new glibc?
Message-ID: <20040330145013.GD8304@DervishD>
Mail-Followup-To: Matthew Reppert <repp0017@tc.umn.edu>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Lev Lvovsky <lists1@sonous.com>, linux-kernel@vger.kernel.org
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291602340.2893@chaos> <20040329222710.GA8204@DervishD> <1080604519.32741.8.camel@minerva>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1080604519.32741.8.camel@minerva>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Matthew :)

 * Matthew Reppert <repp0017@tc.umn.edu> dixit:
> >     Mmm, I'm confused. As far as I knew, you *should* use symlinks to
> > your current (running) kernel includes for /usr/include/asm and
> > /usr/include/linux. I've been doing this for years (in fact I
> > compiled my libc back in the 2.2 days IIRC), without problems. Why it
> > should be avoided and what kind of problems may arise if someone
> > (like me) has those symlinks?
> See http://www.kernelnewbies.org/faq/index.php3#headers

    Thanks a lot for the information, it's been quite useful :)))

    I find the explanation extremely sensible, but the problem I see
is that some user-space tools that are very coupled with the kernel
(for example, hdparm) assume that the kernel headers can be accessed
throuhg a system standard include directory (like /usr/include). What
I mean is that all these tools just #include <linux/whatever.h>,
without making assumptions about where are they.

    If I've understood correctly, these tools (like hdparm) should
*not* use current (running) kernel headers, but those that were in
use when glibc was built, am I right? Which, BTW, is a big problem
because I don't have the slightest idea about which kernel was in use
when I built my glibc.

    But putting under /usr/include/linux and /usr/include/asm the
headers in use when glibc is built can lead to a problem, too.
Imagine that at some point in the future, the contents of the asm or
linux dirs depends on which facilities the kernel has configured
e.g. no scsi.h if no scsi support is present in the configured
kernel. That way, you don't have scsi.h under your
/usr/include/linux, but you may need it if you add an SCSI card with
your running kernel and want to compile some 'scsiutils' or whatever
like that.

    I confess that this is a very weird scenario, very difficult to
appear but... Just wondering.
 
> The correct place, I've read, to get the headers for the current running
> kernel is /lib/modules/$(uname -r)/build/include

    Please correct me if I'm wrong: only external kernel modules
should use current (running, again) kernel headers, no?    
 
> Basically, the potential problem as I understand it is binary
> incompatibility with the currently installed glibc.

    That has never happened to me, but reading Linus' explanation,
that can bite me in the future (if some interface I use in userspace
changes in the kernel).

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
