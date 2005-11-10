Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVKJOEW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVKJOEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVKJOEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:04:21 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:22713 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750921AbVKJOET
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:04:19 -0500
Date: Thu, 10 Nov 2005 14:04:19 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Peter Staubach <staubach@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] handling 64bit values for st_ino]
Message-ID: <20051110140419.GF7992@ftp.linux.org.uk>
References: <20051110003024.GD7992@ftp.linux.org.uk> <437343B1.5000809@redhat.com> <20051110134336.GE7992@ftp.linux.org.uk> <4373508F.9060004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4373508F.9060004@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2005 at 08:52:15AM -0500, Peter Staubach wrote:
> Two different sized types to describe inode numbers, different paths, etc.
> Having two of something, when just one would suffice, is usually more
> complicated.

_What_ different paths?  And what "two of something"?

The only requirement for fs that want to report wider st_ino is
to put the right value into kstat->ino in their ->getattr().

And there's already a plenty of filesystems using iget5() et.al.
for icache lookups - this isn't adding anything new.

As far as 64bit ino_t is concerned - no, thanks.  We'd need to walk through
all existing fs code and audit existing uses of ino_t.  Which is far more
of support burden.

And then there's an issue of overhead on normal icache lookups for nearly
all existing filesystems; ones that do wider lookup keys are *already* using
iget5(), BTW.   So you'll simply punish all users of iget().
