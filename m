Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWBUPKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWBUPKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 10:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWBUPKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 10:10:40 -0500
Received: from smtp1.pp.htv.fi ([213.243.153.37]:13534 "EHLO smtp1.pp.htv.fi")
	by vger.kernel.org with ESMTP id S932470AbWBUPKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 10:10:40 -0500
Date: Tue, 21 Feb 2006 17:10:31 +0200
From: Paul Mundt <lethal@linux-sh.org>
To: Greg KH <greg@kroah.com>
Cc: zanussi@us.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] sysfs: Add __ATTR_RELAY() helper for relay attributes.
Message-ID: <20060221151031.GA20816@linux-sh.org>
Mail-Followup-To: Paul Mundt <lethal@linux-sh.org>,
	Greg KH <greg@kroah.com>, zanussi@us.ibm.com,
	linux-kernel@vger.kernel.org
References: <20060219171748.GA13068@linux-sh.org> <20060219175623.GA2674@kroah.com> <20060219185254.GA13391@linux-sh.org> <20060220222449.GC28042@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220222449.GC28042@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 02:24:49PM -0800, Greg KH wrote:
> One thing to note, a lot of people forgot to set that field for binary
> attribute files, while "normal" attributes get it set "automatically"
> due to the macro that was used to create them.  You might consider also
> creating a macro for this struture so people can not forget to set the
> field.
> 
Good point, how about this?

This adds a simple __ATTR_RELAY() to help people define relay attributes,
this takes care of things like getting the module owner right.

Signed-off-by: Paul Mundt <lethal@linux-sh.org>

---

 include/linux/sysfs.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

5a1440482f48b3ab4b8365a8081295869992bad2
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 0faca48..36a078e 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -44,6 +44,16 @@ struct attribute_group {
 	.show	= _name##_show,	\
 }
 
+#define __ATTR_RELAY(_name,_buffer_size,_nr_buffers) {	\
+	.attr	= {					\
+		.owner = THIS_MODULE,			\
+		.name = __stringify(_name),		\
+		.mode = 0400,				\
+	},						\
+	.subbuf_size	= _buffer_size,			\
+	.n_subbufs	= _nr_buffers,			\
+}
+
 #define __ATTR_NULL { .attr = { .name = NULL } }
 
 #define attr_name(_attr) (_attr).attr.name
