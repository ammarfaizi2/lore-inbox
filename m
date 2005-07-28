Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVG1VHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVG1VHA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 17:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVG1URJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:17:09 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:15870 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S261839AbVG1UQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:16:52 -0400
Date: Thu, 28 Jul 2005 13:22:14 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: Greg KH <greg@kroah.com>, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: Add the ability to unbind drivers to devices from userspace
Message-ID: <20050728202214.GA9041@gaz.sfgoth.com>
References: <9e47339105072719057c833e62@mail.gmail.com> <20050728034610.GA12123@kroah.com> <9e473391050727205971b0aee@mail.gmail.com> <20050728040544.GA12476@kroah.com> <9e47339105072721495d3788a8@mail.gmail.com> <20050728054914.GA13904@kroah.com> <20050728070455.GF9985@gaz.sfgoth.com> <9e47339105072805545766f97d@mail.gmail.com> <20050728190352.GA29092@kroah.com> <9e47339105072812575e567531@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e47339105072812575e567531@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Thu, 28 Jul 2005 13:22:14 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Still one nitpick:

Jon Smirl wrote:
> +	while (isspace(*x) && (x - buffer->page < count))
> +		x++;

I think you can just do:

	if (count > 0)
		while (isspace(*x))
			x++;

If the passed-in string was fully whitespace then the trailing-whitespace
stripping would already reduce it to count==0.  So as long as you check
for that case you can be sure that the while() will stop before x falls off
the end of the string.

Other than that it looks fine to me now.

-Mitch
