Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVAMWR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVAMWR6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 17:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbVAMWPB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 17:15:01 -0500
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:5636 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261777AbVAMWHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 17:07:08 -0500
Date: Thu, 13 Jan 2005 23:09:31 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: I2C_TIMEOUT
Message-Id: <20050113230931.2b492b52.khali@linux-fr.org>
In-Reply-To: <9ACC0FE8-65AC-11D9-B612-000393DBC2E8@freescale.com>
References: <9ACC0FE8-65AC-11D9-B612-000393DBC2E8@freescale.com>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kumar,

> What is the intended purpose of the I2C_TIMEOUT cmd?  It clearly sets 
> the adapter timeout, I'm just trying to understand if there is a 
> standard usage for the adapter's timeout.

An adapter's timeout is supposedly the time the adapter driver will wait
for a client to answer before giving up. As far as I can see, most SMBus
master drivers do *not* properly use this, ie they use a local variable
instead of the i2c_adapter struct member, so you cannot use the command
to change their default timeout value. Some other bus drivers (most
notably all i2c-algo-bit-based ones, but also i2c-iop3xx and
i2c-ibm_iic.c) do properly use the timeout member so the command should
work for them.

Note that I never saw the command used. Where it would make the more
sense is from user-space through i2c-dev, but even then I believe that
everyone is just happy with the default timeouts the bus drivers come
with.

Hope that helps,
-- 
Jean Delvare
http://khali.linux-fr.org/
