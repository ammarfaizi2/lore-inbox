Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290643AbSARJda>; Fri, 18 Jan 2002 04:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290645AbSARJdU>; Fri, 18 Jan 2002 04:33:20 -0500
Received: from firewall.telegraafnet.nl ([195.64.78.58]:30727 "EHLO
	server0.telegraafnet.nl") by vger.kernel.org with ESMTP
	id <S290643AbSARJdJ>; Fri, 18 Jan 2002 04:33:09 -0500
From: Ard van Breemen <ard@telegraafnet.nl>
Date: Fri, 18 Jan 2002 10:33:03 +0100
To: "Peter C. Norton" <spacey@lenin.nu>
Cc: linux-kernel@vger.kernel.org, bonding-devel@lists.sourceforge.net
Subject: Re: [Bonding-devel] Re: Weird bonding driver and tulip quad-card interaction on 2.4.17
Message-ID: <20020118093302.GA6012@telegraafnet.nl>
In-Reply-To: <20020117191528.GJ31418@lenin.nu> <20020117222036.GT31418@lenin.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020117222036.GT31418@lenin.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 02:20:36PM -0800, Peter C. Norton wrote:
> As a follow-up, Chad T. on the bonding list pointed out to me that there is
> no Media flag normally output by ifconfig.  This would lead me to believe
> that somehow the bonding driver is perhaps overwriting the MAC address in my
> case.  How can this have happened?  Why is it only on this system?  
It *is* printed:
>From lib/interface.c (net-tools 1.60):

    if (hw->print != NULL && (! (hw_null_address(hw, ptr->hwaddr) &&
                  hw->suppress_null_addr)))
    printf(_("HWaddr %s  "), hw->print(ptr->hwaddr));
#ifdef IFF_PORTSEL
    if (ptr->flags & IFF_PORTSEL) {
    printf(_("Media:%s"), if_port_text[ptr->map.port][0]);
    if (ptr->flags & IFF_AUTOMEDIA)
        printf(_("(auto)"));
    }
#endif
    printf("\n");

So, something has set IFF_PORTSEL, and ptr->map.port is not within bounds.
Or you have a kernel which does not support IFF_PORTSEL, but something
else is using ptr->flags with different values...

-- 
<ard@telegraafnet.nl> Telegraaf Elektronische Media  http://wwwijzer.nl
http://leerquoten.monster.org/ http://www.faqs.org/rfcs/rfc1855.html 
Let your government know you value your freedom. Sign the petition:
http://petition.eurolinux.org/
