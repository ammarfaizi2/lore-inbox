Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263685AbTIBKmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 06:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbTIBKmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 06:42:32 -0400
Received: from londo.lunn.ch ([80.238.139.98]:9451 "EHLO londo.lunn.ch")
	by vger.kernel.org with ESMTP id S263685AbTIBKmR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 06:42:17 -0400
Date: Tue, 2 Sep 2003 12:42:12 +0200
To: linux-kernel@vger.kernel.org
Cc: andrew.lunn@ascom.ch
Subject: 2.6-test4 Traditional pty and devfs
Message-ID: <20030902104212.GA23978@londo.lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Andrew Lunn <andrew@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Folks

http://bugme.osdl.org/show_bug.cgi?id=1045

I found that devfs and traditional pty's don't work properly with
2.6-test4 and a lot of previous versions. Note im talking about
traditional pty's not UNIX98 which need devpts mounted.

The pty slave devices do not appear in devfs. They should be
/dev/pts/s* and symbolic links from /dev/pty* into /dev/pts/s*. But
these are all missing. So programs like ripperx which use a pty to
control cdparanoia don't work.

I've attached two possible patches to the bugzilla bug. The first one
causes the slave devices to be created in devfs at start up. The
second one makes it work more like 2.4 when the slave device is only
created when the master device is opened.

Both patches suffer from a problem. The slave is always only RW
root. 2.4 sets the owner of the slave to that of the process opening
the master. I cannot see a way to make this happen with 2.6-test. 

Im open for suggestions as to the correct way to fix this.

   Thanks
        Andrew
