Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268467AbUI2OYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268467AbUI2OYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268464AbUI2OX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:23:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:6794 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268447AbUI2OUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:20:54 -0400
Subject: Re: [Patch] Fix oops on rmmod usb-storage
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Hannes Reinecke <hare@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <1096466196.2028.8.camel@mulgrave>
References: <415A67B8.2080003@suse.de>  <1096466196.2028.8.camel@mulgrave>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096463876.15905.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 14:17:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 14:56, James Bottomley wrote:
> The key to the solution of this problem is to know what USB is trying to
> do with the dead device.  SCSI is trying to be polite and explicitly
> kill the outstanding commands before it removes the HBA.  Presumably USB
> is returning something that says this can't be done so the EH gets all
> the way up to offlining.

Its nothing to do with USB, rmmod with eh running crashes all the other
SCSI drivers I've tested too. After the state transition fails you get
kobject related errors and a crash. 

That makes me suspect whatever is ill is in the scsi core.

Alan

