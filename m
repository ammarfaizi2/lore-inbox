Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264231AbTFDWeH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbTFDWeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:34:07 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44303 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264231AbTFDWeG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:34:06 -0400
Date: Wed, 4 Jun 2003 23:47:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: John Appleby <john@dnsworld.co.uk>
Cc: John Appleby <johna@unickz.com>, linux-kernel@vger.kernel.org
Subject: Re: Serio keyboard issues 2.5.70
Message-ID: <20030604234732.E22460@flint.arm.linux.org.uk>
Mail-Followup-To: John Appleby <john@dnsworld.co.uk>,
	John Appleby <johna@unickz.com>, linux-kernel@vger.kernel.org
References: <434747C01D5AC443809D5FC5405011310970EA@bobcat.unickz.com> <434747C01D5AC443809D5FC540501131569A@bobcat.unickz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <434747C01D5AC443809D5FC540501131569A@bobcat.unickz.com>; from john@dnsworld.co.uk on Wed, Jun 04, 2003 at 11:44:17PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 11:44:17PM +0100, John Appleby wrote:
> 
> > > and I get nothing past "add_tail". I'd expect it to recognize my dev
> and
> > > attempt to connect to it.
> > 
> > Do you drop out the bottom of the function?  If you have no hardware
> ports
> > registered, I'd expect this to be the case.
> 
> Yeah; I thought though what I was doing was registering the port.
> 
> I'm clearly missing something really obvious here. Are you saying that I
> should have registered the port somewhere else?
> 
> Sorry for the dumb questions but there's no serio documentation yet hit
> the tree, I presume as it's pretty new for non-USB devices.

You need to register:

- serio device drivers (the things which drive the hardware) using
  serio_register_port()
- serio protocol drivers (the things which interpret the bytes,
  like atkbd.c) using serio_register_device()

So, for a PS/2 keyboard connected to a some special hardware interface,
you'd use atkbd.c which registers itself with serio using
serio_register_device().  Your device driver for the "special hardware"
registers itself with serio_register_port().

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

