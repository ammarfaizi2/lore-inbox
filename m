Return-Path: <linux-kernel-owner+w=401wt.eu-S1751966AbWLNSXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbWLNSXN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 13:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbWLNSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 13:23:13 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:16217 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751966AbWLNSXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 13:23:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=atnh046gcOirouyuDwga4A96HHIF/5o9I1W4qSd0c0iCj5K+rwDijP+93bA2ivIRteTqDM7JafdZTWdwiA7/B50VqVoSsTqTHBzh0IJV16F1LIZrhsyl+dbVqXXJ0tOsujPoujCAY5IJSHTdg6OZyVwNWjw36BkBNKG0QVoVfkk=
Message-ID: <e6babb600612141023g5fd73b8bi89282b8c3008522b@mail.gmail.com>
Date: Thu, 14 Dec 2006 11:23:11 -0700
From: "Robert Crocombe" <rcrocomb@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: isochronous receives?
Cc: "Keith Curtis" <Keith.Curtis@digeo.com>,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <45804615.3060004@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <DD2010E58E069B40886650EE617FCC0CBA8EC9@digeo-mail1.digeo.com>
	 <e6babb600612130630y341aaadehb0436ade65ea6f7d@mail.gmail.com>
	 <45804615.3060004@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> How about leaving ohci1394 as it is but document tag_mask better in
> libraw1394's inline doxygen(?) comments, and maybe add an enum or macros
> to be used as values of raw1394_iso_recv_start's tag_mask argument?
>
> /* can be ORed together */
> #define RAW1394_IR_MATCH_TAG_0       1
> #define RAW1394_IR_MATCH_TAG_1       2
> #define RAW1394_IR_MATCH_TAG_2       4
> #define RAW1394_IR_MATCH_TAG_3       8
> #define RAW1394_IR_MATCH_ALL_TAGS   -1

Yeah, that's definitely much better.  I guess this would go in
libraw1394's raw1394.h?  Similar to:

--- raw1394.h   2006-11-29 11:54:56.000000000 -0700
+++ raw1394_modified.h  2006-12-14 11:20:57.000000000 -0700
@@ -40,6 +40,14 @@
 #define RAW1394_RCODE_TYPE_ERROR         0x6
 #define RAW1394_RCODE_ADDRESS_ERROR      0x7

+/* can be ORed together */
+#define RAW1394_IR_MATCH_TAG_0          0x1
+#define RAW1394_IR_MATCH_TAG_1          0x2
+#define RAW1394_IR_MATCH_TAG_2          0x4
+#define RAW1394_IR_MATCH_TAG_3          0x8
+#define RAW1394_IR_MATCH_ALL_TAGS       -1
+#define RAW1394_IR_MATCH_TAG(tag)       (1 << (tag))
+
 typedef u_int8_t  byte_t;
 typedef u_int32_t quadlet_t;
 typedef u_int64_t octlet_t;
@@ -273,7 +281,9 @@
  * @handle: libraw1394 handle
  * @start_on_cycle: isochronous cycle number on which to start
  * (-1 if you don't care)
- * @tag_mask: mask of tag fields to match (-1 to receive all packets)
+ * @tag_mask: mask of tag fields to match.  Use the RAW1394_IR_MATCH_*
+ * values for this rather than the literal tag bits: the values are not
+ * equivalent.
  * @sync: not used, reserved for future implementation
  *
  * Returns: 0 on success or -1 on failure (sets errno)

??

-- 
Robert Crocombe
rcrocomb@gmail.com
