Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263416AbTH0PMj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 11:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263419AbTH0PMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 11:12:39 -0400
Received: from mail.gondor.com ([212.117.64.182]:64016 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S263416AbTH0PMi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 11:12:38 -0400
Date: Wed, 27 Aug 2003 17:12:28 +0200
From: Jan Niehusmann <jan@gondor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Promise IDE patches
Message-ID: <20030827151227.GA25198@gondor.com>
References: <20030826223158.GA25047@gondor.com> <200308270054.27375.bzolnier@elka.pw.edu.pl> <1061996391.22825.39.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061996391.22825.39.camel@dhcp23.swansea.linux.org.uk>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 03:59:52PM +0100, Alan Cox wrote:
> If you fail to do this then existing PIO LBA48 setups will just die
> on boot.

But 'die on boot' is much better than 'silently currupt data', don't you
think? 
Still, a proper fix would work in all cases... 

What do you think about a check in __ide_do_rw_disk? calling
lba_28_rw_disk or chs_rw_disk when the block address doesn't fit in
28bit is surely wrong and should return an error. 

This will lead to read or write errors if LBA48 doesn't work, but
it will prevent silent data corruption.

Jan

