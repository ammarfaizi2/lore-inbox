Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTD3Uzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 16:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTD3Uzx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 16:55:53 -0400
Received: from air-2.osdl.org ([65.172.181.6]:34989 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262422AbTD3Uzv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 16:55:51 -0400
Date: Wed, 30 Apr 2003 14:05:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: rusty@rustcorp.com.au
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Loading a module multtiple times
Message-Id: <20030430140557.12e13f1a.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rusty-

I was looking into a bug in /proc/net/dev truncated output.
/proc/net/dev lists {if (!buggy)} all loaded network interfaces.

To get a large number of network interfaces, Christian (below)
told me to copy driver/net/dummy.o to several different file names
and then insmod them.  It seems to have worked for him, and it works
that way in 2.4.recent, but it's not working for me.  See error
messages below.

Which way is expected behavior?
What should be the expected behavior?
or am I just seeing bugs (failures) that noone else sees?

It seems like not supporting this is likely to cause some problems.

Thanks,
~Randy


(was: [BUG 2.5.67 (and probably earlier)] /proc/dev/net doesnt show all net devices)

On Wed, 30 Apr 2003 09:11:11 +0200 Christian Bornträger <linux@borntraeger.net> wrote:


| > How do I configure the dummy network driver to get loads of interfaces?
| 
| Just copy the dummy.o to dummy1.o dummy2.o dummy3.o,  insmod and ifconfig 
| them.

Doesn't work for me.  insmod (from ver. 0.9.11a module-init-tools)
won't load multiple copies of dummy[n].o or dummy[n].ko.
(with dummy already loaded)

For the .o files, it says:
  dummy: no version magic, tainting kernel.
  Error inserting 'dummy1.o': -1 File exists

and for the .ko files, it says:
  Error inserting 'dummy1.ko': -1 File exists
---
