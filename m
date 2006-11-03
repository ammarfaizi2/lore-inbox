Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752635AbWKCMqN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752635AbWKCMqN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 07:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbWKCMqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 07:46:13 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40410 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752635AbWKCMqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 07:46:12 -0500
X-Sasl-enc: z7rFsHTxIK+QYvQ7XZ3nMY8OyycKe+U6BKWDHk200Pr/ 1162557972
Date: Fri, 3 Nov 2006 09:46:06 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: linux-thinkpad@linux-thinkpad.org, linux-kernel@vger.kernel.org
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061103124606.GA4257@khazad-dum.debian.net>
References: <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com> <20061101205330.GA2593@kroah.com> <20061101235540.GA11581@khazad-dum.debian.net> <454A2FC2.4060107@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454A2FC2.4060107@tmr.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Nov 2006, Bill Davidsen wrote:
> Having seen a French consultant with a Windows laptop reporting mJ 
> (Joules) I bet that came from the hardware. And given that laptop 
> batteries run at (almost) constant voltage, could all of these just be 
> converted to mWh for consistency?

*No*.  That adds quite a lot of error, which can be easily avoided by
providing the _charge and _energy attribute sets.

You can convert between J and Wh and between C to Ah without significant
precision loss.  Just don't go cheap on the fixed point calculations, and
make sure the destination unit is small enough not to forsake precision.

We can definately be safe from any precision loss using (10^-6) * (A, Ah, W,
Wh, V) as the base unit, but that will make for long numbers in sysfs with
lots of zeros in many situations (which is MUCH better than precision loss).

We could also use a proper submultiple of J and C instead of Wh and Ah if
we'd rather stick to the SI, that wouldn't be a big problem at all.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
