Return-Path: <linux-kernel-owner+w=401wt.eu-S1752042AbWLNHpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbWLNHpI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 02:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbWLNHpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 02:45:08 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:36538 "EHLO
	sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752042AbWLNHpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 02:45:05 -0500
X-IronPort-AV: i="4.12,166,1165219200"; 
   d="scan'208"; a="90546604:sNHT65649006"
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Ben Collins <ben.collins@ubuntu.com>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.20-rc1] ib_verbs: Use explicit if-else statements to avoid errors with do-while macros
X-Message-Flag: Warning: May contain useful information
References: <1166065805.6748.135.camel@gullible>
	<20061214064430.GM4587@ftp.linux.org.uk>
	<20061214065624.GN4587@ftp.linux.org.uk>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 13 Dec 2006 23:45:03 -0800
In-Reply-To: <20061214065624.GN4587@ftp.linux.org.uk> (Al Viro's message of "Thu, 14 Dec 2006 06:56:24 +0000")
Message-ID: <ada4pryq5ts.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 14 Dec 2006 07:45:03.0844 (UTC) FILETIME=[C43D3240:01C71F53]
Authentication-Results: sj-dkim-3; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim3002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > IOW, do ; while(0) / do { } while (0)  is not a proper way to do a macro
 > that imitates a function returning void.
 > 
 > Objections?

None from me, although the ternary ? : is a pretty odd way to write

	if (blah)
		do_this_void_function();
	else
		do_that_void_function();

so I'm in favor of that half of the patch anyway.  It's my fault for
not noticing that part of the patch in the first place.

Changing the non-void ? : constructions is just churn, but there's no
sense changing it again now that the patch is merged.

 - R.
