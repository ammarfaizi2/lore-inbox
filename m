Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268434AbTBYVb1>; Tue, 25 Feb 2003 16:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268435AbTBYVb1>; Tue, 25 Feb 2003 16:31:27 -0500
Received: from holomorphy.com ([66.224.33.161]:54199 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S268434AbTBYVbZ>;
	Tue, 25 Feb 2003 16:31:25 -0500
Date: Tue, 25 Feb 2003 13:40:43 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpu-2.5.63-1
Message-ID: <20030225214043.GG10411@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <20030225175456.GE10396@holomorphy.com> <20030225133207.2352bb9a.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030225133207.2352bb9a.rddunlap@osdl.org>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2003 at 01:32:07PM -0800, Randy.Dunlap wrote:
-	if (target_cpu_mask & allowed_mask) {
+	if (cpus_empty(tmp)) {
# ?	if (!cpus_empty(tmp)) {

Yep, that's a bug.


On Tue, Feb 25, 2003 at 01:32:07PM -0800, Randy.Dunlap wrote:
-#define BITS_TO_LONGS(bits) \
-	(((bits)+BITS_PER_LONG-1)/BITS_PER_LONG)
# keep this and use it.  (but moved from another file)
+#define DECLARE_BITMAP(name,bits) \
+	unsigned long name[((bits)+BITS_PER_LONG-1)/BITS_PER_LONG]
#	unsigned long name[BITS_TO_LONGS(bits)]
+#define CLEAR_BITMAP(name,bits) \
+	memset(name, 0, ((bits)+BITS_PER_LONG-1)/8)
#	memset(name, 0, BITS_TO_LONGS(bits) * (BITS_PER_LONG / 8))
# This clears all longs in <name>, so that extra code below can disappear.

Header ordering stuff. A wee bit brute-force. All good cleanups.
You originally spotted the bitmap_fill() typo too.

Looks like time for a cpu-2.5.63-2 with your changes.


-- wli
