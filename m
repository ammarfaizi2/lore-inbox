Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313534AbSDHP7s>; Mon, 8 Apr 2002 11:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313680AbSDHP7r>; Mon, 8 Apr 2002 11:59:47 -0400
Received: from [212.18.235.99] ([212.18.235.99]:11016 "EHLO street-vision.com")
	by vger.kernel.org with ESMTP id <S313534AbSDHP7q>;
	Mon, 8 Apr 2002 11:59:46 -0400
From: Justin Cormack <justin@street-vision.com>
Message-Id: <200204081559.g38Fxjj18046@street-vision.com>
Subject: modular ide broken in recent kernels
To: linux-kernel@vger.kernel.org
Date: Mon, 8 Apr 2002 16:59:44 +0100 (BST)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ide doesnt work modular in recent kernels (eg 2.4.19-pre6)

you get
depmod: *** Unresolved symbols in /lib/modules/2.4.19-pre6/kernel/drivers/ide/ide-probe-mod.o
depmod: 	ide_xlate_1024_hook

I cant work out what this ide_xlate_1024_hook is for, as it only appears to be
used here:

#ifdef MODULE
extern int (*ide_xlate_1024_hook)(kdev_t, int, int, const char *);

int init_module (void)
{
        unsigned int index;
        
        for (index = 0; index < MAX_HWIFS; ++index)
                ide_unregister(index);
        ideprobe_init();
        create_proc_ide_interfaces();
        ide_xlate_1024_hook = ide_xlate_1024;
        return 0;
}

void cleanup_module (void)
{
        ide_probe = NULL;
        ide_xlate_1024_hook = 0;
}
MODULE_LICENSE("GPL");
#endif /* MODULE */


What was it for? It was added some time in later 2.4 I think.

Justin
