Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130253AbRDGSyC>; Sat, 7 Apr 2001 14:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRDGSxn>; Sat, 7 Apr 2001 14:53:43 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:59312 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S129624AbRDGSxZ>;
	Sat, 7 Apr 2001 14:53:25 -0400
Message-ID: <3ACF6223.41F138CF@mandrakesoft.com>
Date: Sat, 07 Apr 2001 14:53:23 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Gunther Mayer <Gunther.Mayer@t-online.de>
Cc: linux-kernel@vger.kernel.org, mj@suse.cz, reinelt@eunet.at,
        twaugh@redhat.com
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gunther Mayer wrote:
> Hardware has always needed quirks (linux-2.4.3 has about 60 occurences
> of the word "quirks", not to mention workaround, blacklist and other synonyms)!
> 
> Please apply this little patch instead of wasting time by finger-pointing
> and arguing.
> 
> Martin, comments?

Is Martin still alive?  He hasn't been active in PCI development well
over six months, maybe a year now.  Ivan (alpha hacker) appeared on the
scene to fix serious PCI bridge bugs, DaveM has added some PCI DMA
stuff, and I've added a couple driver-related things.  I haven't seen
code from Martin in a long long time, and only a comment or two in
recent memory.


> --- linux-2.4.3-orig/include/linux/pci.h        Wed Apr  4 19:46:49 2001
> +++ linux/include/linux/pci.h   Sat Apr  7 20:01:51 2001
> @@ -454,6 +454,9 @@
>         void (*remove)(struct pci_dev *dev);    /* Device removed (NULL if not a hot-plug capable driver) */
>         void (*suspend)(struct pci_dev *dev);   /* Device suspended */
>         void (*resume)(struct pci_dev *dev);    /* Device woken up */
> +       int multifunction_quirks;               /* Quirks for PCI serial+parport cards,
> +                                                   here multiple drivers are allowed to register
> +                                                   for the same pci id match */
>  };

As has been explained, the current API supports this just fine without
modification.

Also, changing the API in the stable series should be frowned upon,
-especially- something domain specific like this.

	Jeff


-- 
Jeff Garzik       | Sam: "Mind if I drive?"
Building 1024     | Max: "Not if you don't mind me clawing at the dash
MandrakeSoft      |       and shrieking like a cheerleader."
