Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262284AbTFFVZC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 17:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262285AbTFFVZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 17:25:02 -0400
Received: from mail331.mail.bellsouth.net ([205.152.58.209]:37429 "EHLO
	imf31bis.bellsouth.net") by vger.kernel.org with ESMTP
	id S262284AbTFFVZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 17:25:01 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: <linux-kernel@vger.kernel.org>
Subject: Is there a bug with su, and /dev/std*?
Date: Fri, 6 Jun 2003 17:38:33 -0400
User-Agent: KMail/1.5.2
References: <Pine.SOL.4.30.0306062228140.13809-100000@mion.elka.pw.edu.pl>
In-Reply-To: <Pine.SOL.4.30.0306062228140.13809-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306061738.33612.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I was writing a script that writes to /dev/error, and I'm experiencing odd behavior.  This is with a 2.4.18 kernel.

	I login to an account, 'jcw'.

	[jcw@drive jcw]$ echo test_msg >/dev/error
        test_msg
	[jcw@drive jcw]$ su - slimedr
        Password:
        [slimedr@drive jcw]$ echo test_msg >/dev/error
	bash: /dev/stderr: Permission denied

	As user 'jcw' we see

	[jcw@drive jcw]$ ls -l /dev/stderr
	lrwxrwxrwx    1 root     root           17 Mar 11 15:28 /dev/stderr -> ../proc/self/fd/2
	[jcw@drive jcw]$ ls -l /proc/self/fd/2
	lrwx------    1 jcw      jcw            64 Jun  6 17:31 /proc/self/fd/2 -> /dev/pts/5
	
	As user 'slimedr' we see

	[slimedr@drive slimedr]$ ls -l /dev/stderr
	lrwxrwxrwx    1 root     root           17 Mar 11 15:28 /dev/stderr -> ../proc/self/fd/2
	[slimedr@drive slimedr]$ ls -l /proc/self/fd/2
	lrwx------    1 slimedr  slimedr        64 Jun  6 17:34 /proc/self/fd/2 -> /dev/pts/5

	So what gives?  Shouldn't the user context change with 'su -' allow me to write to /dev/stderr and /dev/stdout?

