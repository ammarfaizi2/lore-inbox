Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264841AbUDWPgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264841AbUDWPgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 11:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264845AbUDWPgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 11:36:09 -0400
Received: from 242.168-182-adsl-pool.axelero.hu ([81.182.168.242]:10368 "EHLO
	vigo.sygma.net") by vger.kernel.org with ESMTP id S264841AbUDWPgG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 11:36:06 -0400
Date: Fri, 23 Apr 2004 17:41:52 +0200 (CEST)
From: =?ISO-8859-1?Q?Szima_G=E1bor?= <sygma@tesla.hu>
X-X-Sender: sygma@vigo.sygma.net
To: linux-kernel@vger.kernel.org
Subject: XFS fsync() doesn't work under 2.4.26
Message-ID: <Pine.LNX.4.50.0404231702410.1163-100000@vigo.sygma.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

fsync() take no effect on XFS filesystem under Linux kernel 2.4.26.

Simple open-write-fsync-close test:

ltrace -t /tmp/synctest:
...
  0.002144 write(3, "", 1048576)                  = 1048576
  0.002150 write(3, "", 1048576)                  = 1048576
  0.002154 fsync(3, 0xbfeff684, 0x00100000, 0, 0) = 0
  0.015962 close(3)                               = 0
  ^^^^^^^^

(64 x 1 MB data, ~8 MB/s disk write speed)


Under 2.4.25 or on other fs working fine:
...
  0.002149 write(3, "", 1048576)                  = 1048576
  0.002744 write(3, "", 1048576)                  = 1048576
  0.002188 fsync(3, 0xbfeff664, 0x00100000, 0, 0) = 0
  8.048844 close(3)                               = 0
  ^^^^^^^^

System:
Linux 2.4.26 (gcc-3.3.3), SuSE 7.3
Asus A7N8X, Adaptec 29160 (7892A), WD Enterprise 4360
(WDE4360-1808A2)



								-Sygma
