Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291036AbSBLNlV>; Tue, 12 Feb 2002 08:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291043AbSBLNlM>; Tue, 12 Feb 2002 08:41:12 -0500
Received: from gherkin.frus.com ([192.158.254.49]:11648 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S291036AbSBLNkz>;
	Tue, 12 Feb 2002 08:40:55 -0500
Message-Id: <m16adB0-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: various 2.5.4 problems
To: linux-kernel@vger.kernel.org
Date: Tue, 12 Feb 2002 07:40:54 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven't seen any discussion of these yet, so here goes the latest
laundry list.  Patches not offered here: I'm in way over my head,
but you'll note that doesn't keep me from mentioning things I've
explored :-).

linux/drivers/usb/storage/datafab.c:
linux/drivers/usb/storage/jumpshot.c:
	several instances of "memcpy(... sg[sg_idx].address ..." where
	"address" is no longer a valid structure member.  I saw
	similar things in the 2.5.4 patch suggesting that a fix
	might be "memcpy(... page_address(sg[sg_idx].page) ..."


linux/drivers/sound/dmabuf.c:
linux/drivers/char/drm/i810_dma.c:
linux/drivers/video/vesafb.c:
	virt_to_bus() has gone bye-bye.  Compiler suggests using
	the pci_map routines in this context.  Don't know how to
	proceed.

linux/drivers/md/lvm.c:
	A couple of things here.  lvm_get_blksize() should be
	block_size().  This one has been mentioned before.
	The other problem is a reference to current->sigpending.
	A possible fix is to replace "if (current->sigpending != 0)"
	with "if (signal_pending(current))".

linux/arch/i386/kernel/process.c:
linux/include/asm-i386/processor.h:
	Patch set previously provided by someone else for returning
	saved PC of a blocked thread.

linux/fs/intermezzo/super.c:
	read_super --> get_sb conversion not done for this filesystem.
	This one is more difficult than the patches I saw for other
	filesystems, because presto_read_super() calls
	fstype->read_super().

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
