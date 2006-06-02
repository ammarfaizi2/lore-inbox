Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751381AbWFBQlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751381AbWFBQlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751394AbWFBQlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 12:41:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:24226 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751381AbWFBQlF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 12:41:05 -0400
To: vgoyal@in.ibm.com
Cc: Preben Traerup <Preben.Trarup@ericsson.com>,
       "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>,
       fastboot@lists.osdl.org,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [RFC][PATCH] Add missing notifier before crashing
References: <20060530145658.GC6536@in.ibm.com>
	<20060531182045.9db2fac9.akiyama.nobuyuk@jp.fujitsu.com>
	<20060531154322.GA8475@in.ibm.com>
	<20060601213730.dc9f1ec4.akiyama.nobuyuk@jp.fujitsu.com>
	<20060601151605.GA7380@in.ibm.com>
	<20060602141301.cdecf0e1.akiyama.nobuyuk@jp.fujitsu.com>
	<44800E1A.1080306@ericsson.com>
	<m1fyin6agv.fsf@ebiederm.dsl.xmission.com>
	<44803B1F.8070302@ericsson.com>
	<m13ben60tn.fsf@ebiederm.dsl.xmission.com>
	<20060602153717.GC29610@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 02 Jun 2006 10:39:42 -0600
In-Reply-To: <20060602153717.GC29610@in.ibm.com> (Vivek Goyal's message of
 "Fri, 2 Jun 2006 11:37:17 -0400")
Message-ID: <m1irnj4ilt.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:


> So basically the idea is that whatever one wants to do it should be done
> in the next kernel, even notifications. But this might require some data
> from the context of previous kernel, for example destination IP address etc.
> So the associated data either needs to be passed to new kernel or it shall
> have to be retrieved from permanent storage or something like that.

Yes.  

Except when under tight time constraints this is clearly possible.
When under time constraints things are more dicy. I expect that
with a tuned kernel you can be back in user space in about 1 second.

Detecting a failure is hard and slow.  Unless the condition that
triggers the panic is the initial source of the panic it is quite
likely a time window less than 1 second has already elapsed.

So I am certainly willing to discuss this but until I see a clear
model where a new kernel will not meet the time constraints for
some fairly fundamental reasons, and that a crash notifier
will almost always meet those same time constraints, I can't imagine
a persuasive case.

The panic notifier itself is barely used and it seems to exist
only because we didn't have a general purpose policy mechanism.

Eric
