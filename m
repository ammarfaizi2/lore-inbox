Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131226AbRCKD1R>; Sat, 10 Mar 2001 22:27:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbRCKD1H>; Sat, 10 Mar 2001 22:27:07 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:49888 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131226AbRCKD0w>;
	Sat, 10 Mar 2001 22:26:52 -0500
Message-ID: <3AAAF032.24AC716D@mandrakesoft.com>
Date: Sat, 10 Mar 2001 22:25:38 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@linuxcare.com>
Cc: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@oss.sgi.com
Subject: Re: [PATCH] RFC: fix ethernet device initialization
In-Reply-To: <3AA6A570.57FF2D36@mandrakesoft.com> <d3ofvcyxhh.fsf@lxplus012.cern.ch>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:
> I don't like the way you declare all the code in obscure macros in
> there.
> 
> +#define DECLARE_CHG_MTU(suffix,low,high) \
> +       static int suffix##_change_mtu(struct net_device *dev, int new_mtu) \
> ......
> 
> All it does is to make the code harder to read and debug for little/no
> gain.

I disagree, but you probably knew that when you saw the code :)

These macros are not used inside code, they declare entire functions. 
These functions are 100% duplicated across 2-4 protocols.  Duplicated
code means bugs in some portions of the code and no others, more
difficult to maintain, etc.  I even proved this point while developing
the patch -- one of the functions was missing an EXPORT_xxx symbol. 
Using a standard macro automatically fixed this, a small oversight that
had been in the kernel probably for over a year.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
