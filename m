Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161303AbWASKBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161303AbWASKBd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 05:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161305AbWASKBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 05:01:33 -0500
Received: from vanessarodrigues.com ([192.139.46.150]:11183 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1161303AbWASKBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 05:01:32 -0500
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Andrew Morton <akpm@osdl.org>,
       Chandra Seetharaman <sekharan@us.ibm.com>, Keith Owens <kaos@sgi.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] Notifier chain update
References: <20060118220122.GH16285@kvack.org>
	<Pine.LNX.4.44L0.0601181706210.14089-100000@iolanthe.rowland.org>
	<20060118221525.GI16285@kvack.org>
From: Jes Sorensen <jes@sgi.com>
Date: 19 Jan 2006 05:01:30 -0500
In-Reply-To: <20060118221525.GI16285@kvack.org>
Message-ID: <yq0mzhs7czp.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Benjamin" == Benjamin LaHaise <bcrl@kvack.org> writes:

Benjamin> On Wed, Jan 18, 2006 at 05:09:10PM -0500, Alan Stern wrote:
>> On Wed, 18 Jan 2006, Benjamin LaHaise wrote:
>> 
>> > The notifier interface is supposed to be *light weight*.
>> 
>> Again, where is that documented?

Benjamin> Read the kernel.  Notifiers are called from all sorts of hot
Benjamin> paths, so they damned well better be light.

Ben,

There' plenty of cases where adding a new notifier chain will be
preferred to adding a long list of if (foo) call() items. One place is
the fork()/exit() path for more system accounting. Being able to sleep
in those places is needed. Fortunately one can do them lock free as
they are in task context, but you need to be able to kmalloc() there.

Cheers,
Jes
