Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261638AbTCPAD3>; Sat, 15 Mar 2003 19:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261660AbTCPAD3>; Sat, 15 Mar 2003 19:03:29 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13788
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261638AbTCPAD2>; Sat, 15 Mar 2003 19:03:28 -0500
Subject: Re: Any hope for ide-scsi (error handling)?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: wrlk@riede.org
Cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       dan carpenter <d_carpenter@sbcglobal.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030315210120.GI7082@linnie.riede.org>
References: <Pine.LNX.4.50.0303151343140.9158-100000@montezuma.mastecende.com>
	 <200303151926.h2FJQLnB103490@pimout1-ext.prodigy.net>
	 <Pine.LNX.4.50.0303151453010.9158-100000@montezuma.mastecende.com>
	 <200303152012.h2FKCulK283698@pimout2-ext.prodigy.net>
	 <Pine.LNX.4.50.0303151519240.9158-100000@montezuma.mastecende.com>
	 <20030315210120.GI7082@linnie.riede.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047777805.1327.23.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 16 Mar 2003 01:23:26 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-15 at 21:01, Willem Riede wrote:
> It may not be elegant to schedule(1) with the lock taken, but it
> does work.

You can't sleep holding a lock. You also can't null the hwgroup that
way and you have to deal with some other locking concerns. Have a look
how HDIO_*_RESET is handled in the very latest 2.4/2.5-ac code and
you should be able to follow from that. Note your code paths will be
much like the ioctl as the existing reset code paths are for paths
where we abort from a known safe state (drive initiated or locked).

With the stuff there now you should be able to abort the command
fairly cleanly and then reset the interface.

