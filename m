Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289310AbSANX4O>; Mon, 14 Jan 2002 18:56:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289309AbSANX4F>; Mon, 14 Jan 2002 18:56:05 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30212 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289307AbSANXzx>;
	Mon, 14 Jan 2002 18:55:53 -0500
Message-ID: <3C437007.595C5ADE@mandrakesoft.com>
Date: Mon, 14 Jan 2002 18:55:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.2-pre9fs7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Erik Andersen <andersen@codepoet.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb fix, fixed
In-Reply-To: <Pine.LNX.4.33.0201150036150.22605-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Sun, 13 Jan 2002, Erik Andersen wrote:
> 
> > > This patch is needed to make radeonfb compile and work.
> > > It is based on an earlier patch on the list attributed to
> > > Ani Joshi, plus adds the needed devinit fix.
> > Oops.  That patch had some crap in it.  Lets try that again.
> 
> Uncompressed, that patch was just 4kb. When not too big, it's
> considered acceptable (and preferred) to send them as plaintext
> to the list for ease of quoting.
> 
> Patch looks ok, but this bit..
> 
> diff -urN linux/drivers/video.virgin/radeonfb.c
> linux/drivers/video/radeonfb.c
> --- linux/drivers/video.virgin/radeonfb.c   Sun Jan 13 19:09:54 2002
> +++ linux/drivers/video/radeonfb.c  Sun Jan 13 19:41:00 2002
> @@ -686,7 +686,7 @@
>     name:       "radeonfb",
>     id_table:   radeonfb_pci_table,
>     probe:      radeonfb_pci_register,
> -   remove:     radeonfb_pci_unregister,
> +   remove:     __devexit_p(radeonfb_pci_unregister),
>  };
> 
> Is that really needed ?  Hotplugable radeons ?

To rant on a general topic, this wholesale converting drivers to
__devexit without much thought, to fix a simple compile error, may wind
up biting users in the ass later on.  Sometimes, like in the case of
radeonfb and many other fbdev drivers, the driver is -not- able to deal
with all hotplug issues without further fixes.  Fixing radeonfb as with
the above simply hides those problems...

	Jeff


-- 
Jeff Garzik      | Alternate titles for LOTR:
Building 1024    | Fast Times at Uruk-Hai
MandrakeSoft     | The Took, the Elf, His Daughter and Her Lover
                 | Samwise Gamgee: International Hobbit of Mystery
