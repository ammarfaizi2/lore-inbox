Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264448AbTGWOQb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 10:16:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270352AbTGWOQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 10:16:30 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:30200 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S264448AbTGWOPw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 10:15:52 -0400
Subject: Re: Accessing serial port from kernel module
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Kurt =?ISO-8859-1?Q?H=E4usler?= <Kurt@fub-group.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <8FB92279C69C2944B325B4BD227401790156B8@nt-server.danziger.local>
References: <8FB92279C69C2944B325B4BD227401790156B8@nt-server.danziger.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1058970342.5520.74.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jul 2003 15:25:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-23 at 15:15, Kurt Häusler wrote:
> What is the preferred way in Linux for my module to open the serial port device such as /dev/ttyS1.

Make your driver a line discipline is the normal approach in this case
(ok to be fair putting it all in user space is the normal case). Take a
look at slip.c to see how slip sits above terminal interfaces.

The user space only approach is to use pty/tty pairs as things like
xterm do. This gives you a "terminal/serial" device the other end of
which is your user space program which can do the conversions it wants
then talk to a real serial port

