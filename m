Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932725AbVJ3Fz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932725AbVJ3Fz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 01:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932733AbVJ3Fz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 01:55:58 -0400
Received: from smtp106.sbc.mail.re2.yahoo.com ([68.142.229.99]:63912 "HELO
	smtp106.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932725AbVJ3Fz6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 01:55:58 -0400
Message-ID: <43645DE8.6030207@gmail.com>
Date: Sun, 30 Oct 2005 00:45:12 -0500
From: Hareesh Nagarajan <hnagar2@gmail.com>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: register_filesystem(): Why does it return -EBUSY?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we have a look at the register_filesystem() function defined in 
fs/filesystems.c, we see that if a filesystem with a same name has 
already been registered then find_filesystem will return NON-NULL 
otherwise it will return NULL. So shouldn't 'res' be set to -EEXIST 
instead of -EBUSY? What is the reasoning behind register_filesystem 
returning -EBUSY for this particular condition?

int register_filesystem(struct file_system_type * fs) { ...
         struct file_system_type ** p;
	...
         p = find_filesystem(fs->name);
         if (*p)
                 res = -EBUSY; <-- Shouldn't this be -EEXIST?
         else
                 *p = fs;
	...
	return res;
}

Thanks,

Hareesh Nagarajan
