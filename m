Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264008AbTDWLvX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 07:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264009AbTDWLvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 07:51:23 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:52352
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264008AbTDWLvW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 07:51:22 -0400
Subject: Re: [PATCH] M68k IDE updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard Zidlicky <rz@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@transmeta.com>, paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030423112700.GA973@linux-m68k.org>
References: <Pine.GSO.4.21.0304221802570.16017-100000@vervain.sonytel.be>
	 <20030423112700.GA973@linux-m68k.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1051095870.2065.84.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2003 12:04:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-23 at 12:27, Richard Zidlicky wrote:
> It seems that Geert´ idea would fit neatly into the current IDE 
> system. Endianness of on disk data and drive control data are
> clearly different things. A while ago Andre suggested to switch
> the transport based on opcode to make it work, it might be even
> more straightforward to set some flag when the handler is selected
> or take a distinct handler altogether (ide_cmd_type_parser or
> ide_handler_parser).

Thats over complicating stuff I think.

> Otoh trying to solve that with loopback would mean new kernels 
> wouldn´t even see the partition table of old installed harddisks
> on some machines. 

Which is a real pain. I think its the right 2.5 answer. I'm not happy
about breaking that (even if its only for the m68k userbase in 2.4)
either.

I don't think command parsing is the right place. Turn your IDE layer
"right endian" and most stuff begins to look a lot saner already. 
The "fixing" needs to be happening at the top of the IDE layer not
in the driver itself. For 2.5 that ought to be loopback or similar
for 2.4 it makes sense I think to effectively implement an endian
switcher without loopback for compatibility.

