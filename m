Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbTELPXA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:23:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbTELPXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:23:00 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:39125 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S262191AbTELPW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:22:59 -0400
Date: Mon, 12 May 2003 17:36:23 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
In-Reply-To: <m1smrl5mbw.fsf@frodo.biederman.org>
Message-ID: <Pine.GSO.3.96.1030512172208.19804B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 2003, Eric W. Biederman wrote:

> There is some software at least that knows the difference.  I have seen short
> jumps in a couple of BIOS's.  But a reset is very different from a
> reboot.  As memory must be reinitialized etc.  So I think going to
> 0xffff0000:0xfff0 would be a very bad idea if the intent is to get a
> reliable reboot.

 You may change a bit in the i8042 controller to make a BIOS assume that's
a cold boot.  The bit is zeroed (IIRC; apply a complement if my memory is
bad) upon a system RESET that's propagated to the i8042 (i.e. a power-on
or a button reset, but not a triple-fault or i8042 output port or port
0x92, etc. one).  The bit is set to one by a BIOS during POST and never
zeroed afterwards, but it's r/w, so there is no problem to clear it if
needed.  This should be quite a reliable way to reboot as a BIOS is
assumed to initialize hardware from scratch (regardless of the reset
vector used). 

 This assumes 100% PC/AT compatibility, of course, which need not be true
these days any longer. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

