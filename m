Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbWDFLii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbWDFLii (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 07:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWDFLii
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 07:38:38 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:6528 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751136AbWDFLih convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 07:38:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=b3MBTLumRW/3j8pLrpR9tEHzhA1ERJMEHq7kOG53hGrrzBLgbyO1eLWIiRPv0XQGBKCPRl6GkW2pEnDn6xa696oiIhYi8+ZH3SaUyQIXu5S0z6gZpTf3aXQ6OR2lk4Wi8xqqVilP5TMt1NtRBdEG4Kbzb2utUqtA8ToXBU1oAjU=
Message-ID: <c03109120604060438n58657c97iea4bfa5342747f18@mail.gmail.com>
Date: Thu, 6 Apr 2006 20:38:34 +0900
From: "Piotr Muszynski" <piotru@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: make *config problem (breaks miniconfig.sh)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There seems to be an error in config system, which I have discovered
while playing with miniconfig (it breaks miniconfig.sh in some cases).
miniconfig.sh workaround included at the end.

Spotted on 2.6.15.[1,2] and 2.6.16

How to trigger:
make menuconfig, change CONFIG_EXPERIMENTAL y --> n, save
$ cp .config .config_old
make menuconfig, change nothing, save
$ diff .config .config_old
4c4
< # Thu Apr  6 20:23:19 2006
---
> # Thu Apr  6 20:22:40 2006
157a158,160
> # CONFIG_FLATMEM_MANUAL is not set
> # CONFIG_DISCONTIGMEM_MANUAL is not set
> # CONFIG_SPARSEMEM_MANUAL is not set

I thought the .config shouldn't change... Is this a feature?

Workaround for miniconfig.sh:
$ diff -u miniconfig.sh-backup miniconfig.sh
--- miniconfig.sh-backup        2006-04-06 20:06:26.000000000 +0900
+++ miniconfig.sh       2006-04-06 20:07:10.000000000 +0900
@@ -15,6 +15,9 @@
   exit 1
 fi

+make allnoconfig KCONFIG_ALLCONFIG=$1 > /dev/null
+mv .config $1
+
 cp $1 mini.config
 echo "Calculating mini.config..."

Regards.
--
/*
 * Piotr Muszynski <piotru.org>
 */
