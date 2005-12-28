Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932481AbVL1FmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932481AbVL1FmR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 00:42:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVL1FmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 00:42:17 -0500
Received: from zproxy.gmail.com ([64.233.162.192]:62574 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932481AbVL1FmR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 00:42:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Bwrio/s2tsdBqIIyec1YC5c16br8JjJULwHL84id7ECmKeSF7GLKOPcsVtrSk7uCzP4/jhBKoAhpA7mpmlAzIWKNZQlBq5PzUFSwf6gT0zpyka6G1iqCorESvOEEUZ2spY0YijrIQ0KpWkRl1RQIVLCbJblZv6iALZ6iCmMKVDI=
Message-ID: <37d33d830512272142i64a7fc7cm390d24e1043f4f1c@mail.gmail.com>
Date: Wed, 28 Dec 2005 11:12:15 +0530
From: Sandeep Kumar <sandeepksinha@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: problem with e_entry and _start
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
I am trying to overwrite the e_entry on an executable's elf header and
change the flow of control with the following piece of code :


               Elf32_Ehdr *self = (Elf32_Ehdr *)0x8048000;
               printf("%x",(self)->e_entry);
               (self)->e_entry = (Elf32_Addr)0x00000000;


This piece of code is present in a pre loaaded shared library.


But the problem is that even after changing the address of the
e_entry, the actual main function of the executable a.out is getting
executed. BUt if the address of this e_entry is getting changed then
how the control is finally reaching _lib_start_main and finally to
main().
I tried overwriting it with 0x0000000 still it worked.


The command given for execution is :


#LD_PRELOAD="./lib1.so" ./a.out


Where does the loader takes the address of _start before passing
control to it ?
please help !


--
Regards,
Sandeep
