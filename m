Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTJCWOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTJCWOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:14:54 -0400
Received: from relay1.eltel.net ([195.209.236.38]:38093 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S261332AbTJCWOw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:14:52 -0400
Date: Sat, 4 Oct 2003 02:15:35 +0400
From: Andrew Zabolotny <zap@homelink.ru>
To: linux-kernel@vger.kernel.org
Subject: A bug (and a fix) in usbserial.c, kernel 2.4.22
Message-Id: <20031004021535.7a92476e.zap@homelink.ru>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I was using the usbserial driver to connect to my PDA and was quite
surprised when I have seen kernel oops messages in /var/log/messages
after I disconnect my PDA.

A examination of /proc/kcore shown that the bug happens in line 1408 of
usbserial.c, here is a extract:

if (port->tty != NULL) {
  while (port->open_count > 0) {
    __serial_close(port, NULL);
  }
  port->tty->driver_data = NULL;
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ this is the line that oopses.
}

The __serial_close function is setting port->tty to NULL, so the
solution is to remove either the line 559:

...
port->open_count = 0;
port->tty = NULL;
...

or line 1408 (which seems a better solution to me).

--
Greetings,
   Andrew
