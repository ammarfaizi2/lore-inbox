Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263578AbTEMHhK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 03:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263571AbTEMHhK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 03:37:10 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:4843 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263578AbTEMHhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 03:37:07 -0400
Date: Tue, 13 May 2003 03:14:12 -0400
From: Ben Collins <bcollins@debian.org>
To: Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Make KOBJ_NAME_LEN match BUS_ID_SIZE
Message-ID: <20030513071412.GS433@phunnypharm.org>
References: <20030513062640.GR433@phunnypharm.org> <20030513081032.A7184@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513081032.A7184@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 08:10:32AM +0100, Christoph Hellwig wrote:
> On Tue, May 13, 2003 at 02:26:40AM -0400, Ben Collins wrote:
> > This was causing me all sorts of problems with linux1394's 16-18 byte
> > long bus_id lengths. The sysfs names were all broken.
> > 
> > This not only makes KOBJ_NAME_LEN match BUS_ID_SIZE, but fixes the
> > strncpy's in drivers/base/ so that it can't happen again (atleast the
> > strings will be null terminated).
> 
> What about defining BUS_ID_SIZE in terms of KOBJ_NAME_LEN?

Ok, then add this in addition to the previous patch.


Index: include/linux/device.h
===================================================================
RCS file: /home/scm/linux-2.5/include/linux/device.h,v
retrieving revision 1.48
diff -u -u -r1.48 device.h
--- include/linux/device.h	29 Apr 2003 17:30:20 -0000	1.48
+++ include/linux/device.h	13 May 2003 07:47:39 -0000
@@ -35,7 +35,7 @@
 #define DEVICE_NAME_SIZE	50
 #define DEVICE_NAME_HALF	__stringify(20)	/* Less than half to accommodate slop */
 #define DEVICE_ID_SIZE		32
-#define BUS_ID_SIZE		20
+#define BUS_ID_SIZE		KOBJ_NAME_LEN
 
 
 enum {
