Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270349AbUJTKGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270349AbUJTKGz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270348AbUJTKBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:01:53 -0400
Received: from aun.it.uu.se ([130.238.12.36]:1665 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S270326AbUJTJ45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 05:56:57 -0400
Date: Wed, 20 Oct 2004 11:56:45 +0200 (MEST)
Message-Id: <200410200956.i9K9ujOu026178@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: cw@f00f.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid a build warning on 32-bit platforms
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2004 19:37:16 -0700, cw@f00f.org (Chris Wedgwood) wrote:
>@@ -818,11 +818,12 @@
> 	 * jiffies.
> 	 */
> 	time = get_cycles();
>-	if (time != 0) {
>-		if (sizeof(time) > 4)
>-			num ^= (u32)(time >> 32);
>-	} else {
>+	if (!time)
> 		time = jiffies;
>+	else {
>+#if (BITS_PER_LONG > 32)
>+		num ^= (u32)(time >> 32);
>+#endif /* (BITS_PER_LONG > 32) */

There's a coding idiom for doing this: just break up
the ">> 32" in two steps, like: ((time >> 31) >> 1).
Definitely preferable over #ifdef:s.

/Mikael
