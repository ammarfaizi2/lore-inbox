Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbVHXGkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbVHXGkj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 02:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbVHXGkj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 02:40:39 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:392 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S1751480AbVHXGki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 02:40:38 -0400
Date: Wed, 24 Aug 2005 07:43:42 +0100
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.6.13-rc7
Message-ID: <20050824064342.GH9322@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508232203520.3317@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 10:08:13PM -0700, Linus Torvalds wrote:

>   cpu_exclusive sched domains on partial nodes temp fix

... breaks ppc64 since there we have node_to_cpumask() done as inlined
function, not a macro.  So we get __first_cpu(&node_to_cpumask(...),...),
with obvious consequences.

Locally I'm turning node_to_cpumask() into define, just to see what else
had changed in the build, but we probably want saner solution for that
one...
