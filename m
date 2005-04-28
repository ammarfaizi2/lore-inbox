Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVD1Fot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVD1Fot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVD1Fot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:44:49 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:62629 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262045AbVD1Foq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:44:46 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>,
       Jean Delvare <khali@linux-fr.org>
Subject: [RFC/PATCH 0/5] read/write on attribute w/o show/store should return -ENOSYS
Date: Thu, 28 Apr 2005 00:30:09 -0500
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504280030.10214.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Jean Delvare has noticed that if a driver happens to declare its
attribute as RW but doesn't provide store() method attempt to write
into such attribute will cause spinning process as most of the
attribute implementations return 0 in case of missing store causing
endless retries. In some cases missing show/store will return -EPERM,
-EACCESS or -EINVAL.

I think we should unify implementations and have them all return -ENOSYS
(function not implemented) when corresponding method (show/store) is
missing.

-- 
Dmitry
