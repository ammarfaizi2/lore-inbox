Return-Path: <linux-kernel-owner+w=401wt.eu-S964942AbXAJQek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964942AbXAJQek (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 11:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbXAJQek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 11:34:40 -0500
Received: from h155.mvista.com ([63.81.120.158]:17111 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S964942AbXAJQek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 11:34:40 -0500
Subject: Re: [PATCH 2.6.20-rc4 1/4] futex priority based wakeup
From: Daniel Walker <dwalker@mvista.com>
To: Pierre Peiffer <pierre.peiffer@bull.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Dinakar Guniguntala <dino@in.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Ingo Molnar <mingo@elte.hu>, Ulrich Drepper <drepper@redhat.com>,
       Jakub Jelinek <jakub@redhat.com>, Darren Hart <dvhltc@us.ibm.com>,
       =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
In-Reply-To: <45A51474.3040906@bull.net>
References: <45A3B330.9000104@bull.net>  <45A3BFC8.1030104@bull.net>
	 <1168445501.22579.7.camel@imap.mvista.com>  <45A51474.3040906@bull.net>
Content-Type: text/plain
Date: Wed, 10 Jan 2007 08:33:29 -0800
Message-Id: <1168446809.22579.10.camel@imap.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2007-01-10 at 17:29 +0100, Pierre Peiffer wrote:

> > 
> > Is this really necessary? The rtmutex will priority sort the waiters
> > when you enable priority inheritance. Inside the wake_futex_pi() it
> > actually just pulls the new owner off another plist inside the the
> > rtmutex structure.
> 
> Yes. ... necessary for non-PI-futex (ie "normal" futex)...
> 
> As the hash_bucket_list is used and common for both futex and PI-futex, yes, in 
> case of PI_futex, the task is queued two times in two plist.

You could make them distinct .. Also Did you consider merging the PI
path and the non-PI code path? then you could modify the rtmutex to
toggle PI depending .

Daniel

