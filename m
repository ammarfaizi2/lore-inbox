Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbULJPTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbULJPTm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:19:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261676AbULJPTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:19:42 -0500
Received: from [61.48.53.158] ([61.48.53.158]:25059 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261661AbULJPTj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:19:39 -0500
Date: Fri, 10 Dec 2004 23:15:28 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412101515.iBAFFSR02071@freya.yggdrasil.com>
To: greg@kroah.com
Subject: Re: [Patch]Memory leak in sysfs
Cc: linux-kernel@vger.kernel.org, maneesh@in.ibm.com, nanhai.zou@intel.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
>And, do you have a pointer to your stress tests?  I'd love to add stuff
>like this to an automated testing framework (I know OSDL has one, and
>IBM has one internally.)

	This is just something that Maneesh had suggested.  My
script runs the commands in separate xterms just so the output
is clearer.
                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


#!/bin/sh

mount -t sysfs x /sys

xterm -geometry 80x10 -title 'cat /sys/class/net/...' \
	-e 'sleep 1 ; while true ; do find /sys/class/net -type f | xargs cat ; done' &

xterm -geometry 80x10 -title '{modprobe,rmmod} dummy' \
	-e 'sleep 1 ; while true ; do modprobe dummy ; rmmod dummy ; done' &

xterm -geometry 80x10 -title 'ls -lR /sys' \
	-e 'sleep 1 ; while true ; do ls -lR /sys ; done' &

wait
