Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261479AbUCDGev (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 01:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbUCDGev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 01:34:51 -0500
Received: from sitemail3.everyone.net ([216.200.145.37]:34688 "EHLO
	omta06.mta.everyone.net") by vger.kernel.org with ESMTP
	id S261479AbUCDGet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 01:34:49 -0500
X-Eon-Sig: AQHOS7NARs4ITO7iiAIAAAAC,4bdaa326c373b6c01039e5979d37154f
Date: Thu, 4 Mar 2004 01:34:46 -0500
From: "Kevin O'Connor" <kevin@koconnor.net>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: i2c_use_client broken
Message-ID: <20040304063446.GA19655@arizona.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

In 2.6.3's i2c-core.c there is the following code:

static int i2c_inc_use_client(struct i2c_client *client)
{

        if (!try_module_get(client->driver->owner))
                return -ENODEV;
        if (!try_module_get(client->adapter->owner)) {
                module_put(client->driver->owner);
                return -ENODEV;
        }

        return 0;
}
[...]
int i2c_use_client(struct i2c_client *client)
{
        if (!i2c_inc_use_client(client))
                return -ENODEV;
[...]

The i2c_inc_use_client test looks backward - the code should look like:

        if (i2c_inc_use_client(client))
                return -ENODEV;

because i2c_inc_use_client returns 0 on success.

If I've missed something, please let me know.  I apologize if you're not
the right person to mail or if this has already been fixed.

-Kevin

-- 
 ---------------------------------------------------------------------
 | Kevin O'Connor                  "BTW, IMHO we need a FAQ for      |
 | kevin@koconnor.net               'IMHO', 'FAQ', 'BTW', etc. !"    |
 ---------------------------------------------------------------------
