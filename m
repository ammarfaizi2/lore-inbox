Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262287AbVF2EyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262287AbVF2EyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbVF2EyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:54:12 -0400
Received: from [213.184.187.99] ([213.184.187.99]:44548 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S262284AbVF2EyE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:54:04 -0400
Message-Id: <200506290453.HAA14576@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Nathan Scott'" <nathans@sgi.com>
Cc: <linux-xfs@oss.sgi.com>, <linux-kernel@vger.kernel.org>,
       <linux-fsdevel@vger.kernel.org>, <reiserfs-list@namesys.com>
Subject: RE: XFS corruption during power-blackout
Date: Wed, 29 Jun 2005 07:53:09 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20050629001847.GB850@frodo>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV8R0RHxfHf5G1vQ8WamfNExp4fCAAFiv1g
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,
You wrote: {
On Tue, Jun 28, 2005 at 12:08:05PM +0300, Al Boldi wrote:
> True now, not so around 2.4.20 when XFS was rock-solid. I think they 
> tried to improve on performance and broke something. I wish they would 
> fix that because it forced me back to ext3, as in consistency over 
> performance any time.

Can you provide any details...
}

Specifically, in 2.4.20 I did an acid test:
Spawn 10 cp -a on some big dir like /usr.
Let it run for a few seconds, then pull the plug.
Don't reset-button, reset is different then pulling the plug.
Don't poweroff-button, poweroff is different then pulling the plug.
On reboot diff the dirs spawned.

What I found were 4 things in the dest dir:
1. Missing Dirs,Files. That's OK.
2. Files of size 0. That's acceptable.
3. Corrupted Files. That's unacceptable.
4. Corrupted Files with original fingerprint. That's ABSOLUTELY
unacceptable.

Ext3 performed best with minimal files of size 0.
XFS was second  with more files of size 0.
Reiser,JFS was worst with corruptions.

When XFS was added into the vanilla-Kernel it caused corruptions like Reiser
and JFS, which forced me back to Ext3.

