Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbTDVJbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 05:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263032AbTDVJbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 05:31:00 -0400
Received: from port-212-202-172-137.reverse.qdsl-home.de ([212.202.172.137]:60551
	"EHLO jackson.localnet") by vger.kernel.org with ESMTP
	id S263026AbTDVJa7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 05:30:59 -0400
Date: Tue, 22 Apr 2003 11:46:14 +0200 (CEST)
Message-Id: <20030422.114614.846960661.rene.rebe@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: mangled isapnp IDs in /proc/bus/isapnp/devices
From: Rene Rebe <rene.rebe@gmx.net>
X-Mailer: Mew version 3.1 on XEmacs 21.4.12 (Portable Code)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *197uM2-0007Qt-LT*uMhWHnzaa3I*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

is there a reason why the isapnp device id are mangled this way:

drivers/pnp/isapnp_proc.c

static void isapnp_devid(char *str, unsigned short vendor, unsigned short device)
{
        sprintf(str, "%c%c%c%x%x%x%x",
                        'A' + ((vendor >> 2) & 0x3f) - 1,
                        'A' + (((vendor & 3) << 3) | ((vendor >> 13) & 7)) - 1,
                        'A' + ((vendor >> 8) & 0x1f) - 1,
                        (device >> 4) & 0x0f,
                        device & 0x0f,
                        (device >> 12) & 0x0f,
                        (device >> 8) & 0x0f);
}

This results in output like:

CSCd937 CSC0000

Which I have to un-mangle ... :-( What is the reason for not outputting
simple hex?

Sincerely,
- René

--  
René Rebe - Europe/Germany/Berlin
e-mail:   rene@rocklinux.org, rene.rebe@gmx.net
web:      http://www.rocklinux.org/people/rene http://gsmp.tfh-berlin.de/rene/

Anyone sending unwanted advertising e-mail to this address will be
charged $25 for network traffic and computing time. By extracting my
address from this message or its header, you agree to these terms.
