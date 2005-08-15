Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVHOOQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVHOOQB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 10:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964783AbVHOOQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 10:16:01 -0400
Received: from smtp102.rog.mail.re2.yahoo.com ([206.190.36.80]:64082 "HELO
	smtp102.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964779AbVHOOQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 10:16:00 -0400
Subject: idr_get_new_above not working?
From: John McCutchan <ttb@tentacle.dhs.org>
To: Andrew Morton <akpm@osdl.org>, Robert Love <rml@novell.com>,
       linux-kernel@vger.kernel.org, jim.houston@ccur.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Aug 2005 10:16:46 -0400
Message-Id: <1124115406.7369.6.camel@vertex>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Inotify is using idr_get_new_above to make sure that the next watch
descriptor is larger/different than any of the previous watch
descriptors. We keep track of the largest wd that we get out of
idr_get_new_above, and pass that to idr_get_new_above. I have noticed
though, that idr_get_new_above always returns the first available id.
This causes a serious problem for inotify, because user space will get a
IGNORE event for a wd K that might refer to the last holder of the K.

-- 
John McCutchan <ttb@tentacle.dhs.org>
