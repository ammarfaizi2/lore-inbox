Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261698AbTIGMoY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 08:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTIGMoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 08:44:24 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:16913 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S261698AbTIGMoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 08:44:20 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jerome de Vivie <jerome.devivie@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: segfault in ksymoops 
In-reply-to: Your message of "Thu, 04 Sep 2003 23:24:24 +0200."
             <3F57AD88.CC54D482@free.fr> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 07 Sep 2003 22:44:10 +1000
Message-ID: <32694.1062938650@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Sep 2003 23:24:24 +0200, 
Jerome de Vivie <jerome.devivie@free.fr> wrote:
>> I have try ksymoops v2.4.9, v2.4.8 & v2.4.7 and each time i get a
>> segmentation fault. Here's the output: (the oops file is attached).
>#5  0x0804e3d1 in Oops_set_default_ta (me=0x82fd5c8 "./ksymoops",
>ibfd=0x83157f8, options=0xbffff8c0) at oops.c:89
>        procname = "Oops_set_default_ta"
>        bt = 0x736b2f2e <Address 0x736b2f2e out of bounds>
>        bai = (const struct bfd_arch_info *) 0x4008c9a0
>        t = 1
>        a = 1

oops.c::67, the call to bfd_get_target()
        bt = bfd_get_target(ibfd);      /* Bah, undocumented bfd function */
is returning garbage.  Ask the binutils people why this is so.

