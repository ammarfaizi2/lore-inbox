Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310297AbSBRI6O>; Mon, 18 Feb 2002 03:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310298AbSBRI6D>; Mon, 18 Feb 2002 03:58:03 -0500
Received: from mail.cogenit.fr ([195.68.53.173]:27605 "EHLO cogenit.fr")
	by vger.kernel.org with ESMTP id <S310297AbSBRI54>;
	Mon, 18 Feb 2002 03:57:56 -0500
Date: Mon, 18 Feb 2002 09:57:38 +0100
From: Francois Romieu <romieu@cogenit.fr>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, khc@pm.waw.pl, davem@redhat.com,
        torvalds@transmeta.com
Subject: Re: [PATCH] HDLC patch for 2.5.5 (1/3)
Message-ID: <20020218095738.A7530@fafner.intra.cogenit.fr>
In-Reply-To: <20020217193051.C14629@se1.cogenit.fr> <3C703C36.A7579B72@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C703C36.A7579B72@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sun, Feb 17, 2002 at 06:26:46PM -0500
X-Organisation: Marie's fan club - II
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> :
> Francois Romieu wrote:
> > 
> > [1/3]:
> > - struct if_settings in struct ifreq becomes struct if_settings *
> 
> mostly ok... I'm wondering how this specific item (shown below in the
> patch portion quoted) affects binary compatibility...  how does this
> affect userland if ifru_settings is suddenly a pointer?

2.4.18-preX:include/linux/if.h
[...]
        union {
                struct  sockaddr ifru_addr;
                struct  sockaddr ifru_dstaddr;
                struct  sockaddr ifru_broadaddr;
                struct  sockaddr ifru_netmask;
                struct  sockaddr ifru_hwaddr;
                short   ifru_flags;
                int     ifru_ivalue;
                int     ifru_mtu;
                struct  ifmap ifru_map;
                char    ifru_slave[IFNAMSIZ];   /* Just fits the size */
                char    ifru_newname[IFNAMSIZ];
                char *  ifru_data; <-- Nothing after this field.
        } ifr_ifru;
};

The member ifru_settings is added to the union by Krzysztof's patch.
Existing userland (Krzysztof's new utility aside) shouldn't matter as
- it ignores this member;
- the member doesn't make the union bigger (Krzysztof noticed my previous
  patch choked on this).

If nobody does it before, the utility will be modified when I feel like it's
time to test the code. Shouldn't be long (TM).

-- 
Ueimor
