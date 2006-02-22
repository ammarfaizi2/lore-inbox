Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWBVOKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWBVOKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 09:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWBVOKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 09:10:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:384 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751289AbWBVOKG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 09:10:06 -0500
Date: Wed, 22 Feb 2006 15:10:05 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Mapping to 0x0
Message-ID: <Pine.LNX.4.61.0602221504120.11432@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,



from somewhere in my INBOX, this claim was made:

>> (also note that userland processes can map 0x00000000 and the kernel 
>> would jump to it ...)

In C code:

#include <sys/mman.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <stdio.h>
int main(void) {
    int fd   = open("badcode.bin", O_RDONLY);
    mmap(NULL, 4096, PROT_READ | PROT_EXEC, MAP_FIXED, fd, 0);
}

The mmap() usually succeeds and maps something at address 0x00000000. Now 
what if the kernel would try to execute this (of course badly programmed) 
code in the context of this very process?

    int (*callback)(int xyz) = NULL;
    callback();

Would not be the badcode be executed with kernel privileges?



Jan Engelhardt
-- 

