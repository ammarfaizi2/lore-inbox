Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVA0PDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVA0PDT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbVA0PDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:03:19 -0500
Received: from imag.imag.fr ([129.88.30.1]:32398 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S262482AbVA0PDM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:03:12 -0500
Date: Thu, 27 Jan 2005 16:03:06 +0100
From: castet.matthieu@free.fr
To: linux-kernel@vger.kernel.org
Subject: Re:parport disabled?
Message-ID: <20050127150306.GA29334@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Thu, 27 Jan 2005 16:03:07 +0100 (CET)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


> Whenever I "modprobe parport_pc", I get this message:
> 
> Jan 27 10:55:47 hummus kernel: pnp: Device 00:0b activated.
> Jan 27 10:55:47 hummus kernel: parport: PnPBIOS parport detected.
> Jan 27 10:55:47 hummus kernel: pnp: Device 00:0b disabled.
> 
> and the parallel port is unusable ever after.
> This is with Kernel 2.6.10-ac10 and 2.6.10-ac11
> 
> How can I make my parallel port usable again?
Try disabling acpi.

If it works, with acpi enabled send a "for i in /sys/bus/pnp/devices/*; do cat
$i/*; done"

I could be related to http://bugzilla.kernel.org/show_bug.cgi?id=3912
and [1]

regards,

Matthieu


Adam Belay wrote:

> On Mon, Nov 29, 2004 at 10:30:29PM +0100, matthieu castet wrote:
>
>> matthieu castet wrote:
>>
>>> Hello,
>>>
>>> acpi need that the order of the resources are the same as the
>>> possible resources. It could be the same for pnpbios.
>>>
>>> I most of case, it works quite well, but if the independent options
>>> are after dependent, it doesn't work :
>>> in pnp manager, pnp_assign_resources first uses independent_options
>>> and then dependent ones. So we break the order, and it doesn't work.
>>>
>>> What the rules for independent options in pnpbios ?
>>>
>>> If it works like pnpacpi, it is allowed to define them only before
>>> or after dependent option.
>>>
>>> So a solution could be to have a second independent option, and use
>>> it after dependent options in pnp_assign_resources.
>>>
>>> What do you think of that ?
>>>
>>> Matthieu CASTET
>>>
>>
>> I forgot to say that it is probably the bug of meelis roos.
>>
>
>
> Hmm, I agree this is a problem, and it will be interesting to see if
> it
> resolves Meelis's issue.  I don't think a second independent option
> would be a
> clean solution.  I think the a slight redesign is in order, with a
> focus on
> ensuring resources are assigned in the order they are advertised in
> all cases.
> I'm hacking something together now. 
