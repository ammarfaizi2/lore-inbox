Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966680AbWKOIWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966680AbWKOIWb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 03:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966671AbWKOIWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 03:22:31 -0500
Received: from gw.goop.org ([64.81.55.164]:40118 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S966680AbWKOIWa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 03:22:30 -0500
Message-ID: <455ACE45.4040305@goop.org>
Date: Wed, 15 Nov 2006 00:22:29 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-thinkpad@linux-thinkpad.org,
       Eric Sandeen <sandeen@redhat.com>
Subject: Re: paging request BUG in 2.6.19-rc5 on resume - X60s
References: <20061113081147.GB5289@gimli>
In-Reply-To: <20061113081147.GB5289@gimli>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Lorenz wrote:
> I only see this when ipw3945 is loaded.
>
> [226156.057000] BUG: unable to handle kernel paging request at virtual
> address 756e6567
>   

OK, very bizarre.  Another instance of this pattern:

   1. Recent Core Duo Thinkpad (X60, T60, X60s)
   2. tainting wireless driver loaded (ipw3945, madwifi)
   3. fault at "Genu" somewhere in filesystem code
   4. not long after a resume from ram (?)

Not exactly the same backtrace as before
(https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208488
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=207658), but pretty
close.

The only things I can think of are:

   1. ipw3945 and madwifi are sharing some 802.11 code, which splats
      this pattern into memory for some reason
   2. some firmware/smm bug which end up corrupting a register (?)
   3. erm?  anyone?


    J
