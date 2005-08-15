Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVHOOMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVHOOMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 10:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVHOOME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 10:12:04 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:26262 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964782AbVHOOMD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 10:12:03 -0400
Subject: uart_port structure in serial8250_port[i]  doesn't have the
	port_type values
From: "V. Ananda Krishnan" <mansarov@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: rmk+lkml@arm.linux.org.uk, gregkh@suse.de
Content-Type: text/plain
Date: Mon, 15 Aug 2005 09:10:56 -0500
Message-Id: <1124115056.3694.27.camel@siliver.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-16) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  The problem described here is related to the 8250_pci driver in
2.6.12.3/2.6.12.4 kernels. When 8250_pci device driver detects a serial
port pci device and sets up the default setup (8250_pci.c), it tries to
find a match or unused port (serial8250_find_match_or_unused proc in in
8250.c). This leads to the uart_match_port with one of the parameters as
serial8250_ports[i].port. During debugging, I noticed that the none of
elements of the serial8250_ports[i].port.type was having any port value.
So the serial8250_register_port fails and the device driver module fails
to load. In this scenario, the last resort to find any entry which
doesn't have a real port associated with it also fails, because of the
null value in the serial8250_ports[i].port.type.  I would like to know
when the port.type values in uart_8250_port strucutre (in
serial8250_ports[i]) is populated? Is there anything missing in the
serial8250_find_match_or_unused codes?  Any help to degug this problem
is appreciated. Thanks.

V.Ananda Krishnan


