Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267478AbTBRBnY>; Mon, 17 Feb 2003 20:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267543AbTBRBnY>; Mon, 17 Feb 2003 20:43:24 -0500
Received: from dp.samba.org ([66.70.73.150]:8930 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267500AbTBRBnW>;
	Mon, 17 Feb 2003 20:43:22 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15953.37244.263505.214325@argo.ozlabs.ibm.com>
Date: Tue, 18 Feb 2003 12:50:52 +1100
To: linux-kernel@vger.kernel.org, linux@brodo.de
Subject: stuff-up in pcmcia/cardbus stuff
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent 2.5 kernels will crash with a null pointer dereference on my
powerbook (PowerPC laptop) when I try to suspend.  I tracked it down
to cardbus_suspend() in drivers/pcmcia/pci-socket.c calling
pcmcia_suspend_socket() with a NULL argument.  It turns out that
socket->pcmcia_socket is never set in the current code.

This changeset seems to be the culprit:

ChangeSet 1.1017 2003/02/15 12:42:51 linux@brodo.de
  [PATCH] pcmcia: use device_class->add_device/remove_device
  
  This patch removes the {un}register_ss_entry/pcmcia_{un}register_socket
  calls, and replaces them with generic driver-model-compatible functions.
  
  Also, update the CodingStyle of these cs.c functions to what's recommended
  in the Linux kernel.

Paul.
