Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTFDWJz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTFDWJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:09:55 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18447 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264202AbTFDWJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:09:51 -0400
Date: Wed, 4 Jun 2003 23:23:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: John Appleby <john@dnsworld.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Serio keyboard issues 2.5.70
Message-ID: <20030604232318.D22460@flint.arm.linux.org.uk>
Mail-Followup-To: John Appleby <john@dnsworld.co.uk>,
	linux-kernel@vger.kernel.org
References: <434747C01D5AC443809D5FC540501131097083@bobcat.unickz.com> <434747C01D5AC443809D5FC5405011315699@bobcat.unickz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <434747C01D5AC443809D5FC5405011315699@bobcat.unickz.com>; from john@dnsworld.co.uk on Wed, Jun 04, 2003 at 08:23:21PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 08:23:21PM +0100, John Appleby wrote:
> And that printk is coming up fine. serio_register_device seems to add
> 0x021c2af8 to its tail, but then never finds my entry in
> list_for_each_entry and thus never calls dev->connect(). I've added some
> debugging to serio_register_device thus:
> 
> void serio_register_device(struct serio_dev *dev)
> {
>         struct serio *serio;
>         list_add_tail(&dev->node, &serio_dev_list);
> 	  printk("serio: add_tail %08x\n",&dev->node);
>         list_for_each_entry(serio, &serio_list, node) {
>                 printk("serio: register_device %08x\n",serio->dev);
>                 if (!serio->dev && dev->connect) {
>                         printk("serio: connecting...\n");
>                         dev->connect(serio, dev);
>                 }
>         }
> }
> 
> and I get nothing past "add_tail". I'd expect it to recognize my dev and
> attempt to connect to it.

Do you drop out the bottom of the function?  If you have no hardware ports
registered, I'd expect this to be the case.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

