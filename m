Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262849AbTDIGtq (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 02:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262856AbTDIGtq (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 02:49:46 -0400
Received: from golf.rb.xcalibre.co.uk ([217.8.240.16]:34320 "EHLO
	golf.rb.xcalibre.co.uk") by vger.kernel.org with ESMTP
	id S262849AbTDIGtp (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 02:49:45 -0400
Envelope-to: linux-kernel@vger.kernel.org
From: Alistair Strachan <alistair@devzero.co.uk>
To: Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@digeo.com>
Subject: Re: 2.5.67-mm1
Date: Wed, 9 Apr 2003 08:00:42 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <200304081741.10129.alistair@devzero.co.uk> <20030408142853.74709a82.akpm@digeo.com> <200304081606.13405.pbadari@us.ibm.com>
In-Reply-To: <200304081606.13405.pbadari@us.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200304090800.43022.alistair@devzero.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 09 April 2003 00:06, Badari Pulavarty wrote:
> On Tuesday 08 April 2003 02:28 pm, Andrew Morton wrote:
> > Ah, good detective work, thanks.  It looks like the hd_struct
> > dynamic allocation patch has broken devfs partition discovery
> > somehow.
>
> Thanks.. I am going to look now. Must have broken something in devfs.
>
> - Badari

Sorry for the delay, I've only just woken up. I applied the patch, it 
wouldn't compile, you missed the following (I think obvious) chunk:

--- linux-2.5/fs/partitions/check.c.old 2003-04-09 07:49:29 +0100
+++ linux-2.5/fs/partitions/check.c     2003-04-09 07:51:26 +0100
@@ -160,7 +160,7 @@
 {
 #ifdef CONFIG_DEVFS_FS
        devfs_handle_t dir;
-       struct hd_struct *p = dev->part;
+       struct hd_struct **p = dev->part;
        char devname[16];

        if (p[part-1]->de)

With that in place, it compiled without warning and the machine now 
boots with the dynamic hd_struct work + aggregate stats patch.

Thanks for your time.

Cheers,
Alistair.

