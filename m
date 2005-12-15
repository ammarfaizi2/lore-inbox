Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161013AbVLODqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161013AbVLODqy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 22:46:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbVLODqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 22:46:53 -0500
Received: from femail.waymark.net ([206.176.148.84]:37079 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S1161013AbVLODqv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 22:46:51 -0500
Date: 15 Dec 2005 03:37:42 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: Re: [SERIAL, -mm] CRC failure
To: linux-kernel@vger.kernel.org
In-Reply-To: <43A018E4.2090907@ums.usu.ru>
Message-ID: <c03f0c.8eacb5@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> In article 14 Dec 05  18:06:44, patrakov@ wrote to Kenneth Parrish <=-

 pa> Does the error rate vary if you run a CPU hog (e.g. cat
 pa> /dev/urandom
 >/dev/null) or glxgears in parallel to minicom?
The system has been idle. Increasing the load should worsen the errors,
but they're pretty frequent so i might not see.
The computer's ISA-PNP Crystal Sound CS4235 soldered onto the
motherboard sounds best with the main pci latency timer set to 0, but
this gives serial overruns, so i've made a small 'mon', or modem on,
script to reset this:

# mon
/etc/rc.d/rc.acpidyn-modem restart
/sbin/setpci -v -s 00:00.0 LATENCY_TIMER=20

and another for when the modem's not needed, 'moff'

# moff
/etc/rc.d/rc.acpidyn restart
/sbin/setpci -v -s 00:00.0 LATENCY_TIMER=0
/sbin/rmmod 8250 serial_core

and this seems to work well.  The sound worsens as you increase the
00:00.0 LATENCY_TIMER.

... Arno's firewall: http://rocky.eld.leidenuniv.nl/
--- MultiMail/Linux v0.46
