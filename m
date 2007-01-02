Return-Path: <linux-kernel-owner+w=401wt.eu-S965051AbXABXic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbXABXic (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 18:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965136AbXABXib
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 18:38:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55153 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965051AbXABXia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 18:38:30 -0500
Date: Tue, 2 Jan 2007 18:38:24 -0500
From: Dave Jones <davej@redhat.com>
To: mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Shrink the held_lock struct by using bitfields.
Message-ID: <20070102233824.GF18033@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, mingo@redhat.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20070102233558.GA4577@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070102233558.GA4577@redhat.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 06:35:58PM -0500, Dave Jones wrote:

Sent the wrong diff.  Here's the fixed version...



Shrink the held_lock struct by using bitfields.
This shrinks task_struct on lockdep enabled kernels by 480 bytes.

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index ea097dd..ba81cce 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -175,11 +175,11 @@ struct held_lock {
 	 * The following field is used to detect when we cross into an
 	 * interrupt context:
 	 */
-	int				irq_context;
-	int				trylock;
-	int				read;
-	int				check;
-	int				hardirqs_off;
+	unsigned char irq_context:1;
+	unsigned char trylock:1;
+	unsigned char read:2;
+	unsigned char check:1;
+	unsigned char hardirqs_off:1;
 };
 
 /*

-- 
http://www.codemonkey.org.uk
