Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267899AbRGRQGh>; Wed, 18 Jul 2001 12:06:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267902AbRGRQG1>; Wed, 18 Jul 2001 12:06:27 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:5623 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267899AbRGRQGF>;
	Wed, 18 Jul 2001 12:06:05 -0400
Importance: Normal
Subject: Re: [PATCH] ACP Modem (Mwave)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, "Mike Sullivan" <sullivam@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF67CA15A0.AE538F3E-ON85256A8D.00580180@raleigh.ibm.com>
From: "Paul Schroeder" <paulsch@us.ibm.com>
Date: Wed, 18 Jul 2001 11:02:45 -0500
X-MIMETrack: Serialize by Router on D04NM208/04/M/IBM(Release 5.0.6 |December 14, 2000) at
 07/18/2001 12:06:06 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay..  I cleaned things up...  I was more careful about the globals this
time...

Also...  The driver now builds as mwave.o instead of mwavedd.o...  The
driver now registers it's UART as a serial device (Thomas Hood)..  So there
is no need to run setserial anymore...

Cheers...Paul...


---
Paul B Schroeder  <paulsch@us.ibm.com>
Software Engineer, Linux Technology Center
IBM Corporation, Austin, TX


Alan Cox <alan@lxorguk.ukuu.org.uk> on 07/12/2001 02:55:00 PM

To:   Paul Schroeder/Austin/IBM@IBMUS
cc:   linux-kernel@vger.kernel.org, Mike Sullivan/Austin/IBM@IBMUS,
      alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject:  Re: [PATCH] ACP Modem (Mwave)



> The patch has been updated...  The updates primarily consist of Alan's
> suggested changes below... (thank you)  It applies against the 2.4.6
> kernel...

A quick glance through it:

dsp3780I_WriteDStore still touches user space with a spinlock held
(also doesnt check the get_user return)

The ioctl handlers do not check copy_from_user/to_user returns

IOCTL_MW_UNREGISTER_IPC will oops if fed bogus info (ipcnum should be
unsigned)

The return should be -ENOTTY not -ENOIOCTLCMD  unless its internal code
that catches NOIOCTLCMD and changes it before user space sees it

mwave_Read should be -EINVAL not -ENOSYS (ENOSYS means the entire read
syscall
in the OS isnt there)

In debug mode mwave_write accesses user space directly and may crash
(buf[0])

Trivial item - coding style uses foo(void) not foo() to indicate functions
taking no arguments

Still have globals like "dspio" "uartio"  "ClaimResources" etc

whats wrong with tp3780_uart_io etc for globals ?

Otherwise it looks close to ready

Alan



