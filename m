Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262967AbTDNLYB (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 07:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbTDNLYB (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 07:24:01 -0400
Received: from codeblau.walledcity.de ([212.84.209.34]:12041 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S262967AbTDNLYA (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 07:24:00 -0400
Date: Mon, 14 Apr 2003 13:35:54 +0200
From: Felix von Leitner <felix-kernel@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: kernel ipv6 freeze
Message-ID: <20030414113554.GA4898@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel 2.5.66 can be made to freeze with ipv6 when npush and npoll are
run on the same machine at the same time.  Both are from the same
package, ncp (http://www.fefe.de/ncp/).

  - npush opens an ipv6 multicast socket and sends announcement UDP
    packets over it.  It also opens a TCP listening socket.
  - npoll listens for the UDP announcement packets and TCP connects to
    the TCP socket using the sockaddr_in6 from the UDP announcements.

Linux 2.4 always had issues with this because npoll would see the
interface number as the loopback device, but the IPv6 number as the
ethernet link local or announced number, and the connect would fail or
time out.  Linux 2.5 completely locks up.

Please fix!

Felix
