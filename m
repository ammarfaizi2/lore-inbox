Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUKBWW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUKBWW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 17:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUKBWOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 17:14:16 -0500
Received: from zeus.kernel.org ([204.152.189.113]:41438 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262020AbUKBWJq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 17:09:46 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Daniel Egger <degger@fhm.edu>,
       Linux Mailing List Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.8 and 2.6.9 Dual Opteron glitches
Date: Tue, 2 Nov 2004 15:56:28 -0600
X-Mailer: KMail [version 1.2]
References: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu>
In-Reply-To: <5AC1EEB8-2CD7-11D9-BF00-000A958E35DC@fhm.edu>
MIME-Version: 1.0
Message-Id: <04110215562800.15809@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 November 2004 07:59, Daniel Egger wrote:
>
>
> 2) 64 bit kernel vgettimeofday panic: The kernel panics in
>     arch/x64_64/vsyscall.c:169 on boot.
>
>    static int __init vsyscall_init(void)
>    {
>            if ((unsigned long) &vgettimeofday !=
> VSYSCALL_ADDR(__NR_vgettimeofday))
>                    panic("vgettimeofday link addr broken");
>
>    Replacing those panic(s) by printk make the machine boot just fine
>    and also work (seemingly) without any problems under load.
>

This may be all wet but....
>            if ((unsigned long) &vgettimeofday !=
                     ^^^^ this is a 32 bit value
> VSYSCALL_ADDR(__NR_vgettimeofday))
  ^^^^^^^^^^^^ and I think this is a 64 bit value.
>                    panic("vgettimeofday link addr broken");

And elevating an unsigned 32 bit to 64 will not match under any circumstances.

Bet it would work if "(unsigned long)" were "(void *)"
