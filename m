Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268730AbUJECDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268730AbUJECDZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 22:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268735AbUJECDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 22:03:25 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:9141 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S268730AbUJECDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 22:03:23 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Jason Stubbs <jstubbs@work-at.co.jp>, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <200410041611.17000.jstubbs@work-at.co.jp>
	<20041004013548.26e853fc.akpm@osdl.org>
	<200410041931.00159.jstubbs@work-at.co.jp>
	<20041004120535.3c68115a.akpm@osdl.org>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 04 Oct 2004 19:03:21 -0700
In-Reply-To: <20041004120535.3c68115a.akpm@osdl.org> (Andrew Morton's
 message of "Mon, 4 Oct 2004 12:05:35 -0700")
Message-ID: <52brfhvs46.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: PROBLEM: Consistent lock up on >=2.6.8
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 05 Oct 2004 02:03:22.0232 (UTC) FILETIME=[7DDB7780:01C4AA7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	@@ -2375,7 +2372,7 @@ void ip_vs_control_cleanup(void)
	 {
	 	EnterFunction(2);
	 	ip_vs_trash_cleanup();
	-	del_timer_sync(&defense_timer);
	+	cancel_delayed_work(&defense_work);

Do we need a flush_scheduled_work() here to be totally safe?  Not sure
if it could ever really happen but it seems the module could at least
theoretically be unloaded with update_defense_level() still running...

 - Roland
