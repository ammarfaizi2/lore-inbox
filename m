Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbULGAfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbULGAfh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 19:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbULGAfd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 19:35:33 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:34176
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S261716AbULGAf0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 19:35:26 -0500
Date: Mon, 6 Dec 2004 16:35:25 -0800
From: Phil Oester <kernel@linuxace.com>
To: shemminger@osdl.org, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Recent select() handling change breaks Poptop
Message-ID: <20041207003525.GA22933@linuxace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The recent changeset [1] dealing with blocking usage of select() seems
to break the Poptop PPTP server.

After upgrading from -rc2 to -rc3, I could no longer connect to a server
running PopTop.  Ended up reverting various -bk snapshots, and the breakage
was between -bk13 and -bk14.  Reverting this change to af_inet:

-       .poll =         datagram_poll,
+       .poll =         udp_poll,

makes the Poptop server work again.

Any ideas?

Phil


[1] http://linux.bkbits.net:8080/linux-2.5/cset@41ad55f4lM2IigkTUmtz82At8P3duA?nav=index.html|ChangeSet@-2w
