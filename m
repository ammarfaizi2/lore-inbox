Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbTIMLi6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 07:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262127AbTIMLi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 07:38:58 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:41401 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262124AbTIMLix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 07:38:53 -0400
Date: Sat, 13 Sep 2003 13:38:51 +0200
From: Axel Siebenwirth <axel@pearbough.net>
To: linux-kernel@vger.kernel.org
Cc: kai.germaschewski@gmx.de
Subject: [BUG] Uninitialised timer! with hisax (2.6.0-test5-bk)
Message-ID: <20030913113851.GA591@neon>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	kai.germaschewski@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: pearbough.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have an AVM Fritz!Card PCI. I have finally got it somehow to work by
compiling i4l and hisax as modules. Before I compiled isdn/hisax in the
kernel and the system got really sluggish after initializing of hisax
drivers.
Loaded the modules and tried sending a pager message with yaps which uses 
ttyI* modem emulation devices.
The kernel reports an Uninitialised timer!

This is happening:

Trying to open /dev/ttyI0 for modem standard
[Hangup]
[Send] <cr>
[Cmd Mdzz 200]
[Send] ATZ<cr>
[Expect] <cr>ATZ<cr><cr><lf>OK got OK
[Send] AT&E776809<cr>
[Expect] <cr><lf>AT&E776809<cr><cr><lf>OK got OK
Using modem standard at 115200 bps, 8n1 over /dev/ttyI0
Trying do dial 01771167
[Send] ATD01771167<cr>get_drv 0: 1 -> 2
HiSax: if_command 5 called with invalid driverId 0!

[Expect] <cr><lf>ATD01771167<cr>put_drv 0: 2 -> 1
<cr><lf>NO CARRIER got NO CARRIER
Unable to dial E+


Messages that appear in dmesg including isdn/hisax loading messages:

ISDN subsystem initialized
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (module)
HiSax: Layer1 Revision 2.41.6.5
HiSax: Layer2 Revision 2.25.6.4
HiSax: TeiMgr Revision 2.17.6.3
HiSax: Layer3 Revision 2.17.6.5
HiSax: LinkLayer Revision 2.51.6.6
HiSax: Approval certification failed because of
HiSax: unauthorized source code changes
hisax_isac: ISAC-S/ISAC-SX ISDN driver v0.1.0
hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1
get_drv 0: 0 -> 1
fcpcipnp0: State ST_DRV_NULL Event EV_DRV_REGISTER
fcpcipnp0: ChangeState ST_DRV_LOADED
HiSax: Card 1 Protocol EDSS1 Id=fcpcipnp0 (0)
HiSax: DSS1 Rev. 2.30.6.2
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
get_drv 0: 1 -> 2
fcpcipnp0: State ST_DRV_LOADED Event EV_STAT_RUN
fcpcipnp0: ChangeState ST_DRV_RUNNING
put_drv 0: 2 -> 1
hisax_fcpcipnp: found adapter Fritz!Card PCI at 0000:02:05.0
isac_version: ISAC version (0): 2086/2186 V1.1
get_drv 0: 1 -> 2
slot (0:0): State ST_SLOT_NULL Event EV_SLOT_BIND
slot (0:0): ChangeState ST_SLOT_BOUND
slot (0:0): State ST_SLOT_BOUND Event EV_CMD_CLREAZ
ISDN_CMD_CLREAZ 0/0
HiSax: if_command 5 called with invalid driverId 0!
Uninitialised timer!
This is just a warning.  Your computer is OK
function=0x00000000, data=0x0
Call Trace:
 [<c012672b>] check_timer_failed+0x63/0x65
 [<c0126a6f>] del_timer+0x1a/0x87
 [<e1ac7d3d>] isdn_tty_modem_result+0x333/0x3e6 [isdn]
 [<c0257477>] end_that_request_last+0x55/0x9d
 [<c0260025>] ide_end_request+0x99/0x146
 [<c0254397>] elv_queue_empty+0x1f/0x21
 [<e1ac9a5f>] isdn_tty_connect_timer+0x0/0x43 [isdn]
 [<e1ac9a90>] isdn_tty_connect_timer+0x31/0x43 [isdn]
 [<c01270a1>] run_timer_softirq+0xce/0x1ae
 [<c012726a>] do_timer+0xdf/0xe4
 [<c0123228>] do_softirq+0x98/0x9a
 [<c010b62f>] do_IRQ+0x102/0x135
 [<c0109b60>] common_interrupt+0x18/0x20

