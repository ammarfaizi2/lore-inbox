Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313821AbSDUVX1>; Sun, 21 Apr 2002 17:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313850AbSDUVX0>; Sun, 21 Apr 2002 17:23:26 -0400
Received: from ucsu.Colorado.EDU ([128.138.129.83]:51882 "EHLO
	ucsu.colorado.edu") by vger.kernel.org with ESMTP
	id <S313821AbSDUVX0>; Sun, 21 Apr 2002 17:23:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Ivan G." <ivangurdiev@yahoo.com>
Reply-To: ivangurdiev@yahoo.com
Organization: ( )
To: Urban Widmark <urban@teststation.com>
Date: Sun, 21 Apr 2002 15:16:40 -0600
X-Mailer: KMail [version 1.2]
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02042115164004.00745@cobra.linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban,

About the suggestion to make via_rhine_error handle more interrupts,

enum intr_status_bits {
        IntrRxDone=0x0001, IntrRxErr=0x0004, IntrRxEmpty=0x0020,
        IntrTxDone=0x0002, IntrTxAbort=0x0008, IntrTxUnderrun=0x0010,
        IntrPCIErr=0x0040,
        IntrStatsMax=0x0080, IntrRxEarly=0x0100, IntrMIIChange=0x0200,
        IntrRxOverflow=0x0400, IntrRxDropped=0x0800, IntrRxNoBuf=0x1000,
        IntrTxAborted=0x2000, IntrLinkChange=0x4000,
        IntrRxWakeUp=0x8000,
        IntrNormalSummary=0x0003, IntrAbnormalSummary=0xC260,
};

RxEarly, RxOverflow, RxNoBuf are not handled
(which brings up another question - how should they be handled 
and where?? It doesn't seem to me that those should end up in error,
sending CmdTxDemand. )

RxErr, RxWakeUp, RxDropped, RxEmpty call via_rhine_rx
TxAbort, TxUnderrun,PCIErr, StatsMax, MIIChange call via_rhine_error
TxAborted calls via_rgine_tx
The others don't look like errors.


Martin Eriksson,
The reason my message said PCI Error and not unhandled
is because it specifies a specific interrupt - IntrPCIErr.
(basically the onle one that's left unhandled that can call via_rhine_error)



