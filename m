Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932418AbVL1BBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932418AbVL1BBL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 20:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVL1BBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 20:01:11 -0500
Received: from jack.kinetikon.it ([62.152.125.81]:10158 "EHLO
	mail.towertech.it") by vger.kernel.org with ESMTP id S932418AbVL1BBL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 20:01:11 -0500
Date: Wed, 28 Dec 2005 02:01:55 +0100
From: Alessandro Zummo <alessandro.zummo@towertech.it>
To: linux-kernel@vger.kernel.org
Subject: [RFC] RTC subsystem, interrupt handling
Message-ID: <20051228020155.319f591e@inspiron>
Organization: Tower Technologies
X-Mailer: Sylpheed
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 No patches this time :)

 just a few questions... the original RTC driver
 supports user programmable interrupts
 via rtc_register/rtc_control/rtc_unregister.

 The only user in the kernel is the sound core.

 My RTC subsystem doesn't support this behaviour yet,
 so I was thinking about the best way to add it.

 Current code assumes there's only one rtc in the system
 while the new one must have a way to find a specific one.

 Would something like that be acceptable:

struct class_device *rtc_open(char *name)
{
        struct class_device *class_dev = NULL,
                                *class_dev_tmp;

        down(&rtc_class->sem);
        list_for_each_entry(class_dev_tmp, &rtc_class->children, node) {
                if (strncmp(class_dev_tmp->class_id, name, BUS_ID_SIZE) == 0) {
                        class_dev = class_dev_tmp;
                        break;
                }
        }
        up(&rtc_class->sem);

        return class_dev;
}

?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it

