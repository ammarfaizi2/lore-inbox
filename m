Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261596AbVBWVYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261596AbVBWVYi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 16:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261597AbVBWVYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 16:24:38 -0500
Received: from isilmar.linta.de ([213.239.214.66]:7633 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S261596AbVBWVYg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 16:24:36 -0500
Date: Wed, 23 Feb 2005 22:24:33 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1
Message-ID: <20050223212433.GA31281@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Brice Goglin <Brice.Goglin@ens-lyon.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050223014233.6710fd73.akpm@osdl.org> <421CC959.3070405@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <421CC959.3070405@ens-lyon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 23, 2005 at 07:20:09PM +0100, Brice Goglin wrote:
> Andrew Morton a écrit :
> >ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
>
> I can't get PCMCIA to work anymore since rc4-mm1.
> It was working great with rc4 and rc3-mm1.
> 
> PCMCIA loads without any apparent problem (see attached dmesg).

One thing surprises me: the sockets don't get IO resources allocated:
> yenta 0000:02:03.1: no resource of type 100 available, trying to continue...
> yenta 0000:02:03.1: no resource of type 100 available, trying to continue...
which doesn't happen in earlier kernels. In lspci this shows itself as:

        I/O window 0: 00000000-00000003                                         
        I/O window 1: 00000000-00000003                                         

> Which one(s) do you think might be responsible for this ?

My gut tells me

> >+pcmcia-bridge-resource-management-fix.patch

is responsible for this "no resource available" message, because the other
ones relate to other areas.

If the error persists, it'd be great if you could apply the other PCMCIA
patches to the working -rc4 tree and check if it continues to work -- or,
the other way round, removing the PCMCIA patches completely and checking
whether it works then.

Thanks,
	Dominik
