Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129057AbRBNLMk>; Wed, 14 Feb 2001 06:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBNLMb>; Wed, 14 Feb 2001 06:12:31 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:23550 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129057AbRBNLMU>; Wed, 14 Feb 2001 06:12:20 -0500
Message-ID: <3A8A6A42.66F727FA@uow.edu.au>
Date: Wed, 14 Feb 2001 22:21:38 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
CC: Tim Waugh <twaugh@redhat.com>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.2-pre3: parport_pc init_module bug
In-Reply-To: <20010213234349.O9459@redhat.com> <Pine.LNX.3.96.1010214020126.28011B-100000@mandrakesoft.mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Bad patch.  It should be
> 
>         if (r >= 0) {
>                 registered_parport = 1;
>                 if (r > 0)
>                         count += r;
>         }
> 
> If pci_register_driver returns < 0, the driver is not registered with
> the system.

eh?

pci_register_driver(struct pci_driver *drv)
{
        struct pci_dev *dev;
        int count = 0;

        list_add_tail(&drv->node, &pci_drivers);
        pci_for_each_dev(dev) {
                if (!pci_dev_driver(dev))
                        count += pci_announce_device(drv, dev);
        }
        return count;
}

Maybe you're thinking of pci_module_init?

Now, if there were some actual COMMENTS (scary, I know) in the pci
code which described the API, stuff like this wouldn't happen.

-
