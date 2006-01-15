Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWAOCLl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWAOCLl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 21:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWAOCLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 21:11:41 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:56515 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1751654AbWAOCLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 21:11:40 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Suggested janitor task - remove __init/__exit from function prototypes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 13:11:35 +1100
Message-ID: <31582.1137291095@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some function prototypes (in both .h and .c files) specify attributes
like __init and __exit in the prototype.  gcc (at least at 3.3.3) uses
the last such attribute that is actually specified, without issuing a
warning.  So we can have :-

* Prototype declarations that use one attribute and a function body
  that uses another attribute.

* Functions that from the .c code appear to be normal text but the .h
  file is silently setting a special attribute.

Both are potential sources of programmer confusion or bugs.  I suggest
a janitor task to find all function prototypes that use __init, __exit,
__devinit, __devexit, __cpuinit or __cpuexit and remove the attribute
from the prototype.  If the function body does not already specify a
suitable attribute then add the attribute to the function body.

The same task could be done for extern data declarations.

Once that is done, remove #include <linux/init.h> from all .h files.
Only .[cS] files should specify which section the data and text are
stored in, .h files should only define the C language information.

