Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSHFRI3>; Tue, 6 Aug 2002 13:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSHFRI3>; Tue, 6 Aug 2002 13:08:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1807 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S313743AbSHFRI2>;
	Tue, 6 Aug 2002 13:08:28 -0400
Message-ID: <3D500364.5010607@mandrakesoft.com>
Date: Tue, 06 Aug 2002 13:12:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Ben Greear <greearb@candelatech.com>, lkml <linux-kernel@vger.kernel.org>,
       "David S. Miller" <davem@redhat.com>
Subject: NAPI (was Re: Linux 2.4.20-pre1)
References: <Pine.LNX.4.44.0208060832090.6811-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> I want arguments from Davem to include NAPI. Changing the drivers is a
> reason for me to _not_ want it in.
> 
> But lets see if Davem can convince me ;)



8139too needs it for flood protection.  I also have a patch for sundance 
which fixes the issue with the quad port and implements RX polling for 
flood protection.

Basically, NAPI --should not-- affect any system that is not using a 
NAPI driver.  Think of NAPI as a net driver libary -- if your driver 
doesn't use it, you don't know it's there at all.  And currently tg3 is 
the only 2.4 driver using NAPI.

NAPI saves people manually implementing polling in each driver, for 
flood and DoS protection that is needed in 2.4.  The flood ceiling is 
much lower without NAPI, due to having the CPU overhead of interrupt 
handlers.  NAPI also eliminates the need for lots of code to support all 
sorts of NIC hardware interrupt mitigation variants.

	Jeff



