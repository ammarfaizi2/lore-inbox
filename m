Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264505AbUEJFQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264505AbUEJFQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 01:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264518AbUEJFQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 01:16:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:31381 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S264505AbUEJFQp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 01:16:45 -0400
To: =?iso-8859-1?q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org, Jamie Lokier <jamie@shareable.org>,
       Pavel Machek <pavel@ucw.cz>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
References: <20040506131731.GA7930@wohnheim.fh-wedel.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 May 2004 23:15:33 -0600
In-Reply-To: <20040506131731.GA7930@wohnheim.fh-wedel.de>
Message-ID: <m1pt9clv62.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel <joern@wohnheim.fh-wedel.de> writes:
> 3 copyfile		- new copyfile() system call
> http://wohnheim.fh-wedel.de/~joern/cowlink/

Question about sys_copyfile.

Is the intention that a new file with completely new permissions
be created?

Some people have wanted a copyfile that copies all of the extra
metadata user/group/acls.

I currently see technical merit in both approaches.

Looking at the CIFS information it appears that the CopyFILE RPC
copies the permissions.  It is not at all clear about that, and
the fact it appears to copy permissions may simply be a specification
bug.  Given that FAT does not really have permissions, let alone
extended attributes it would be an easy mistake to make.

In the general case you cannot copy permissions from one file to
another, either you don't have those permissions yourself or the
target file system may not support them all.  Not copying
permissions leads to a simpler implementation with the burden
of the work left to user space.  What is not done is a loop through
the extended attributes.

Eric

