Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262904AbVA2Lku@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262904AbVA2Lku (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 06:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262903AbVA2Lku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 06:40:50 -0500
Received: from main.gmane.org ([80.91.229.2]:50139 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262904AbVA2Lkj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 06:40:39 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Richard Hughes <ee21rh@surrey.ac.uk>
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a   threading error
Date: Sat, 29 Jan 2005 10:44:09 +0000
Message-ID: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
References: <217740000.1106412985@[10.10.2.4]> <41F30E0A.9000100@osdl.org> <1106482954.1256.2.camel@tux.rsn.bth.se> <20050126132504.3295e07d@dxpl.pdx.osdl.net> <41F97E07.2040709@comcast.net> <20050128093104.61a7a387@dxpl.pdx.osdl.net> <1106954493.3051.8.camel@krustophenia.net> <41FACEC5.6070703@comcast.net> <20050128155713.6f3ef6d8@dxpl.pdx.osdl.net>
Reply-To: ee21rh@surrey.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host217-43-20-137.range217-43.btcentralplus.com
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2005 15:57:13 -0800, Stephen Hemminger wrote:
> Note: on 2.6.10
> 	/dev/dri/card0	crw-rw-rw-
> on 2.6.11-rc2
> 	/dev/dri/card0	crw-rw----
> 	/dev/dri/card1	crw-rw----
> 
> Changing permissions seems to fix (it for startup), will try more and see
> if udev remembers not to turn them back.

Me too. (2.6.11-rc2-bk3, openoffice.org-1.1.3) I straced soffice and found
it hanging on /dev/dri:

geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card14", 0xbff9c8bc)   = -1 ENOENT (No such file or directory)
munmap(0x9b4838, 8192)                  = -1 EINVAL (Invalid argument)
munmap(0x949e248, 3220820000)           = -1 EINVAL (Invalid argument)
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

and with a chmod a+rw /dev/dri/card* everything is okay until I reboot,
and it defaults back to crw-rw----

What is at fault? Certainly oo shouldn't just seg-fault, but should the
permissions on /dev/dri/card* be crw-rw---- or crw-rw-rw-?

Richard Hughes

-- 

http://www.hughsie.com/PUBLIC-KEY


