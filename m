Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTBONCY>; Sat, 15 Feb 2003 08:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTBONCY>; Sat, 15 Feb 2003 08:02:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17682 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261934AbTBONCX>; Sat, 15 Feb 2003 08:02:23 -0500
Date: Sat, 15 Feb 2003 13:12:13 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, dahinds@users.sourceforge.net, davej@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       pcmcia-cs-devel@lists.sourceforge.net, linux-pcmcia@lists.infradead.org
Subject: Re: [PATCH 2.5.61] pcmcia: add device_class pcmcia_socket, update devices & drivers
Message-ID: <20030215131213.A26902@flint.arm.linux.org.uk>
Mail-Followup-To: Dominik Brodowski <linux@brodo.de>,
	torvalds@transmeta.com, dahinds@users.sourceforge.net,
	davej@suse.de, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org, pcmcia-cs-devel@lists.sourceforge.net,
	linux-pcmcia@lists.infradead.org
References: <20030215123308.GA1073@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030215123308.GA1073@brodo.de>; from linux@brodo.de on Sat, Feb 15, 2003 at 01:33:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2003 at 01:33:09PM +0100, Dominik Brodowski wrote:
> A new device_class "pcmcia_socket_class" is introduced for PCMCIA and
> CardBus sockets. All socket drivers I could find are updated so that they
> register a driver, and -if necessary- the "platform"/legacy device. This
> will allow for a cleanup of pcmcia_{un}register_socket() / 
> {un}register_ss_entry() as well as reflect the parent for pcmcia_bus 
> devices.
> +
> +static struct platform_device sa1100_pcmcia_device = {
> +	.name = "sa1100_pcmcia",
> +	.id = 0,
> +	.dev = {
> +		.name = "sa1100_pcmcia",
> +	},
> +};
> +

This probably isn't the best way to handle this - the sa1100 device driver
is actually a generic driver to couple to GPIO-based PCMCIA implementations,
which includes the sa1111 stuff.  The sa1111 stuff itself registers with
sysfs.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

