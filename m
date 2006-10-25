Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423025AbWJYIqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423025AbWJYIqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 04:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423059AbWJYIqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 04:46:19 -0400
Received: from ns.virtuo.it ([88.149.128.9]:17561 "EHLO agnus.ngi.it")
	by vger.kernel.org with ESMTP id S1423025AbWJYIqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 04:46:19 -0400
Message-ID: <453F2454.1000707@webster.it>
Date: Wed, 25 Oct 2006 10:46:12 +0200
From: "David N. Welton" <d.welton@webster.it>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: bdurrett@slick.ORG
CC: linux-kernel@vger.kernel.org
Subject: megaraid_sas waiting for command and then offline
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found someone corresponding to your name writing about a problem with
the megaraid sas driver/hardware on the LKML:

http://lkml.org/lkml/2006/9/6/12

We have a Dell (2950, running 2.6.18 #1 SMP) as well, and the way I
managed to kill the thing dead in its tracks (symptoms basically what
you you describe) is with smartctl:

root@salgari:~# smartctl --all /dev/sda
smartctl version 5.34 [i686-pc-linux-gnu] Copyright (C) 2002-5 Bruce Allen
Home page is http://smartmontools.sourceforge.net/

Device: DELL     PERC 5/i         Version: 1.00
Device type: disk
Local Time is: Wed Oct 25 10:14:40 2006 CEST
Device does not support SMART

Error Counter logging not supported


Device does not support Self Test logging

----

[61101.681857] sd 0:2:0:0: rejecting I/O to offline device
[61101.681944] EXT3-fs error (device sda1): ext3_readdir: directory
#7553069 contains a hole at offset 0
[61103.944794] sd 0:2:0:0: rejecting I/O to offline device
[61103.944879] EXT3-fs error (device sda1): ext3_readdir: directory
#7553069 contains a hole at offset 0
[61104.672212] sd 0:2:0:0: rejecting I/O to offline device
[61104.672295] EXT3-fs error (device sda1): ext3_readdir: directory
#7553069 contains a hole at offset 0
[61105.255981] sd 0:2:0:0: rejecting I/O to offline device
[61105.256066] EXT3-fs error (device sda1): ext3_readdir: directory
#7553069 contains a hole at offset 0

----

Dead in the water.  We suspect that in any case there are some disk
problems, which is why we were trying to use smartctl in the first place.

I was just curious if you managed to figure anything out...

Thanks,
Dave Welton
-- 
Webster srl
Sede legale:
Via del Seminario, 3 35122 Padova
Sede operativa:
Via S. Breda, 28 35010 Limena (PD)

Tel. +39 049 8842188
Email: d.welton@webster.it

Visita www.webster.it
