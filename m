Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261937AbVAaGOd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261937AbVAaGOd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 01:14:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbVAaGOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 01:14:32 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:23946 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261932AbVAaGML (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 01:12:11 -0500
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: sfeldma@pobox.com
Cc: David =?ISO-8859-1?Q?H=E4rdeman?= <david@2gen.com>,
       Michael Gernoth <simigern@stud.uni-erlangen.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
In-Reply-To: <1107147615.18167.433.camel@localhost.localdomain>
References: <20050130171849.GA3354@hardeman.nu>
	 <1107143255.18167.428.camel@localhost.localdomain>
	 <1107143905.21273.33.camel@desktop.cunninghams>
	 <1107147615.18167.433.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1107152056.21273.56.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 31 Jan 2005 17:14:16 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2005-01-31 at 16:00, Scott Feldman wrote:
> On Sun, 2005-01-30 at 19:58, Nigel Cunningham wrote:
> > Do you also disable the WOL event when resuming?
> 
> Good catch.  How's this look?

I looked at it last week because I used it for an example of device
model drivers at the CELF conference. I got your intel address from the
top of the .c file, but IIRC it bounced. Providence :>

[...]

> @@ -2333,6 +2331,7 @@ static int e100_resume(struct pci_dev *p
>  	struct nic *nic = netdev_priv(netdev);
>  
>  	pci_set_power_state(pdev, PCI_D0);
> +	pci_enable_wake(pdev, PCI_D0, 0);
>  	pci_restore_state(pdev);
>  	e100_hw_init(nic);

Shouldn't this be disable_wake?

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574

