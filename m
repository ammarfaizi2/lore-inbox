Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTDQTrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTDQTrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:47:10 -0400
Received: from fmr03.intel.com ([143.183.121.5]:43771 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S261970AbTDQTrF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:47:05 -0400
Message-ID: <A46BBDB345A7D5118EC90002A5072C780C26308A@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'karim@opersys.com'" <karim@opersys.com>,
       "'Martin Hicks'" <mort@wildopensource.com>
Cc: "'Daniel Stekloff'" <dsteklof@us.ibm.com>,
       "'Patrick Mochel'" <mochel@osdl.org>,
       "'Randy.Dunlap'" <rddunlap@osdl.org>, "'hpa@zytor.com'" <hpa@zytor.com>,
       "'pavel@ucw.cz'" <pavel@ucw.cz>,
       "'jes@wildopensource.com'" <jes@wildopensource.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'wildos@sgi.com'" <wildos@sgi.com>,
       "'Tom Zanussi'" <zanussi@us.ibm.com>
Subject: RE: [patch] printk subsystems
Date: Thu, 17 Apr 2003 12:58:48 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Karim Yaghmour [mailto:karim@opersys.com]
>
> I beg to differ. There's a point where we've got to stop saying "oh,
> this buffering mechanism is special and it requires its own code."
> relayfs is there to provide a unified light-weight mechanism for
> transfering large amounts of data from the kernel to user space.

But you don't need to provide buffers, because normally the data
is already in the kernel, so why need to copy it to another buffer
for delivery?

That's the point I tried to address with the kue patches I posted 
last week - once you have the data, wherever, you just queue it
for delivery, and provide the delivery subsystem for means to 
destroy it when it is delivered (and thus, not needed anymore)
[currently I only support kfree(), but I plan to add a destructor
function that at the same time can work as a callback for delivery].

This is where I think relayfs is doing too much, and that is the
reason why I implemented the kue stuff. It is very lightweight
and does almost the same [of course, it is not bidirectional, but
still nobody asked for that].

Cheers,

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own
(and my fault)
