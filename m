Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293114AbSBWIGV>; Sat, 23 Feb 2002 03:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293113AbSBWIGL>; Sat, 23 Feb 2002 03:06:11 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:6663 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293114AbSBWIF4>;
	Sat, 23 Feb 2002 03:05:56 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9 
In-Reply-To: Your message of "Fri, 22 Feb 2002 15:16:22 BST."
             <3C7652B6.1040008@evision-ventures.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Feb 2002 19:05:43 +1100
Message-ID: <24175.1014451543@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Feb 2002 15:16:22 +0100, 
Martin Dalecki <dalecki@evision-ventures.com> wrote:
>... I would like to finish some other minor things there
>as well. I mean basically the macro games showing that somebody didn't
>understand C pointer semantics found at places like:
>
>#ifdef CONFIG_BLK_DEV_ALI15X3
>extern unsigned int pci_init_ali15x3(struct pci_dev *, const char *);
>...
>#define PCI_ALI15X3	&pci_init_ali15x3
>#else
>...
>#define PCI_ALI15X3	NULL
>#endif
>
>This should rather look like:
>
>#ifdef CONFIG_BLK_DEV_ALI15X3
>extern unsigned int pci_init_ali15x3(struct pci_dev *);
>#else
>#define pci_init_ali15x3	NULL
>#endif

That will probably break with CONFIG_MODVERSIONS.  At the very least it
will require make mrproper when changing CONFIG_BLK_DEV_ALI15X3 and
CONFIG_MODVERSIONS is set to y.

Modversions does its own #define of nthe function name.  Anybody
contemplating a mixture of real functions and #define of the function
name must test their patch with CONFIG_MODVERSIONS=y, otherwise you are
setting users up for wierd bug reports.

