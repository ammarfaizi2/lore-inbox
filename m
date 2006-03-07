Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752501AbWCGMeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbWCGMeO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 07:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752502AbWCGMeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 07:34:14 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:60061 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752501AbWCGMeN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 07:34:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ReTG243nTIKMpI7UNGtUWbbpkOFYh9DXM9X54K6J83CyXttwGGV3vhYK9iTNbzAQqy6ZyY5STyDQtPnXZRVQ6BMsLYnpXtiiR9VQKWCE1Cv8ELEY1Z06p1M/0j+hj0NGUIGGMlKMZg7R6rphYTFsTh3oC4+NGyVNbttW35PCMp4=
Message-ID: <aec7e5c30603070434j7f326ad2r5f1b0e8046870941@mail.gmail.com>
Date: Tue, 7 Mar 2006 21:34:11 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: SMP and 101% cpu max?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

I'm doing some memory related hacking, and part of that is testing the
current behaviour of the Linux VM. This testing involves running some
simple tests (building the linux kernel is one of the tests) while
varying the amount of RAM available to the kernel.

I've tested memory configurations of 64MB, 128MB and 256MB on a Dual
PIII machine. The tested kernel is 2.6.16-rc5, and user space is based
on debian-3.1. I run 5 tests per memory configuration, and the machine
is rebooted between each test.

Problem:

With 128MB and 256MB configurations, a majority of the tests never
make it over 101% CPU usage when I run "make -j 2 bzImage", building a
allnoconfig kernel. With 64MB memory, everything seems to be working
as expected. Also, running "make bzImage" works as expected too.

Results for "make bzImage":

# time: real user sys, cpu: percentage, ram: KB, swap: KB

time: 229.261 211.6 18.18, cpu: 100, ram: 256716, swap: 125944
time: 229.621 211.45 17.51, cpu: 100, ram: 256716, swap: 125944
time: 229.698 212.11 17.68, cpu: 100, ram: 256716, swap: 125944
time: 230.711 211.89 17.86, cpu: 100, ram: 256716, swap: 125944
time: 232.219 210.55 18.5, cpu: 99, ram: 256716, swap: 125944
time: 233.203 213.34 17.79, cpu: 99, ram: 126876, swap: 125944
time: 233.371 213.82 17.15, cpu: 99, ram: 126876, swap: 125944
time: 234.18 213.43 17.92, cpu: 99, ram: 126876, swap: 125944
time: 234.315 213.11 17.92, cpu: 99, ram: 126876, swap: 125944
time: 235.334 215.06 17.22, cpu: 99, ram: 126876, swap: 125944
time: 241.159 222.82 15.38, cpu: 99, ram: 61956, swap: 125944
time: 241.299 222.39 15.34, cpu: 99, ram: 61956, swap: 125944
time: 241.475 223.16 15.38, cpu: 99, ram: 61956, swap: 125944
time: 241.955 223.24 15.66, cpu: 99, ram: 61956, swap: 125944
time: 242.099 222.92 15.98, cpu: 99, ram: 61956, swap: 125944

Results for "make -j 2 bzImage":

# time: real user sys, cpu: percentage, ram: KB, swap: KB

time: 124.336 220.03 18.98, cpu: 192, ram: 126876, swap: 125944
time: 124.547 217.57 19.15, cpu: 190, ram: 256716, swap: 125944
time: 125.162 218.35 19.51, cpu: 190, ram: 256716, swap: 125944
time: 132.488 228.71 17.1, cpu: 186, ram: 61956, swap: 125944
time: 132.502 230.93 16.26, cpu: 187, ram: 61956, swap: 125944
time: 132.634 230.55 16.42, cpu: 186, ram: 61956, swap: 125944
time: 132.643 229.89 17.63, cpu: 187, ram: 61956, swap: 125944
time: 133.2 230.09 16.28, cpu: 185, ram: 61956, swap: 125944
time: 227.371 211.45 17.36, cpu: 101, ram: 256716, swap: 125944
time: 227.898 211.93 17.3, cpu: 101, ram: 256716, swap: 125944
time: 228.071 212.21 17.15, cpu: 101, ram: 256716, swap: 125944
time: 228.788 212.46 17.88, cpu: 101, ram: 126876, swap: 125944
time: 229.223 214.14 16.46, cpu: 101, ram: 126876, swap: 125944
time: 229.255 213.56 17.19, cpu: 101, ram: 126876, swap: 125944
time: 230.296 214.25 17.44, cpu: 101, ram: 126876, swap: 125944

Any ideas what is causing this? Is it a memory subsystem issue, or cpu
scheduling?

Thanks,

/ magnus
