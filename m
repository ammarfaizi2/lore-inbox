Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSEPEwZ>; Thu, 16 May 2002 00:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316575AbSEPEwY>; Thu, 16 May 2002 00:52:24 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:6361 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S316574AbSEPEwX>; Thu, 16 May 2002 00:52:23 -0400
From: "Ashok Raj" <ashokr2@attbi.com>
To: "Russell Leighton" <russ@elegant-software.com>, <Tony.P.Lee@nokia.com>
Cc: <wookie@osdl.org>, <alan@lxorguk.ukuu.org.uk>, <lmb@suse.de>,
        <woody@co.intel.com>, <linux-kernel@vger.kernel.org>,
        <zaitcev@redhat.com>
Subject: RE: InfiniBand BOF @ LSM - topics of interest
Date: Wed, 15 May 2002 21:51:59 -0700
Message-ID: <PPENJLMFIMGBGDDHEPBBGEMADAAA.ashokr2@attbi.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <3CE2D4DB.3020702@elegant-software.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

->
->Can we really have these sort of low level IB interactions and have :
->    - security issues addressed, mostly an issue if the devices are over
->a network w/other devices

IB fabric does not replace the network. It is designed for the data-center.

IB offers even more RAS from a server standpoint. For e.g todays drivers
could DMA to areas of memory owned by another driver/process. IB protects
your RDMA by implementing protection domains which each driver could be on a
separate protection domain, and any access to RDMA to areas not owned would
only cause error to the specific driver/application that is malfunctioning.

->    - qos control

IB specifies Service Level (a.k.a SL) and multiple data Virtual Lanes (VL)
that can be managed via the Subnet Manager to implement QoS. There is a
dedicated workgroup in IBTA working on some of these issues.

Applications that would require absolute feel of the metal can use the
access layer API's that will provide direct user mode ability to send data
from hardware, and also process completions without entering kernel mode
entirely in user mode, if the hardware permits that.
->
-

->
->Thanks!
->
->Russ
->
->
->Tony.P.Lee@nokia.com wrote:
->
->>
->>For VNC type application, instead server translates
->>every X Windows, Mac, Windows GUI calls/Bitmap update
->>to TCP stream, you convert the GUI API calls to
->>IB RC messages and bitmap updates to RDMA write directly
->>to client app's frame buffer.
->>
->>For SAMBA like fs, the file read api can be translated to
->>IB RC messages on client + RDMA write to remote
->>client app's buffer directly from server.
->>
->>They won't be "standard" VNC/SAMBA any more.
->>
->>On the other hand, we can put VNC over TCP over IP over IB,
->>- "for people with hammer, every problem looks like a nail." :-)
->>
->>In theory, we can have IB DVD drive RDMA video directly
->>over IB switch to IB enable VGA frame buffer and completely
->>by pass the system.  CPU only needed setup the proper
->>connections.   The idea is to truely virtualized the system
->>resources and "resource server" RDMA the data to anyone on IB
->>switch with minimal CPU interaction in the process.
->>
->>You can also config a normal SCSI card DMA data to virtualized
->>IB address on PCI address space and have the data shows up 15 meters
->>or 2 km away on server's "virtual scsi driver" destination DMA address.
->>It made iSCSI looked like dial up modem in term of performance
->>and latency.
->>
->>
->>----------------------------------------------------------------
->>Tony
->>-
->>To unsubscribe from this list: send the line "unsubscribe
->linux-kernel" in
->>the body of a message to majordomo@vger.kernel.org
->>More majordomo info at  http://vger.kernel.org/majordomo-info.html
->>Please read the FAQ at  http://www.tux.org/lkml/
->>
->
->
->-
->To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
->the body of a message to majordomo@vger.kernel.org
->More majordomo info at  http://vger.kernel.org/majordomo-info.html
->Please read the FAQ at  http://www.tux.org/lkml/

