Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTFPEFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 00:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTFPEFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 00:05:45 -0400
Received: from hermes.cicese.mx ([158.97.1.34]:14227 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id S263315AbTFPEFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 00:05:43 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Serguei Miridonov <mirsev@cicese.mx>
Reply-To: mirsev@cicese.mx
To: linux-kernel@vger.kernel.org
Subject: Loosing timer interrupts with ACPI
Date: Sun, 15 Jun 2003 21:19:34 -0700
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200306152119.34118.mirsev@cicese.mx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When periodically reading /proc/acpi/battery/BAT0/info (once 
per second), running "adjtimex --compare=10000" indicates 
slight slowing down of the system clock. It seems that 
reading battery info may lead to loosing timer interrupts.

System: Compaq Presario 900Z notebook
Kernel: 2.4.21-ac1

First time the system clock drift was noticed when running 
akpi applet for KDE: ntpdate time corrections were too 
large. Then I've found that it happens when simply 

To test this, run

adjtimex --compare=10000

in first xterm, and the following script on another xterm:

#!/bin/sh

for i in `find /proc/acpi/battery -type f`
do
    echo $i
    count=0
    while [ $count -lt 30 ]
    do
        cat $i > /dev/null 2>/dev/null
        sleep 1
        count=$[count+1]
    done
done

Serguei Miridonov.

