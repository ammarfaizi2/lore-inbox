Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293141AbSBWO4c>; Sat, 23 Feb 2002 09:56:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293142AbSBWO4W>; Sat, 23 Feb 2002 09:56:22 -0500
Received: from [195.63.194.11] ([195.63.194.11]:4627 "EHLO mail.stock-world.de")
	by vger.kernel.org with ESMTP id <S293141AbSBWO4K>;
	Sat, 23 Feb 2002 09:56:10 -0500
Message-ID: <3C77AD63.1040309@evision-ventures.com>
Date: Sat, 23 Feb 2002 15:55:31 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.5-pre1 IDE cleanup 9
In-Reply-To: <24175.1014451543@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> On Fri, 22 Feb 2002 15:16:22 +0100, 
> Martin Dalecki <dalecki@evision-ventures.com> wrote:
> 
>>... I would like to finish some other minor things there
>>as well. I mean basically the macro games showing that somebody didn't
>>understand C pointer semantics found at places like:
>>
>>#ifdef CONFIG_BLK_DEV_ALI15X3
>>extern unsigned int pci_init_ali15x3(struct pci_dev *, const char *);
>>...
>>#define PCI_ALI15X3	&pci_init_ali15x3
>>#else
>>...
>>#define PCI_ALI15X3	NULL
>>#endif
>>
>>This should rather look like:
>>
>>#ifdef CONFIG_BLK_DEV_ALI15X3
>>extern unsigned int pci_init_ali15x3(struct pci_dev *);
>>#else
>>#define pci_init_ali15x3	NULL
>>#endif
>>
> 
> That will probably break with CONFIG_MODVERSIONS.  At the very least it
> will require make mrproper when changing CONFIG_BLK_DEV_ALI15X3 and
> CONFIG_MODVERSIONS is set to y.

No it won't. The functions above are:

1. Not exported at all to modules.
2. If the will be exported it will happen through a generic
struct of function pointers.


