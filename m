Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315607AbSGFQcu>; Sat, 6 Jul 2002 12:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSGFQct>; Sat, 6 Jul 2002 12:32:49 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:33761 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S315607AbSGFQcs>; Sat, 6 Jul 2002 12:32:48 -0400
Date: Sat, 6 Jul 2002 19:36:10 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: makisara@kai.makisara.local
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Alessandro Suardi <alessandro.suardi@oracle.com>
Subject: Re: 2.5.25 dead kbd and gpm oops (my config error ?)
In-Reply-To: <3D26D705.9000808@oracle.com>
Message-ID: <Pine.LNX.4.44.0207061928140.1712-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 6 Jul 2002, Alessandro Suardi wrote:

> 2.5.25 compiles and boots fine, but keyboard is dead and
>   gpm exits with its own oops() function (not a kernel oops).
>
I lost my keyboard and USB mouse (no gpm running and no oops).

The temporary solution seems to be to leave out the drivers for serial i/o
in input i/o  drivers. There is another keyboard driver unconditionally
included and it conflicts with the new i8042 driver. Here is my input
configuration:

18:41:04> egrep 'INPUT|MOUSE|SERIO|8042' .config | grep -v '^#'
CONFIG_INPUT=y
CONFIG_INPUT_KEYBDEV=y
CONFIG_INPUT_MOUSEDEV=m
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1600
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=1200
CONFIG_INPUT_KEYBOARD=y
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE=y
CONFIG_PSMOUSE=y
CONFIG_USB_HIDINPUT=y
CONFIG_USB_MOUSE=m

I guess this problem will be corrected when the input changes continue.

	Kai


