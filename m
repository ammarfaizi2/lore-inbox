Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262563AbVAPSoa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVAPSoa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 13:44:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVAPSoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 13:44:30 -0500
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:40717 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S262563AbVAPSoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 13:44:24 -0500
Date: Sun, 16 Jan 2005 19:46:53 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       LM Sensors <sensors@stimpy.netroedge.com>
Subject: [PATCH 2.6] I2C: Kill i2c_client.id
Message-Id: <20050116194653.17c96499.khali@linux-fr.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As discussed earlier on the LKML [1], here comes a patch set killing the
id member of the i2c_client structure. Let me recap my main reasons for
doing so:

1* A client is already uniquely identified by the combination of the
number of the bus it sits on and the address it is located at on this
bus.

2* The i2c core doesn't make use of this struct member. Such an id, if
needed, would thus be private data and as such would belong to the data
member. In fact, none of the drivers using this field really needs it as
far as I could see.

Killing that useless struct member will let us save some memory and kill
some useless code (not much, admittedly).

I will send 5 different patches, to be applied in order, although
nothing critical will happen if applied in a different order. In each
patch, most chucks are themselves independent from each other, so if any
is rejected or delayed for some reason, the rest can still be applied.

(1/5) Stop using i2c_client.id in i2c/chips drivers (mostly hardware
      monitoring drivers).
(2/5) Stop using i2c_client.id in media/video drivers.
(3/5) Stop using i2c_client.id in misc drivers.
(4/5) Deprecate i2c_client.id.
(5/5) Documentation update.

Thanks.

[1] http://lkml.org/lkml/2004/12/27/132

-- 
Jean Delvare
http://khali.linux-fr.org/
