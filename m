Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267117AbSLaBAa>; Mon, 30 Dec 2002 20:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbSLaBAa>; Mon, 30 Dec 2002 20:00:30 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:35458
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267117AbSLaBA3>; Mon, 30 Dec 2002 20:00:29 -0500
Subject: Re: [PATCH] pnp & pci structure cleanups
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, Jaroslav Kysela <perex@suse.cz>,
       Adam Belay <ambx1@neo.rr.com>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20021230231436.GA20810@gtf.org>
References: <Pine.LNX.4.33.0212291228200.532-100000@pnote.perex-int.cz>
	<20021230221212.GE32324@kroah.com>
	<1041289960.13684.180.camel@irongate.swansea.linux.org.uk>
	<20021230225012.GA19633@gtf.org> <20021230225134.GD814@kroah.com> 
	<20021230231436.GA20810@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 31 Dec 2002 01:50:26 +0000
Message-Id: <1041299426.13956.191.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok. Suggestion for how to handle this (not yet tried). Change the
assumption about the end marker. Right now the end marker only uses the
first fields and the user data happens to always be zero. If we change
the pci matching code to interpret end markers with a non zero userdata
as a pointer to the next table it all seems to come out in the wash,
although there are some tricky details to consider - who frees up the
extra tables on a module unload (if anyone), and how do we manage
multiple modules with chains of tables (or do we just disallow that
case). 

I think it also means we need to be able to go pci table -> owner ?

Alan



