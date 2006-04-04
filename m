Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750796AbWDDSoi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWDDSoi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 14:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWDDSoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 14:44:38 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26895 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750800AbWDDSog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 14:44:36 -0400
Date: Tue, 4 Apr 2006 20:44:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Michael Buesch <mbuesch@freenet.de>
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       linville@tuxdriver.com
Subject: bcm43xx_sysfs.c: strange code
Message-ID: <20060404184435.GV6529@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Coverity checker spotted the following strange code:

<--  snip  -->

static ssize_t bcm43xx_attr_interfmode_show(struct device *dev,
                                            struct device_attribute *attr,
                                            char *buf)
{
...
        err = 0;

        bcm43xx_unlock(bcm, flags);

        return err ? err : count;

}
...
static ssize_t bcm43xx_attr_preamble_show(struct device *dev,
                                          struct device_attribute *attr,
                                          char *buf)
{
...
        err = 0;
        bcm43xx_unlock(bcm, flags);

        return err ? err : count;
}
...
static ssize_t bcm43xx_attr_preamble_store(struct device *dev,
                                           struct device_attribute *attr,
                                           const char *buf, size_t count)
{
...
        err = 0;
        bcm43xx_unlock(bcm, flags);

        return err ? err : count;
}
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

