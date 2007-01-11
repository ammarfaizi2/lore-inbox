Return-Path: <linux-kernel-owner+w=401wt.eu-S965164AbXAKA1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbXAKA1t (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 19:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbXAKA1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 19:27:49 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:56574
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965164AbXAKA1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 19:27:49 -0500
Date: Wed, 10 Jan 2007 16:27:47 -0800 (PST)
Message-Id: <20070110.162747.28789587.davem@davemloft.net>
To: jafo@tummy.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() setting ERESTARTNOHAND (514).
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070110234238.GB10791@tummy.com>
References: <20070110234238.GB10791@tummy.com>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Reifschneider <jafo@tummy.com>
Date: Wed, 10 Jan 2007 16:42:38 -0700

> In looking at the select() code, I see that there are definitely cases
> where sys_select() or sys_pselect7() can return -ERESTARTNOHAND.  However,
> I don't know if this is expected to be caught elsewhere, or if returning it
> here would send it back to user-space.  Worse, I don't fully understand
> what the impact would be of trapping the ERESTARTNOHAND in the
> sys_select/sys_pselect7 functions would be.

It gets caught by the return into userspace code.

Specifically the signal dispatch should repair that return
value to a valid error return code when it tries to dispatch
the signal that select() set in the task struct.

Note that select() only returns these values when signal_pending()
is true.
