Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUFCFyk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUFCFyk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 01:54:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265512AbUFCFyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 01:54:39 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:13552 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265510AbUFCFyg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 01:54:36 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Andries Brouwer <aeb@cwi.nl>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] serio.c: dynamically control serio ports bindings via procfs (Was: [RFC/RFT] Raw access to serio ports)
References: <20040602190927.79289.qmail@web81306.mail.yahoo.com>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
In-Reply-To: <20040602190927.79289.qmail@web81306.mail.yahoo.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 03 Jun 2004 07:54:33 +0200
Message-ID: <xb7smdd425i.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:

    Dmitry> Let me start with saying that this is a very good patch
    Dmitry> and that is exactly what I have in mind with regard to
    Dmitry> serio port/device binding.  The only problem with the
    Dmitry> patch is that it uses wrong foundation, namely procfs,
    Dmitry> because:
    ...
 
    Dmitry> So we have several options - if we adopt procfs based
    Dmitry> solution now we will have to maintain it for very long
    Dmitry> time, along with competing sysfs implementation. Dropping
    Dmitry> one kernel parameter which will never be widely used is
    Dmitry> much easier, IMO.

It's not just the matter of dropping one kernel parameter.  The procfs
support, _already  implemented_, allows  one to fine-tune  the binding
between serio  ports and  devices, which is  a new and  useful feature
that  your kernel  parameter  doesn't provide.   

Can you unbind the keyboard port?   Can you bind/unbind any of the AUX
ports  *dynamically*  without   reloading  the  i8042  module?   These
functionalities are  already there in the serio-related  code.  Just a
userland interface is missing.  My patch is to fill this gap.



    Dmitry> So I propose we all join our ranks and tame that sysfs
    Dmitry> together ;) I had some patches that were converting
    Dmitry> drivers to the sysfs adding them to serio bus, 

sysfs  looks  good  for  simple parameters:  integers,  strings.   For
anything more  complicated (sets, graphs),  I don't see it  fit (yet).
Unfortunately, the serio port<-->device relation is already a graph (1
to n).

I'd like  to see  how you implement  the device<-->handler  binding in
input.c using sysfs.  It'd be a nice feature.  Imagine how annoying it
is for 'evbug' to report your keypresses, when you're just debugging a
mouse driver.   Being able to adjust the  device<-->handler binding is
what I  want.  I don't  care whether it's  a procfs approach  or sysfs
approach, as long as it is  reasonably useable.  (You could even do it
with ioctl(), if you provide a  nice command line tool so that I don't
need  to care about  the ioctl  parameters.)  I'm  not going  to touch
input.c,  because  I  don't  want   to  reboot  everytime  to  test  a
modification.  It's hard to compile input.c as a module.



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

