Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTFFXFz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 19:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTFFXFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 19:05:55 -0400
Received: from almesberger.net ([63.105.73.239]:28170 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S262331AbTFFXFy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 19:05:54 -0400
Date: Fri, 6 Jun 2003 20:19:06 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: "David S. Miller" <davem@redhat.com>, chas@cmf.nrl.navy.mil,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2)
Message-ID: <20030606201906.F3232@almesberger.net>
References: <20030606122616.B3232@almesberger.net> <20030606.082802.124082825.davem@redhat.com> <20030606125416.C3232@almesberger.net> <20030606.085558.56056656.davem@redhat.com> <20030606215406.GE21217@gaz.sfgoth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030606215406.GE21217@gaz.sfgoth.com>; from mitch@sfgoth.com on Fri, Jun 06, 2003 at 02:54:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr wrote:
> so basically if atmsigd goes nuts in can easily stomp all
> over the kernel's memory.

Naw, it isn't supposed to do that :-) I wonder if anyone
actually made functional changes to atmsigd (or qgen ;-) since
I last touched it ...

But yes, with a unified VCC table, it certainly makes sense to
add a hash to validate those pointers. I still think that using
pointers per se is a good idea, because they're naturally
unique numbers. Given that a VCC can be in all kinds of states,
it would be pretty hard to use anything in struct atm_vcc else
as a unique key. Also, it's not very common to have atmsigd
talk ISP (Internal Signaling Protocol - the thing used between
atmsigd and the kernel) to a different box.

> the ATMSIGD_CTRL ioctl so at least there's no security hole but it's still
> damn gross (no offense, Werner :-)

It could probably be used to leverage other security holes in
atmsigd. (Not that I'm aware of any, but I'd be surprised if
there were none.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
