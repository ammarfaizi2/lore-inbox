Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbTFINrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 09:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbTFINrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 09:47:07 -0400
Received: from ginger.cmf.nrl.navy.mil ([134.207.10.161]:12721 "EHLO
	ginger.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S261944AbTFINrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 09:47:06 -0400
Message-Id: <200306091400.h59E0bsG022093@ginger.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: baldrick@wanadoo.fr, wa@almesberger.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] use rtnl_{lock,unlock} during device operations (take 2) 
In-reply-to: Your message of "Mon, 09 Jun 2003 06:38:25 PDT."
             <20030609.063825.123987226.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Mon, 09 Jun 2003 09:58:45 -0400
From: chas williams <chas@cmf.nrl.navy.mil>
X-Spam-Score: (*) hits=1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>My personal feeling is that there should be a way to zombie
>VCCs, precisely for such events.
>
>ATM should unlink them immediately, and mark them dead.
>Anything that tries to do something with a VCC should
>check that it is still alive.

i imagine marking vcc->dev = NULL would be pretty close to the above.
most operations going into the driver check vcc->dev already and it
might actually handle this correct w/o too much extra effort.  you
might also set some flags on the vcc's like ATM_VF_RELEASED etc etc.

of course, this sort of implies that the vcc's are on their own list
and not on a list that is actually part of the atm dev.  (see latest
rfc patch).