slot (0:0): State ST_SLOT_BOUND Event EV_CMD_HANGUP no routine
slot (0:0): State ST_SLOT_BOUND Event EV_SLOT_UNBIND
slot (0:0): ChangeState ST_SLOT_NULL
slot (0:0): State ST_SLOT_NULL Event EV_CMD_SETEAZ no routine
put_drv 0: 2 -> 1


lspci -vvv of AVM Fritz!Card PCI:

02:05.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH
A1 ISDN [Fritz] (rev 02)
        Subsystem: AVM Audiovisuelles MKTG & Computer System GmbH FRITZ!Card
ISDN Controller
        Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR+ FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Interrupt: pin A routed to IRQ 21
        Region 0: Memory at ec000000 (32-bit, non-prefetchable) [size=32]
        Region 1: I/O ports at c800 [size=32]


Parts from .config:

#
# ISDN subsystem
#
CONFIG_ISDN_BOOL=y

#
# Old ISDN4Linux
#
CONFIG_ISDN=m
# CONFIG_ISDN_NET_SIMPLE is not set
# CONFIG_ISDN_NET_CISCO is not set
# CONFIG_ISDN_PPP is not set
CONFIG_ISDN_AUDIO=y
CONFIG_ISDN_TTY_FAX=y

...

#
# D-channel protocol features
#
CONFIG_HISAX_EURO=y
# CONFIG_DE_AOC is not set
# CONFIG_HISAX_NO_SENDCOMPLETE is not set
# CONFIG_HISAX_NO_LLC is not set
# CONFIG_HISAX_NO_KEYPAD is not set
# CONFIG_HISAX_1TR6 is not set
# CONFIG_HISAX_NI1 is not set
CONFIG_HISAX_MAX_CARDS=4

#
# HiSax supported cards
#
# CONFIG_HISAX_16_3 is not set
# CONFIG_HISAX_TELESPCI is not set
# CONFIG_HISAX_S0BOX is not set
CONFIG_HISAX_FRITZPCI=y
# CONFIG_HISAX_AVM_A1_PCMCIA is not set
# CONFIG_HISAX_ELSA is not set
# CONFIG_HISAX_DIEHLDIVA is not set
# CONFIG_HISAX_SEDLBAUER is not set
# CONFIG_HISAX_NETJET is not set
# CONFIG_HISAX_NETJET_U is not set
# CONFIG_HISAX_NICCY is not set
# CONFIG_HISAX_BKM_A4T is not set
# CONFIG_HISAX_SCT_QUADRO is not set
# CONFIG_HISAX_GAZEL is not set
# CONFIG_HISAX_HFC_PCI is not set
# CONFIG_HISAX_W6692 is not set
# CONFIG_HISAX_HFC_SX is not set
# CONFIG_HISAX_ENTERNOW_PCI is not set
CONFIG_HISAX_DEBUG=y
# CONFIG_HISAX_ST5481 is not set
CONFIG_HISAX_FRITZ_PCIPNP=m
# CONFIG_HISAX_HFCPCI is not set



Best wishes,
Axel Siebenwirth

-- 
Scotty: Captain, we din' can reference it!
Kirk:   Analysis, Mr. Spock?
Spock:  Captain, it doesn't appear in the symbol table.
Kirk:   Then it's of external origin?
Spock:  Affirmative.
Kirk:   Mr. Sulu, go to pass two.
Sulu:   Aye aye, sir, going to pass two.
