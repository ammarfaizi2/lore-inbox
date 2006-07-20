Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932594AbWGTPOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932594AbWGTPOl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 11:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932592AbWGTPOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 11:14:40 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:10096 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932590AbWGTPOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 11:14:39 -0400
Message-ID: <44BF9E42.60206@oracle.com>
Date: Thu, 20 Jul 2006 08:16:18 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: zanussi@us.ibm.com, karim@opersys.com, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: [PATCH 1/3] kernel-doc for relay interface
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@xenotime.net>

Add relay interface support to DocBook/kernel-api.tmpl.
Fix typos etc. in relay.c and relayfs.txt.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
---
 Documentation/DocBook/kernel-api.tmpl |   16 +++++++++++++++
 Documentation/filesystems/relayfs.txt |   30 ++++++++++++++--------------
 kernel/relay.c                        |   36 ++++++++++++++++++++--------------
 3 files changed, 53 insertions(+), 29 deletions(-)

--- linux-2618-rc2.orig/Documentation/filesystems/relayfs.txt
+++ linux-2618-rc2/Documentation/filesystems/relayfs.txt
@@ -34,7 +34,7 @@ sub-buffers.  At this point, userspace c
 the first sub-buffer, while the kernel continues writing to the next.
 
 When notified that a sub-buffer is full, the kernel knows how many
-bytes of it are padding i.e. unused.  Userspace can use this knowledge
+bytes of it are padding, i.e. unused.  Userspace can use this knowledge
 to copy only valid data.
 
 After copying it, userspace can notify the kernel that a sub-buffer
@@ -57,7 +57,7 @@ simple utility functions and a set of ex
 The relay-apps example tarball, available on the relayfs sourceforge
 site, contains a set of self-contained examples, each consisting of a
 pair of .c files containing boilerplate code for each of the user and
-kernel sides of a relayfs application; combined these two sets of
+kernel sides of a relayfs application.  When combined these two sets of
 boilerplate code provide glue to easily stream data to disk, without
 having to bother with mundane housekeeping chores.
 
@@ -71,7 +71,7 @@ statements anywhere in the kernel or ker
 is a 'klog handler' registered will data actually be logged (see the
 klog and kleak examples for details).
 
-It is of course possible to use relayfs from scratch i.e. without
+It is of course possible to use relayfs from scratch, i.e. without
 using any of the relay-apps example code or klog, but you'll have to
 implement communication between userspace and kernel, allowing both to
 convey the state of buffers (full, empty, amount of padding).
@@ -94,7 +94,7 @@ mmap()	 results in channel buffer being 
 	 map the entire file, which is NRBUF * SUBBUFSIZE.
 
 read()	 read the contents of a channel buffer.  The bytes read are
-	 'consumed' by the reader i.e. they won't be available again
+	 'consumed' by the reader, i.e. they won't be available again
 	 to subsequent reads.  If the channel is being used in
 	 no-overwrite mode (the default), it can be read at any time
 	 even if there's an active kernel writer.  If the channel is
@@ -107,7 +107,7 @@ poll()	 POLLIN/POLLRDNORM/POLLERR suppor
 	 notified when sub-buffer boundaries are crossed.
 
 close() decrements the channel buffer's refcount.  When the refcount
-	reaches 0 i.e. when no process or kernel client has the buffer
+	reaches 0, i.e. when no process or kernel client has the buffer
 	open, the channel buffer is freed.
 
 
@@ -126,7 +126,7 @@ The relayfs kernel API
 
 Here's a summary of the API relayfs provides to in-kernel clients:
 
