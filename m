Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310213AbSCFWRJ>; Wed, 6 Mar 2002 17:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310217AbSCFWQ6>; Wed, 6 Mar 2002 17:16:58 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:3343 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310213AbSCFWQx>;
	Wed, 6 Mar 2002 17:16:53 -0500
Date: Wed, 6 Mar 2002 14:09:00 -0800
From: Greg KH <greg@kroah.com>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] small fix for mpparse.c
Message-ID: <20020306220900.GB16121@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 06 Feb 2002 16:49:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a very tiny bugfix for arch/i386/kernel/mpparse.c in the
2.4.19-pre2 kernel.  It fixes the problem if there is an error in the
MP_processor_info() function where the mpc_apicid value is greater than
MAX_APICS, then we need to decrement the number of valid processors
before we return (the number was just incremented before the check.)

The patch was written by James Cleverdon.

thanks,

greg k-h


diff -Nru a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
--- a/arch/i386/kernel/mpparse.c	Wed Mar  6 14:05:24 2002
+++ b/arch/i386/kernel/mpparse.c	Wed Mar  6 14:05:24 2002
@@ -221,6 +221,7 @@
 	if (m->mpc_apicid > MAX_APICS) {
 		printk("Processor #%d INVALID. (Max ID: %d).\n",
 			m->mpc_apicid, MAX_APICS);
+		--num_processors;
 		return;
 	}
 	ver = m->mpc_apicver;
