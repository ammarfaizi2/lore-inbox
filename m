Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVAOChi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVAOChi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 21:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262167AbVAOChe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 21:37:34 -0500
Received: from hera.kernel.org ([209.128.68.125]:13479 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262156AbVAOChT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 21:37:19 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: short read from /dev/urandom
Date: Sat, 15 Jan 2005 02:36:56 +0000 (UTC)
Organization: Mostly alphabetical, except Q, which We do not fancy
Message-ID: <cs9vk8$43q$1@terminus.zytor.com>
References: <41E7509E.4030802@redhat.com> <20050114191056.GB17481@thunk.org> <41E833F4.8090800@redhat.com> <20050114232154.GB18479@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1105756616 4219 127.0.0.1 (15 Jan 2005 02:36:56 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Sat, 15 Jan 2005 02:36:56 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20050114232154.GB18479@thunk.org>
By author:    "Theodore Ts'o" <tytso@mit.edu>
In newsgroup: linux.dev.kernel
> 
> Good point.  The fact that there are other implementations out there
> which are doing this is a convincing argument.  
> 
> I am still a bit concerned still that a stupidly written program that
> opens /dev/urandom (perhaps unwittingly) and tries to read a few
> hundred megabytes will become uninterruptible until the read
> completes, but I'm not sure it's worth it to but in some kludge that
> says "break if there's a signal and count > 1 megabyte --- otherwise
> we'll return soon enough".
> 

I'm very concerned about this; this is fundamentally a change to
signal delivery semantics.

What we might want to go along with is a read smaller than PIPE_BUF
(the largest size guaranteed to be atomic when writing to a pipe,
which is another special case) should not return fractional.

	-hpa