-
+TBD(curr. line MT:/API/)
   channel management functions:
 
     relay_open(base_filename, parent, subbuf_size, n_subbufs,
@@ -201,10 +201,10 @@ of the subbuf_start() callback, as descr
 mode, also known as 'flight recorder' mode, writes continuously cycle
 around the buffer and will never fail, but will unconditionally
 overwrite old data regardless of whether it's actually been consumed.
-In no-overwrite mode, writes will fail i.e. data will be lost, if the
+In no-overwrite mode, writes will fail, i.e. data will be lost, if the
 number of unconsumed sub-buffers equals the total number of
 sub-buffers in the channel.  It should be clear that if there is no
-consumer or if the consumer can't consume sub-buffers fast enought,
+consumer or if the consumer can't consume sub-buffers fast enough,
 data will be lost in either case; the only difference is whether data
 is lost from the beginning or the end of a buffer.
 
@@ -240,9 +240,9 @@ static int subbuf_start(struct rchan_buf
 	return 1;
 }
 
-If the current buffer is full i.e. all sub-buffers remain unconsumed,
+If the current buffer is full, i.e. all sub-buffers remain unconsumed,
 the callback returns 0 to indicate that the buffer switch should not
-occur yet i.e. until the consumer has had a chance to read the current
+occur yet, i.e. until the consumer has had a chance to read the current
 set of ready sub-buffers.  For the relay_buf_full() function to make
 sense, the consumer is reponsible for notifying relayfs when
 sub-buffers have been consumed via relay_subbufs_consumed().  Any
@@ -276,7 +276,7 @@ consulted.
 
 The default subbuf_start() implementation, used if the client doesn't
 define any callbacks, or doesn't define the subbuf_start() callback,
-implements the simplest possible 'no-overwrite' mode i.e. it does
+implements the simplest possible 'no-overwrite' mode, i.e. it does
 nothing but return 0.
 
 Header information can be reserved at the beginning of each sub-buffer
@@ -298,7 +298,7 @@ writing into the previous sub-buffer.
 Writing to a channel
 --------------------
 
-kernel clients write data into the current cpu's channel buffer using
+Kernel clients write data into the current cpu's channel buffer using
 relay_write() or __relay_write().  relay_write() is the main logging
 function - it uses local_irqsave() to protect the buffer and should be
 used if you might be logging from interrupt context.  If you know
@@ -341,7 +341,7 @@ Creating non-relay files
 relay_open() automatically creates files in the relayfs filesystem to
 represent the per-cpu kernel buffers; it's often useful for
 applications to be able to create their own files alongside the relay
-files in the relayfs filesystem as well e.g. 'control' files much like
+files in the relayfs filesystem as well, e.g. 'control' files much like
 those created in /proc or debugfs for similar purposes, used to
 communicate control information between the kernel and user sides of a
 relayfs application.  For this purpose the relayfs_create_file() and
@@ -390,7 +390,7 @@ implementation should set the value of t
 non-zero value in addition to creating the file that will be used to
 represent the single buffer.  In the case of a global buffer,
 create_buf_file() and remove_buf_file() will be called only once.  The
-normal channel-writing functions e.g. relay_write() can still be used
+normal channel-writing functions, e.g. relay_write(), can still be used
 - writes from any cpu will transparently end up in the global buffer -
 but since it is a global buffer, callers should make sure they use the
 proper locking for such a buffer, either by wrapping writes in a
@@ -408,7 +408,7 @@ rather than open and close a new channel
 can be used for this purpose - it resets a channel to its initial
 state without reallocating channel buffer memory or destroying
 existing mappings.  It should however only be called when it's safe to
-do so i.e. when the channel isn't currently being written to.
+do so, i.e. when the channel isn't currently being written to.
 
 Finally, there are a couple of utility callbacks that can be used for
 different purposes.  buf_mapped() is called whenever a channel buffer
--- linux-2618-rc2.orig/kernel/relay.c
+++ linux-2618-rc2/kernel/relay.c
@@ -95,7 +95,7 @@ int relay_mmap_buf(struct rchan_buf *buf
  *	@buf: the buffer struct
  *	@size: total size of the buffer
  *
- *	Returns a pointer to the resulting buffer, NULL if unsuccessful. The
+ *	Returns a pointer to the resulting buffer, %NULL if unsuccessful. The
  *	passed in size will get page aligned, if it isn't already.
  */
 static void *relay_alloc_buf(struct rchan_buf *buf, size_t *size)
@@ -132,10 +132,9 @@ depopulate:
 
 /**
  *	relay_create_buf - allocate and initialize a channel buffer
- *	@alloc_size: size of the buffer to allocate
- *	@n_subbufs: number of sub-buffers in the channel
+ *	@chan: the relay channel
  *
- *	Returns channel buffer if successful, NULL otherwise
+ *	Returns channel buffer if successful, %NULL otherwise.
  */
 struct rchan_buf *relay_create_buf(struct rchan *chan)
 {
@@ -163,6 +162,7 @@ free_buf:
 
 /**
  *	relay_destroy_channel - free the channel struct
+ *	@kref: target kernel reference that contains the relay channel
  *
  *	Should only be called from kref_put().
  */
@@ -194,6 +194,7 @@ void relay_destroy_buf(struct rchan_buf 
 
 /**
  *	relay_remove_buf - remove a channel buffer
+ *	@kref: target kernel reference that contains the relay buffer
  *
  *	Removes the file from the fileystem, which also frees the
  *	rchan_buf_struct and the channel buffer.  Should only be called from
@@ -374,7 +375,7 @@ void relay_reset(struct rchan *chan)
 }
 EXPORT_SYMBOL_GPL(relay_reset);
 
-/**
+/*
  *	relay_open_buf - create a new relay channel buffer
  *
  *	Internal - used by relay_open().
@@ -448,12 +449,12 @@ static inline void setup_callbacks(struc
 /**
  *	relay_open - create a new relay channel
  *	@base_filename: base name of files to create
- *	@parent: dentry of parent directory, NULL for root directory
+ *	@parent: dentry of parent directory, %NULL for root directory
  *	@subbuf_size: size of sub-buffers
  *	@n_subbufs: number of sub-buffers
  *	@cb: client callback functions
  *
- *	Returns channel pointer if successful, NULL otherwise.
+ *	Returns channel pointer if successful, %NULL otherwise.
  *
  *	Creates a channel buffer for each cpu using the sizes and
  *	attributes specified.  The created channel buffer files
@@ -585,7 +586,7 @@ EXPORT_SYMBOL_GPL(relay_switch_subbuf);
  *	subbufs_consumed should be the number of sub-buffers newly consumed,
  *	not the total consumed.
  *
- *	NOTE: kernel clients don't need to call this function if the channel
+ *	NOTE: Kernel clients don't need to call this function if the channel
  *	mode is 'overwrite'.
  */
 void relay_subbufs_consumed(struct rchan *chan,
@@ -641,7 +642,7 @@ EXPORT_SYMBOL_GPL(relay_close);
  *	relay_flush - close the channel
  *	@chan: the channel
  *
- *	Flushes all channel buffers i.e. forces buffer switch.
+ *	Flushes all channel buffers, i.e. forces buffer switch.
  */
 void relay_flush(struct rchan *chan)
 {
@@ -729,7 +730,7 @@ static int relay_file_release(struct ino
 	return 0;
 }
 
-/**
+/*
  *	relay_file_read_consume - update the consumed count for the buffer
  */
 static void relay_file_read_consume(struct rchan_buf *buf,
@@ -756,7 +757,7 @@ static void relay_file_read_consume(stru
 	}
 }
 
-/**
+/*
  *	relay_file_read_avail - boolean, are there unconsumed bytes available?
  */
 static int relay_file_read_avail(struct rchan_buf *buf, size_t read_pos)
@@ -793,6 +794,8 @@ static int relay_file_read_avail(struct 
 
 /**
  *	relay_file_read_subbuf_avail - return bytes available in sub-buffer
+ *	@read_pos: file read position
+ *	@buf: relay channel buffer
  */
 static size_t relay_file_read_subbuf_avail(size_t read_pos,
 					   struct rchan_buf *buf)
@@ -818,6 +821,8 @@ static size_t relay_file_read_subbuf_ava
 
 /**
  *	relay_file_read_start_pos - find the first available byte to read
+ *	@read_pos: file read position
+ *	@buf: relay channel buffer
  *
  *	If the read_pos is in the middle of padding, return the
  *	position of the first actually available byte, otherwise
@@ -844,6 +849,9 @@ static size_t relay_file_read_start_pos(
 
 /**
  *	relay_file_read_end_pos - return the new read position
+ *	@read_pos: file read position
+ *	@buf: relay channel buffer
+ *	@count: number of bytes to be read
  */
 static size_t relay_file_read_end_pos(struct rchan_buf *buf,
 				      size_t read_pos,
@@ -865,7 +873,7 @@ static size_t relay_file_read_end_pos(st
 	return end_pos;
 }
 
-/**
+/*
  *	subbuf_read_actor - read up to one subbuf's worth of data
  */
 static int subbuf_read_actor(size_t read_start,
@@ -890,7 +898,7 @@ static int subbuf_read_actor(size_t read
 	return ret;
 }
 
-/**
+/*
  *	subbuf_send_actor - send up to one subbuf's worth of data
  */
 static int subbuf_send_actor(size_t read_start,
@@ -933,7 +941,7 @@ typedef int (*subbuf_actor_t) (size_t re
 			       read_descriptor_t *desc,
 			       read_actor_t actor);
 
-/**
+/*
  *	relay_file_read_subbufs - read count bytes, bridging subbuf boundaries
  */
 static inline ssize_t relay_file_read_subbufs(struct file *filp,
--- linux-2618-rc2.orig/Documentation/DocBook/kernel-api.tmpl
+++ linux-2618-rc2/Documentation/DocBook/kernel-api.tmpl
@@ -199,6 +199,22 @@ X!Ilib/string.c
      </sect1>
   </chapter>
 
+  <chapter id="relayfs">
+     <title>relay interface support</title>
+
+     <para>
+	Relay interface support
+	is designed to provide an efficient mechanism for tools and
+	facilities to relay large amounts of data from kernel space to
+	user space.
+     </para>
+
+     <sect1><title>relay interface</title>
+!Ekernel/relay.c
+!Ikernel/relay.c
+     </sect1>
+  </chapter>
+
   <chapter id="vfs">
      <title>The Linux VFS</title>
      <sect1><title>The Filesystem types</title>


