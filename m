Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbTAJShF>; Fri, 10 Jan 2003 13:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTAJSft>; Fri, 10 Jan 2003 13:35:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:2195
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266043AbTAJSep>; Fri, 10 Jan 2003 13:34:45 -0500
Subject: Re: PATCH: [2.4.21-pre3] Fix for SMP race condition in IDE code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ross Biro <rossb@google.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E1F0CF5.4000304@google.com>
References: <Pine.LNX.4.10.10301100502450.31168-100000@master.linux-ide.org>
	 <1042207998.28469.98.camel@irongate.swansea.linux.org.uk>
	 <20030110164834.GM843@suse.de>
	 <1042222339.32175.3.camel@irongate.swansea.linux.org.uk>
	 <3E1F0CF5.4000304@google.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1042226977.32431.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 10 Jan 2003 19:29:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-10 at 18:12, Ross Biro wrote:
> There is a race condition in all versions of the IDE code that I've 
> looked at including 2.4.18 and 2.4.21-pre3. Basically on an SMP system 
> if mutiple IDE channels are on the same interrupt and 1 channel sends 
> has an interrupt pending on 1 processor while the other processor is 
> calling ide_set_handler, then the interrupt can be mistaken for command 
> completion on both channels, and a command can be completed before it is 
> even issued.

Thanks Ross. I'll go over this in some detail. 
