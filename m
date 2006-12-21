Return-Path: <linux-kernel-owner+w=401wt.eu-S1422630AbWLUDWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422630AbWLUDWS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422639AbWLUDWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:22:18 -0500
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:51458 "EHLO
	tomts13-srv.bellnexxia.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422630AbWLUDWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:22:17 -0500
Date: Wed, 20 Dec 2006 22:22:15 -0500
From: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, David Wilder <dwilder@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Christoph Hellwig <hch@infradead.org>, ltt-dev@shafik.org,
       systemtap@sources.redhat.com, Douglas Niehaus <niehaus@eecs.ku.edu>,
       "Martin J. Bligh" <mbligh@mbligh.org>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] Relay CPU Hotplug support
Message-ID: <20061221032215.GA14930@Krystal>
References: <20061221003101.GA28643@Krystal> <17801.57293.790405.25052@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <17801.57293.790405.25052@gargle.gargle.HOWL>
X-Editor: vi
X-Info: http://krystal.dyndns.org:8080
X-Operating-System: Linux/2.4.32-grsec (i686)
X-Uptime: 22:20:01 up 120 days, 27 min,  4 users,  load average: 0.47, 0.53, 0.52
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Tom Zanussi (zanussi@us.ibm.com) wrote:
> Mathieu Desnoyers writes:
>  > Hi,
>  > 
>  > Here is a patch, result of the combined work of Tom Zanussi and myself, to add
>  > CPU hotplug support to Relay.
>  > 
>  > This patch applies on 2.6.20-rc1-git7.
>  > 
>  > Signed-off-by : Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
>  > 
> 
> Hi Mathieu,
> 
> It looks like you forgot to include the Documentation update with
> this.  Other than that, it looks fine to me.
> 
> Acked-by: Tom Zanussi <zanussi@us.ibm.com>
> 
> 

Here is the missing part of the patch for documentation.

Thanks for pointing it out.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>

--- a/Documentation/filesystems/relay.txt
+++ b/Documentation/filesystems/relay.txt
@@ -157,7 +157,7 @@ TBD(curr. line MT:/API/)
   channel management functions:
 
     relay_open(base_filename, parent, subbuf_size, n_subbufs,
-               callbacks)
+               callbacks, private_data)
     relay_close(chan)
     relay_flush(chan)
     relay_reset(chan)
@@ -251,7 +251,7 @@ static struct rchan_callbacks relay_call
 
 And an example relay_open() invocation using them:
 
-  chan = relay_open("cpu", NULL, SUBBUF_SIZE, N_SUBBUFS, &relay_callbacks);
+  chan = relay_open("cpu", NULL, SUBBUF_SIZE, N_SUBBUFS, &relay_callbacks, NULL);
 
 If the create_buf_file() callback fails, or isn't defined, channel
 creation and thus relay_open() will fail.
@@ -289,6 +289,11 @@ they use the proper locking for such a b
 writes in a spinlock, or by copying a write function from relay.h and
 creating a local version that internally does the proper locking.
 
+The private_data passed into relay_open() allows clients to associate
+user-defined data with a channel, and is immediately available
+(including in create_buf_file()) via chan->private_data or
+buf->chan->private_data.
+
 Channel 'modes'
 ---------------

-- 
OpenPGP public key:              http://krystal.dyndns.org:8080/key/compudj.gpg
Key fingerprint:     8CD5 52C3 8E3C 4140 715F  BA06 3F25 A8FE 3BAE 9A68 
