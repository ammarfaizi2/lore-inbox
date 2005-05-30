Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVE3UwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVE3UwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 16:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVE3UwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 16:52:25 -0400
Received: from out4.prserv.net ([32.97.166.34]:64214 "EHLO prserv.net")
	by vger.kernel.org with ESMTP id S261743AbVE3UwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 16:52:21 -0400
Message-ID: <429B7D00.1080004@attglobal.net>
Date: Mon, 30 May 2005 22:52:16 +0200
From: Eric Jones <ejones5@attglobal.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: "Clemente Aguiar" <caguiar@madeiratecnopolo.pt>
Subject: Re: Adaptec AIC-79xx HostRaid
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>>We have acquired some IBM xServers which have an integrated raid controller
 >>>based on the Adaptec AIC-79xx U320 SCSI controller (called HostRaid).
 >>>
 > As far as I know, it is software raid done much closer to the hw than
 > the linux sw raid (md).

Actually, there are two possible configurations, depending on HW configuration...

For example the IBM x346 server has an onboard Adaptec 7902 SCSI controller chip for the
U320 backplane devices (max-6 devices). This chip uses the standard aix79xx driver for
normal SCSI functions.  But, for extra $$$, you can also buy the IBM feature "ServeRAID-7k"
which is a small DIMM-sized plugin module that adds XOR parity generation and a small cache.
 
http://www-132.ibm.com/webapp/wcs/stores/servlet/ProductDisplay?productId=8735579&storeId=1&langId=-1&catalogId=-840 


Adaptec calls this a "zero-slot" RAID solution, and it requires a special binary driver
to recognize and handle the array functions.


Most people seem to order this bit with the initial kit, but then rip it out when they realize
it needs a binary driver to support the RAID functions.  The Linux SW-RAID seems to provide
better IO performance, and you can still see the individual sdx devices on the SCSI bus.
This makes it easier to monitor device performance and health (ie. smartd, etc), vs the Adaptec
"Hide everything behind the controller" approach with the ServeRAID-7k configuration.


Eric


