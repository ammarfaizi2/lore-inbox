Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUEJT0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUEJT0U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 15:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbUEJT0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 15:26:20 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:43936 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261321AbUEJT0T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 15:26:19 -0400
Date: Mon, 10 May 2004 15:26:02 -0400
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
       Jamie Lokier <jamie@shareable.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [ANNOUNCEMENT PATCH COW] proof of concept impementation of cowlinks
Message-ID: <20040510192601.GA11362@delft.aura.cs.cmu.edu>
Mail-Followup-To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
	Jamie Lokier <jamie@shareable.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040506131731.GA7930@wohnheim.fh-wedel.de> <20040508224835.GE29255@atrey.karlin.mff.cuni.cz> <20040510155359.GB16182@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040510155359.GB16182@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 05:53:59PM +0200, Jörn Engel wrote:
> A real problem is that copyfile() has all errno's from create(),
> sendfile() and unlink() combined, which doesn't make error handling in
> userspace easy.  "It could be this, that or another error" is the kind
> of mess I always hated about Windows, so I should try to do a little
> better.

Well, if you leave the create and unlink up to the application and
simply pass open filedescriptors to copyfile... But then it would be
equivalent to your new sendfile.

Copyfile can trivially be implemented in libc. I don't see why it would
have to be a system call. If a network filesystem wants to optimize the
file copying it could do this based on the sendfile data. If source and
destination are within the same filesystem and we're copying the whole
file starting at offset 0, send a copyfile RPC.

Jan
