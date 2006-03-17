Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752586AbWCQKoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752586AbWCQKoj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 05:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752588AbWCQKoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 05:44:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:30094 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1752586AbWCQKoi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 05:44:38 -0500
X-Authenticated: #14349625
Subject: interactive task starvation
From: Mike Galbraith <efault@gmx.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060317090653.GC13387@elte.hu>
References: <200603081013.44678.kernel@kolivas.org>
	 <20060307152636.1324a5b5.akpm@osdl.org>
	 <cone.1141774323.5234.18683.501@kolivas.org>
	 <200603090036.49915.kernel@kolivas.org>  <20060317090653.GC13387@elte.hu>
Content-Type: text/plain
Date: Fri, 17 Mar 2006 11:46:15 +0100
Message-Id: <1142592375.7895.43.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-17 at 10:06 +0100, Ingo Molnar wrote:

> yep, i think that's a good idea. In the worst case the starvation 
> timeout should kick in.

(I didn't want to hijack that thread ergo name change)

Speaking of the starvation timeout...

I'm beginning to wonder if it might not be a good idea to always have an
expired_timestamp to ensure that there is a limit to how long
interactive tasks can starve _each other_.  Yesterday, I ran some tests
with apache, and ended up waiting for over 3 minutes for a netstat|
grep :81|wc -l to finish when competing with 10 copies of httpd.  The
problem with the expired_timestamp is that if there is nobody already
expired, and if no non-interactive task exists, there's certainly no
expired_timestamp, there's no starvation limit. 

There are other ways to cure 'interactive starvation', but forcing an
array switch if a non-interactive task hasn't run for pick-a-number time
is the easiest.

	-Mike

(yup, folks would certainly feel it, and would _very_ likely gripe, so
it would probably have to be configurable)

