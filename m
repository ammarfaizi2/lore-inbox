Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbRBMNzG>; Tue, 13 Feb 2001 08:55:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131499AbRBMNy4>; Tue, 13 Feb 2001 08:54:56 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:49092 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129798AbRBMNyq>; Tue, 13 Feb 2001 08:54:46 -0500
From: Christoph Rohland <cr@sap.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: cowboy@vnet.ibm.com (Richard A Nelson), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.19pre10
In-Reply-To: <E14SfU5-0001mT-00@the-village.bc.nu>
Organisation: SAP LinuxLab
Date: 13 Feb 2001 14:59:35 +0100
In-Reply-To: <E14SfU5-0001mT-00@the-village.bc.nu>
Message-ID: <m33ddi7kfs.fsf@linux.local>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On Tue, 13 Feb 2001, Alan Cox wrote:
>> Yes, I understand that. But I never got any note that my fix is
>> broken and I still do not understand what's the concern.
> 
> Unless Im misreading the code the segment you poke at has
> potentially been freed before it is written too.

Oh yes I was blind, shame on me. Here comes a fixed version.

Greetings
		Christoph

--- 2.2.19-pre10/ipc/shm.c.orig	Tue Feb 13 14:35:25 2001
+++ 2.2.19-pre10/ipc/shm.c	Tue Feb 13 14:34:49 2001
@@ -337,6 +337,8 @@
 		if (current->euid == shp->u.shm_perm.uid ||
 		    current->euid == shp->u.shm_perm.cuid || 
 		    capable(CAP_SYS_ADMIN)) {
+			/* Do not find it any more */
+			shp->u.shm_perm.key = IPC_PRIVATE;
 			shp->u.shm_perm.mode |= SHM_DEST;
 			if (shp->u.shm_nattch <= 0)
 				killseg (id);

