Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264836AbTAJK6t>; Fri, 10 Jan 2003 05:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTAJK6t>; Fri, 10 Jan 2003 05:58:49 -0500
Received: from [217.167.51.129] ([217.167.51.129]:46551 "EHLO zion.wanadoo.fr")
	by vger.kernel.org with ESMTP id <S264836AbTAJK6s>;
	Fri, 10 Jan 2003 05:58:48 -0500
Subject: Re: Problem in IDE Disks cache handling in kernel 2.4.XX
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: fverscheure@wanadoo.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <1042198670.28469.45.camel@irongate.swansea.linux.org.uk>
References: <20030110095558.E144CFF11@postfix4-1.free.fr>
	 <1042198670.28469.45.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042196875.523.44.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 10 Jan 2003 12:07:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 12:37, Alan Cox wrote:

> > And by the way how are powered off the IDE drives ?
> > Because a FLUSH CACHE or STANDY or SLEEP is MANDATORY before powering off the 
> > drive with cache enabled or you will enjoy lost data
> 
> IDE disagrees with itself over this but when we get a controlled power
> off we do this. The same ATA5/ATA6 problem may well be present there
> too. I will review both

I did fix a data loss problem with some PPC laptops that way too, that
is just before shutdown and just before machine sleep, sending a STANDBYNOW
command. In the case of machine sleep, I make sure not to accept any more
request (mark the hwif busy) after that and until machine wake up (at which
point I do a full hard reset or poweron reset of the drive).

Ben.

