Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132527AbRD1Nc7>; Sat, 28 Apr 2001 09:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132511AbRD1Nck>; Sat, 28 Apr 2001 09:32:40 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:13184 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S132479AbRD1NcX>; Sat, 28 Apr 2001 09:32:23 -0400
Message-ID: <3AEAC65F.72836B77@coplanar.net>
Date: Sat, 28 Apr 2001 09:32:16 -0400
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: daniel sheltraw <l5gibson@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: busmaster question
In-Reply-To: <F50IEAOeIiGXix4A2Dr00010c13@hotmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daniel sheltraw wrote:

> Hello kernel listees
>
> I have a busmaster question I am hoping you can help me with.
> If a PCI device is acting as a busmaster and the processor initiates a
> read/write to another device on the PCI bus while the busmater-device is in
> control of the bus what happens to the instructions initiated by the
> processor? Are they never seen by the device that the processor
> is trying to read/write?

An excellent book about PCI is Mindshare's "PCI System Architecture"
Third (or later?) Edition.

In the scenerio you outlined, the device currently holding the bus
would continue until it's latency timer expired (if it already hadn't),
stalling the CPU,
then the master which has been granted access next to the bus would
start it's access.  If the only other master requesting access is the CPU,
then it will get it.  If there are others, then it is implementation dependent

who has highest arbitration priority.

Note that since main memory is not on the PCI bus, the CPU can cary on
unless it tries to access video memory, IDE registers, etc. for IO.

