Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTA0QbA>; Mon, 27 Jan 2003 11:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267228AbTA0QbA>; Mon, 27 Jan 2003 11:31:00 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:15564 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267227AbTA0Qa7>; Mon, 27 Jan 2003 11:30:59 -0500
Date: Mon, 27 Jan 2003 10:39:45 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: David Woodhouse <dwmw2@infradead.org>
cc: Christian Zander <zander@minion.de>, Mark Fasheh <mark.fasheh@oracle.com>,
       Thomas Schlichter <schlicht@uni-mannheim.de>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Sam Ravnborg <sam@ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: no version magic, tainting kernel. 
In-Reply-To: <8626.1043684963@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0301271033510.18686-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, David Woodhouse wrote:

> Er, I think O_TARGET is in fact the target _module_ name when building
> a file system as a module. Try removing O_TARGET from 2.4 fs/ext2/Makefile
> and building ext2 as a module.

Well, okay, there's two ways you can build a single module in a directory 
in 2.4, one is to have

	O_TARGET := module.o
	obj-m    := $(O_TARGET)

	obj-y    := part1.o part2.o

The other is

	O_TARGET := something.o
	obj-m    := module.o

	module-objs := part1.o part2.o

(plus a link rule for module.o)

In 2.5, only the second way is legal, so if you're aiming for a compatible 
Makefile, you'd use that one, and then O_TARGET shouldn't matter for 
"make modules".

--Kai




