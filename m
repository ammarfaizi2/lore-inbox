Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262701AbVBBVY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262701AbVBBVY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 16:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVBBVWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 16:22:08 -0500
Received: from waste.org ([216.27.176.166]:12675 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262662AbVBBVTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 16:19:34 -0500
Date: Wed, 2 Feb 2005 13:19:16 -0800
From: Matt Mackall <mpm@selenic.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       Christophe Saout <christophe@saout.de>,
       Clemens Fruhwirth <clemens@endorphin.org>
Subject: dm-crypt crypt_status reports key?
Message-ID: <20050202211916.GJ2493@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From looking at the dm_crypt code, it appears that it can be
interrogated to report the current key. Some quick testing shows:

# dmsetup table /dev/mapper/volume1
0 2000000 crypt aes-plain 0123456789abcdef0123456789abcdef 0 7:0 0

Obviously, root can in principle recover this password from the
running kernel but it seems silly to make it so easy.

Moreover, it seems this facility exists to support some form of
automated table storage (LVM?). As we don't want anyone/anything
accidentally storing our passwords on disk in the clear, we probably
shouldn't facilitate this. Perhaps we can stick something here like
"<secret>" that the dm_crypt constructor can reject.

-- 
Mathematics is the supreme nostalgia of our time.
