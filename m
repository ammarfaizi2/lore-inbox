Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315167AbSHARfN>; Thu, 1 Aug 2002 13:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316161AbSHARfN>; Thu, 1 Aug 2002 13:35:13 -0400
Received: from chaos.analogic.com ([204.178.40.224]:17283 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S315167AbSHARfK>; Thu, 1 Aug 2002 13:35:10 -0400
Date: Thu, 1 Aug 2002 13:38:57 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, stas.orel@mailcity.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
In-Reply-To: <3D496A24.4E134ED5@daimi.au.dk>
Message-ID: <Pine.LNX.3.95.1020801132809.27785B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2002, Kasper Dupont wrote:
[SNIPPED...]

> want to run it in virtual 86 mode. Thanks to emm386 we probably don't
> see many DOS programs not working in virtual 86 mode, but emm386 itself
> plain refuses to load in virtual 86 mode.
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

But of course! It's a 32-bit 'trap program', they runs your whole
computer in VM86 mode, paging in memory from above 1 megabyte to
some 'window' below 1 megabyte.

Any attempt to load it cause a trap to Linux when the PE bit is
attempted to be set.

You don't need emm386 because Linux emulates its functionality.
For instance, here is my CONFIG.EMU (like CONFIG.SYS) when VM86
boots DOS on one of my Linux machines.

Note all the wonderful load-high commands.


BUFFERS=16,0
FILES=20
DOS=UMB
LASTDRIVE=F
FCBS=6,0
[menu]
menuitem=BRADLEYNE,  Start the TCP/IP Network  (NE* Bradley's code)
menuitem=TCPIP,      Start the TCP/IP Network  (3COM Board PCTCP)
menuitem=BRADLEY,    Start the TCP/IP Network  (3COM Board ANALOGIC)
menuitem=NDIS_ONLY,  Load NDIS driver only     (3COM Board)
menuitem=NO_NETWORK, Do not load any network
menuitem=NO_AUTOEXEC, Do not execute any AUTOEXEC.BAT commands
menuitem=DO_HOST, Start RCCS Host Software
menucolor=7,1
menudefault=NO_NETWORK, 4

[SETUP]
DOS=HIGH
STACKS=0,0
BREAK=ON
Rem DEVICE=C:\DOS\SETVER.EXE
SHELL=C:\DOS\COMMAND.COM C:\DOS\ /E:768 /p

[LINUX]
INSTALL=C:\JBOOT\JBOOT.COM C:\JBOOT\VMLINUX

[TCPIP]
INCLUDE=SETUP
DEVICE=C:\USNET\PROTMAN.SYS /I:C:\3COM
DEVICE=C:\3COM\EL90X.DOS
Rem DEVICE=C:\3COM\EL59X.DOS
DEVICE=C:\USNET\BRADLEY.SYS
INSTALL=C:\USNET\NETBIND.EXE
DEVICE=C:\PCTCP\DIS_PKT.GUP
Set TCPIP=TRUE

[DO_HOST]
INCLUDE=SETUP
DEVICE=C:\USNET\PROTMAN.SYS /I:C:\3COM
DEVICE=C:\3COM\EL90X.DOS
DEVICE=C:\USNET\BRADLEY.SYS
INSTALL=C:\USNET\NETBIND.EXE
DEVICE=C:\PCTCP\DIS_PKT.GUP
Set PCTCP=C:\PCTCP\PCTCP.INI
Set FTP_ETC=C:\PCTCP
Set COMSPEC=C:\DOS\COMMAND.COM
Set DEBUG=C:\DOS\DEBUG.EXE
Set PATH=C:\DOS
INSTALL=C:\PCTCP\ETHDRV.EXE
INSTALL=D:\PROJECT\HOSTSYS\HOST\TCPIP.EXE
Set RELOAD=TRUE

[BRADLEY]
INCLUDE=SETUP
DEVICE=C:\USNET\PROTMAN.SYS /I:C:\3COM
DEVICEHIGH /L:1,43648 =C:\3COM\EL90X.DOS
DEVICEHIGH /L:2,800 =C:\USNET\BRADLEY.SYS
INSTALL=C:\USNET\NETBIND.EXE
Set BRADLEY=TRUE

[BRADLEYNE]
INCLUDE=SETUP
DEVICE=C:\USNET\PROTMAN.SYS /I:C:\NETCARD
DEVICE=C:\NETCARD\LM8634.DOS
DEVICE=C:\USNET\BRADLEY.SYS
INSTALL=C:\USNET\NETBIND.EXE
Set BRADLEY=TRUE

[NDIS_ONLY]
INCLUDE=SETUP
DEVICE=C:\USNET\PROTMAN.SYS /I:C:\3COM
Rem DEVICE=C:\3COM\EL59X.DOS
DEVICE=C:\3COM\EL90X.DOS
DEVICE=C:\USNET\BRADLEY.SYS
INSTALL=C:\USNET\NETBIND.EXE

[NO_NETWORK]
INCLUDE=SETUP

[NO_AUTOEXEC]
INCLUDE=SETUP
Set AUTO=FALSE

[DRIVER]
INCLUDE=SETUP
DEVICE=E:\DRIVER\COMLINK.BIN

[common]








Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.

