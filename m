Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUAEWSc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265958AbUAEWRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:17:51 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1497 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265956AbUAEWRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:17:42 -0500
Date: Mon, 5 Jan 2004 23:17:32 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrea Barisani <lcars@infis.univ.trieste.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.0, wrong Kconfig directives
Message-ID: <20040105221732.GG10569@fs.tum.de>
References: <20031222235622.GA17030@sole.infis.univ.trieste.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031222235622.GA17030@sole.infis.univ.trieste.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 23, 2003 at 12:56:23AM +0100, Andrea Barisani wrote:
> 
> Hi folks,

Hi Andrea,

> Installing 2.6.0 I've found that some kernel options directives are wrong,
> in fact the option turns out to be always enabled. I don't think this is 
> a desired behaviour.
> 
> Sorry for the format, yes I know it's ugly :) but I'll leave to you the proper 
> solution :) so I can't make a proper patch.
> 
> 
> - IPV6_SCTP___ option is always turned on
> 
> ./net/sctp/Kconfig:
> 
> 8:  config IPV6_SCTP__
> 9: 	    tristate
> 10:         default y if IPV6=n
> 11:	    default IPV6 if IPV6
> 12:
> 13: config IP_SCTP
> 14:	    tristate "The SCTP Protocol (EXPERIMENTAL)"
> 15:	    depends on IPV6_SCTP__
> 
> 
> I think something is wrong here, why the 'default y if IPV6=n' ???


It's ___ugly___ but designed this way...

The whole purpose of IPV6_SCTP__ is to disallow static IP_SCTP with
modular IPV6.


> - INPUT_MOUSEDEV option is always turned on
> 
> ./drivers/input/Kconfig:
> 
> 27: config INPUT_MOUSEDEV
> 28:	    tristate "Mouse interface" if EMBEDDED
> 29:	    default y
> 30:	    depends on INPUT
> 
> 43: config INPUT_MOUSEDEV_PSAUX
> 44:         bool "Provide legacy /dev/psaux device" if EMBEDDED
> 45:         default y
> 46:         depends on INPUT_MOUSEDEV
> 
> 
> the tristate directive is ignored in most default configurations since EMBEDDED
> is not set, however this doesn't allow to disable INPUT_MOUSEDEV and 
> INPUT_MOUSEDEV_PSAUX. I don't suppose this is right.
>...

These EMBEDDED are there to help people not to accidentially disable 
these options although they might require them.

> Bye 
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

