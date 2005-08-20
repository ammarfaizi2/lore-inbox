Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932651AbVHTRqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbVHTRqz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 13:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932654AbVHTRqz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 13:46:55 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:23206 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP id S932651AbVHTRqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 13:46:54 -0400
X-ORBL: [69.107.75.50]
Date: Sat, 20 Aug 2005 10:46:48 -0700
From: David Brownell <david-b@pacbell.net>
To: Nathan Lutchansky <lutchann@litech.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] improve i2c probing
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050820174648.650B8E3259@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, some of this resembles my prototype from last month:

   http://lists.lm-sensors.org/pipermail/lm-sensors/2005-July/013012.html

Both ended up with new driver probe() methods attaching to *devices* not
to busses, and used the probe signature the i2c core already handles.
That helps eliminate one of the surprises hitting anyone starting to use
the I2C driver stack.  But not the more fundamental one...

What would you think about actually making I2C probing work more like
standard driver model probing, instead?  That is, have the probe method
signature look like this:

    int probe(struct i2c_client *dev, void *driver_data)

In normal driver model usage, infrastructure creates the devices, and the
device drivers just bind to them.  But I2C doesn't support that even for
the submodel where it's very appropriate:  devices that have been probed,
or which (as with platform_bus) were explicitly declared to exist.

I2C drivers would either continue the old school way ... or could start
acting more like they do in other mainstream Linux driver frameworks.

- Dave


