Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264562AbUEJJQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264562AbUEJJQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 05:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264579AbUEJJQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 05:16:47 -0400
Received: from se1.ruf.uni-freiburg.de ([132.230.2.221]:64921 "EHLO
	se1.ruf.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264562AbUEJJQn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 05:16:43 -0400
X-Scanned: Mon, 10 May 2004 11:16:08 +0200 Nokia Message Protector V1.3.30 2004040916 - RELEASE
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] SERIO_USERDEV: direct userspace access to mouse/keyboa=
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 10 May 2004 11:16:06 +0200
Message-ID: <xb7d65cskvd.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:

    Andrew> Tuukka Toivonen <tuukkat@ee.oulu.fi> wrote:
    >>  SERIO_USERDEV - Direct serial input device access for
    >> userspace =20 This driver provides direct access from usespace
    >> into PS/2 (or psaux) serial ports used usually for input
    >> devices such as mouses and keyboards=

    Andrew> And given that the external device generates a stream of
    Andrew> bits, the kernel should provide some way for applications
    Andrew> to directly access that stream without the intervening
    Andrew> interpretation.

    Andrew> Is that a decent summary of the situation?

Yeah.  Actually, the external device  generates a stream of BYTES, not
bits.  Byte is  the basic unit.  This makes the PS  AUX port look like
an RS/232 port from the OS's perspective.


    Andrew> If so then yeah, I think the kernel should have a driver
    Andrew> which does all of this.

And   people   can  start   writing   better   (more  features,   with
config. files) userland drivers  for their mouse or non-mouse pointing
devices.    The   drivers  only   need   to   take   the  bytes   from
/dev/misc/isa0060/serio* and/or  /dev/ttyS1, interpret them,  and then
refeed the interpreted  events back to the input  system via 'uinput'.
Maybe, 'gpm' can  be modified to do it.  I can't  see any more reasons
for  writing  those  drivers   in  kernel  (non-swappable,  no  memory
protection, etc.)  space.

BTW, how about USB mice?  Do they export a byte-stream interface?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

