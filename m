Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUKJQrU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUKJQrU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 11:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUKJQrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 11:47:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:58002 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262003AbUKJQrL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 11:47:11 -0500
Message-ID: <41924339.1070809@osdl.org>
Date: Wed, 10 Nov 2004 08:35:05 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stelian Pop <stelian@popies.net>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] drivers/net/pcmcia: use module_param() instead of MODULE_PARM()
References: <20041104112736.GT3472@crusoe.alcove-fr> <418AE490.1010304@pobox.com> <20041110155903.GA8542@sd291.sivit.org> <20041110160058.GB8542@sd291.sivit.org>
In-Reply-To: <20041110160058.GB8542@sd291.sivit.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stelian,

Several of these changes expose module parameters to sysfs
(i.e., have permissions of non-zero value) without need for that IMO.

This came up yesterday on the kernel-janitors mailing list.
When asked about it, Greg KH replied:

 > Can someone please clarify the "official guidelines" for
 > module parameter permissions in sysfs?

"When it makes sense to have it exposed to userspace"

Yeah, it's vague, sorry, but it all depends.

For things that can be changed on the fly, expose it.
For things that don't really matter, and no one will ever look them up,
don't.  I think the irq stuff is in the "don't" category, as almost no
one messes with them anymore.
<end quote>

OTOH, debug flags are often read/write and visible, so using
0644 for them is the right thing to do.



Stelian Pop wrote:
ChangeSet@1.2090, 2004-11-10 16:43:13+01:00, stelian@popies.net
   drivers/net/pcmcia: use module_param() instead of MODULE_PARM()

   Signed-off-by: Stelian Pop <stelian@popies.net>

===================================================================

  3c574_cs.c    |   21 +++++++++++++--------
  3c589_cs.c    |   18 ++++++++++--------
  axnet_cs.c    |   11 ++++++-----
  com20020_cs.c |   34 +++++++++++++++++-----------------
  fmvj18x_cs.c  |   15 ++++++++-------
  ibmtr_cs.c    |   23 ++++++++++++-----------
  nmclan_cs.c   |   14 ++++++++------
  pcnet_cs.c    |   46 +++++++++++++++++++++++++++++++++-------------
  smc91c92_cs.c |   18 ++++++++++--------
  xirc2ps_cs.c  |   25 +++++++++++++++++--------
  10 files changed, 134 insertions(+), 91 deletions(-)

===================================================================


-- 
~Randy
