Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265404AbTFRRCs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 13:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbTFRRCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 13:02:48 -0400
Received: from terminus.zytor.com ([63.209.29.3]:40930 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S265404AbTFRRCp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 13:02:45 -0400
Message-ID: <3EF09E71.8020406@zytor.com>
Date: Wed, 18 Jun 2003 10:16:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: David Howells <dhowells@warthog.cambridge.redhat.com>
CC: David Howells <dhowells@cambridge.redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VFS autmounter support
References: <18943.1055925426@warthog.warthog>
In-Reply-To: <18943.1055925426@warthog.warthog>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Howells wrote:
>>
>>That's actually not true.  It's lstat() that mustn't cause the automount
>>point to mount -- stat() only comes into play if lstat() resolves to a
>>symlink.  However, lstat() never invokes follow_link, so creating a
>>dentry with a follow_link method resolving to itself, and an associated
>>dummy directory inode, does what's required.
> 
> That _is_ actually true. Doing "ls -l" in that directory would otherwise cause
> a mount storm.
> 

It's not.  ls -l and all the GUI tools do lstat(), not stat().

> follow_link resolving to itself? Surely that'll cause ELOOP very quickly? And
> where does this "dummy directory inode" live?

Nope.  You can follow_link() nonrecursively.  You need a dummy directory 
inode to mount upon anyway.

	-hpa

