Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262531AbVF1E5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262531AbVF1E5A (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 00:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVF1E5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 00:57:00 -0400
Received: from smtp107.sbc.mail.re2.yahoo.com ([68.142.229.98]:27239 "HELO
	smtp107.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262531AbVF1E4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 00:56:55 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: pcmcia: release_class patch concern
Date: Mon, 27 Jun 2005 23:56:49 -0500
User-Agent: KMail/1.8.1
Cc: LKML <linux-kernel@vger.kernel.org>, linux-pcmcia@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506272356.50029.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dominik,

I noticed that Linus committed the patch from you that introduces waiting
for completion in module's exit routine. I believe it is a big no-no as
something like this will wedge the kernel:

	rmmod <module> < /sys/path/to/devices/attribute

Have you considered using Greg's class_create()/class_destroy() or maybe
bumping up module's refrerence count when registering class devices so
rmmod would fail if there are users of this module?

-- 
Dmitry
