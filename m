Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750927AbWG0RuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbWG0RuH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWG0RuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:50:07 -0400
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:60426 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1750927AbWG0RuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:50:06 -0400
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: linux-kernel@vger.kernel.org
Subject: request_irq() return value
Date: Thu, 27 Jul 2006 19:50:03 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607271950.03370.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I'm looking at the source code of different drivers and wondering about 
request_irq() return value. It is used mostly in 'open' routine of struct 
net_device. If request_irq() fails some drivers return -EAGAIN, some -EBUSY 
and some the return value of request_irq(). Is this intentional? Sample 
drivers code:

8139cp.c:
static int cp_open (struct net_device *dev) {
        ...
        rc = request_irq(dev->irq, cp_interrupt, SA_SHIRQ, dev->name, dev);
        if (rc)
                goto err_out_hw;
        ...
err_out_hw:
        ...
        return rc;
}

3c359.c:
static int xl_open(struct net_device *dev){
        ...
        if(request_irq(dev->irq, &xl_interrupt, SA_SHIRQ , "3c359", dev)) {
                return -EAGAIN;
        }
        ...
}

Besides request_irq() is arch dependent so depending on arch it has different 
set of possible return values. So ... does the return value matter or I 
misunderstood something here?

Regards,

	Mariusz
