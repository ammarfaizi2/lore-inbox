Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261348AbVBGDKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261348AbVBGDKM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 22:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVBGDKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 22:10:12 -0500
Received: from almesberger.net ([63.105.73.238]:9736 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261348AbVBGDJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 22:09:53 -0500
Date: Mon, 7 Feb 2005 00:09:22 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Con Kolivas <kernel@kolivas.org>
Cc: "Jack O'Quin" <joq@io.com>, linux <linux-kernel@vger.kernel.org>,
       abiss-general@lists.sourceforge.net
Subject: Re: [PATCH]sched: Isochronous class v2 for unprivileged soft rt scheduling
Message-ID: <20050207000922.B25338@almesberger.net>
References: <41EEE1B1.9080909@kolivas.org> <41EF00ED.4070908@kolivas.org> <873bwwga0w.fsf@sulphur.joq.us> <41EF123D.703@kolivas.org> <87ekgges2o.fsf@sulphur.joq.us> <41EF2E7E.8070604@kolivas.org> <87oefkd7ew.fsf@sulphur.joq.us> <41EF48BA.50709@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41EF48BA.50709@kolivas.org>; from kernel@kolivas.org on Thu, Jan 20, 2005 at 04:59:22PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Cc:s trimmed, added abiss-general ]

Con Kolivas wrote:
> Possibly reiserfs journal related. That has larger non-preemptible code 
> sections.

If I understand your workload right, it should consist mainly of
computation, networking (?), and disk reads.

I don't know much about ReiserFS, but in some experiments with ext3,
using ABISS, we found that a reader application competing with best
effort readers would experience worst-case delays of dozens of
milliseconds.

They were caused by journaled atime updates. Mounting the file
system with "noatime" reduced delays to a few hundred microseconds
(still worst-case).

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
