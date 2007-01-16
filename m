Return-Path: <linux-kernel-owner+w=401wt.eu-S1751244AbXAPR43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbXAPR43 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 12:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbXAPR43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 12:56:29 -0500
Received: from bc.sympatico.ca ([209.226.175.184]:41879 "EHLO
	tomts22-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751244AbXAPR42 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 12:56:28 -0500
Date: Tue, 16 Jan 2007 12:56:24 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Ingo Molnar <mingo@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ltt-dev@shafik.org, "Martin J. Bligh" <mbligh@mbligh.org>,
       Douglas Niehaus <niehaus@eecs.ku.edu>, systemtap@sources.redhat.com,
       Thomas Gleixner <tglx@linutronix.de>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: [PATCH 1/2] lockdep missing barrier()
Message-ID: <20070116175624.GA16022@Krystal>
References: <20061220235216.GA28643@Krystal> <OFAB3D8A6C.1643F2D3-ON80257262.000581E4-80257262.00088F04@uk.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <OFAB3D8A6C.1643F2D3-ON80257262.000581E4-80257262.00088F04@uk.ibm.com>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 12:48:38 up 146 days, 14:55,  6 users,  load average: 0.79, 1.14, 1.81
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a barrier() to lockdep.c lockdep_recursion updates. This
variable behaves like the preemption count and should therefore use similar
memory barriers.

This patch applies on 2.6.20-rc4-git3.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/kernel/lockdep.c
+++ b/kernel/lockdep.c
@@ -166,12 +166,14 @@ static struct list_head chainhash_table[CHAINHASH_SIZE];
 void lockdep_off(void)
 {
 	current->lockdep_recursion++;
+	barrier();
 }
 
 EXPORT_SYMBOL(lockdep_off);
 
 void lockdep_on(void)
 {
+	barrier();
 	current->lockdep_recursion--;
 }

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
