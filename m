Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932241AbVKFAhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932241AbVKFAhi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 19:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932244AbVKFAhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 19:37:38 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:21711 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932241AbVKFAhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 19:37:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=m/z3dP5x8wu7xyH07KqyDGQQDptoDt9GnZSxsJ3IgBpAy68RyLNUvQMLCRWlVaHcrOMRhgywtBhoSJ4UC5EmC9UONc1LI8igRMiccTAOMd8kkamChsUdOmhAyhXXF4I9rblZxyysHb16eS2B+EDaPPoxX3/ltwsgFaxrov4G4Pk=
Message-ID: <436D5047.4080006@gmail.com>
Date: Sun, 06 Nov 2005 08:37:27 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org,
       mlang@debian.org
Subject: Re: [PATCH] Set the vga cursor even when hidden
References: <20051105211949.GM7383@bouh.residence.ens-lyon.fr>
In-Reply-To: <20051105211949.GM7383@bouh.residence.ens-lyon.fr>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> Hi,
> 
> Some visually impaired people use hardware devices which directly read
> the vga screen. When newt for instance asks to hide the cursor for
> better visual aspect, the kernel puts the vga cursor out of the screen,
> so that the cursor position can't be read by the hardware device. This
> is a great loss for such people.
> 
> Here is a patch which uses the same technique as CUR_NONE for hiding the
> cursor while still moving it.

Note that this method will produce a split block cursor with EGA, which is
still supported by vgacon, but possibly not used anymore.  Why not use
this method (scanline_end < scanline_start) for VGA, and the default method
(moving the cursor out of the screen) for the rest?

Or why not just set bit 5 of the cursor start register (port 0x0a) to disable
the cursor, and clear to enable? I believe this will also work for the
other types.

Tony
