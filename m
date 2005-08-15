Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbVHOOwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbVHOOwm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 10:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVHOOwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 10:52:42 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:36360 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964800AbVHOOwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 10:52:41 -0400
Date: Mon, 15 Aug 2005 15:52:32 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: uart_port structure in serial8250_port[i]  doesn't have the port_type values
Message-ID: <20050815155232.B30479@flint.arm.linux.org.uk>
Mail-Followup-To: "V. Ananda Krishnan" <mansarov@us.ibm.com>,
	linux-kernel@vger.kernel.org, gregkh@suse.de
References: <1124115056.3694.27.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1124115056.3694.27.camel@siliver.austin.ibm.com>; from mansarov@us.ibm.com on Mon, Aug 15, 2005 at 09:10:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 09:10:56AM -0500, V. Ananda Krishnan wrote:
>   The problem described here is related to the 8250_pci driver in
> 2.6.12.3/2.6.12.4 kernels. When 8250_pci device driver detects a serial
> port pci device and sets up the default setup (8250_pci.c), it tries to
> find a match or unused port (serial8250_find_match_or_unused proc in in
> 8250.c).
> 
> This leads to the uart_match_port with one of the parameters as
> serial8250_ports[i].port. During debugging, I noticed that the none of
> elements of the serial8250_ports[i].port.type was having any port value.

Every variable has a value.  In this case, they start off as PORT_UNKNOWN
as expected.

> So the serial8250_register_port fails and the device driver module fails
> to load.

I don't follow you here - failure of this function is not dependent on
port.type being PORT_UNKNOWN.

> In this scenario, the last resort to find any entry which
> doesn't have a real port associated with it also fails, because of the
> null value in the serial8250_ports[i].port.type.

Again I don't follow you here.

The only reason serial8250_find_match_or_unused() will return NULL is
if all registered port entries correspond with real hardware ports.
In that case, the solution is to increase the number of 8250 ports
via the kernels configuration.

> I would like to know when the port.type values in uart_8250_port structure
> (in serial8250_ports[i]) is populated? Is there anything missing in the
> serial8250_find_match_or_unused codes?  Any help to degug this problem
> is appreciated. Thanks.

They're set to something other than PORT_UNKNOWN when a port is
discovered via serial8250_register_port() / uart_add_one_port().

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
