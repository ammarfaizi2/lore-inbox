Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129824AbQLGOoa>; Thu, 7 Dec 2000 09:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129455AbQLGOoU>; Thu, 7 Dec 2000 09:44:20 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:9224 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S129824AbQLGOoE>;
	Thu, 7 Dec 2000 09:44:04 -0500
Message-ID: <3A2F9AD4.830153B4@mandrakesoft.com>
Date: Thu, 07 Dec 2000 09:12:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Krzysztof Halasa <khc@intrepid.pm.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <E1441je-0002T3-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I think we need few ioctl calls: get + set media (int argument),
> > get + set speed (probably two - RX and TX), etc.
> > In my 2.4 HDLC stuff - to be published :-( - there something like that
> > (in private ioctl range, of course).
> 
> I think we are agreeing
> 
> I'm saying use something like
> 
>         struct
>         {
>                 u16 media_group;
>                 union
>                 {
>                         struct hdlc_physical ...
>                         struct hdlc_bitstream
>                         struct hdlc_protocol
>                         struct fr_protocol
>                         struct eth_physical

Not yet another one for eth...  We now have ethtool for this.  And a
generic netdevice::set_config wrapper can be created that simply calls
the ethtool ioctl with the proper info and locking.

	Jeff


-- 
Jeff Garzik         |
Building 1024       | These are not the J's you're lookin' for.
MandrakeSoft        | It's an old Jedi mind trick.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
