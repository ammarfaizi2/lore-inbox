Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263893AbTLOSAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 13:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTLOSAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 13:00:55 -0500
Received: from chaos.analogic.com ([204.178.40.224]:25474 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263893AbTLOSAv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 13:00:51 -0500
Date: Mon, 15 Dec 2003 13:03:05 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: Vladimir Kondratiev <vladimir.kondratiev@intel.com>,
       "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Mares <mj@ucw.cz>
Subject: Re: PCI Express support for 2.4 kernel
In-Reply-To: <20031215170843.GA10857@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.53.0312151258550.14778@chaos>
References: <Pine.LNX.4.44.0312150917170.32061-100000@coffee.psychology.mcmaster.ca>
 <3FDDD8C6.3080804@intel.com> <3FDDDC68.80209@backtobasicsmgmt.com>
 <3FDDE39E.1050300@intel.com> <Pine.LNX.4.53.0312151150090.10342@chaos>
 <20031215170843.GA10857@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003, Tomas Szepe wrote:

> On Dec-15 2003, Mon, 11:55 -0500
> Richard B. Johnson <root@chaos.analogic.com> wrote:
>
> > Easy way to remember is that if you have either a static or a global
> > variable that is initialized, it will be in the .data segment and,
> > therefore take up space in the executable. If it is not initialized,
> > it will be in the .bss segment, automatically zeroed by the loader.
> > In this case, the executable contains length information, not the data.
> > Local variables are never initialized unless there's an '=' in the
> > code.
>
> I think you guys are all missing Vladimir's point, which is that gcc
> is able to detect that an explicit initialization of a static variable
> happens to be to the value of ZERO, and place the variable in .bss
> _in spite of the initialization_.
>
> --
> Tomas Szepe <szepe@pinerecords.com>
>

Well it doesn't, and if it did, it would be broken. GCC needs to
operate according to some well-defined rules because its output
must interoperate with the object-files created by other versions
including stuff written in other languages.

Therefore you make data exist in the .data segment by initializing
it. If GCC decides to put this initialized data in the .bss segment,
then it is broken. FYI, it doesn't.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


