Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUIOXFm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUIOXFm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267700AbUIOXFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 19:05:22 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49814 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267765AbUIOXCU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 19:02:20 -0400
Date: Thu, 16 Sep 2004 00:02:17 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Andrew Schretter <schrett@math.duke.edu>, NFS@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: vfs bug. was: Re: [NFS] 2.6.8.1 kernel NFS client connectathon failure
Message-ID: <20040915230217.GM23987@parcelfarce.linux.theplanet.co.uk>
References: <200409152054.i8FKsTNV002355@roma.math.duke.edu> <20040915222358.GA23118@janus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915222358.GA23118@janus>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 12:23:58AM +0200, Frank van Maarseveen wrote:
> Behavior I see is identical to that on a local (ext3) fs on 2.6.8.1 and
> also on local ext3 on 2.4.27, namely that TEMP/BAR still exists. This
> looks like a long standing kernel bug since the rename(2) seems to
> succeed:
> 
> (snippet from strace):
> write(3, "...", 3)                      = 3
> close(3)                                = 0
> link("FOO", "TEMP/BAR")                 = 0
> rename("TEMP/BAR", "FOO")               = 0
> unlink("FOO")                           = 0

Behaviour is REQUIRED by POSIX and SuS.

<quote>
     If the old argument and the new argument both refer to, and both
     link to the same existing file, rename() returns successfully and
     performs no other action.
</quote>

So what you get is
	* after link(2) success - FOO and TEMP/BAR being links to the same
file.
	* after rename(2) (required) success - same as before
	* after unlink(2) - FOO is removed, TEMP/BAR remains.
