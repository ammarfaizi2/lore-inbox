Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264444AbUFNVNY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUFNVNY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 17:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264482AbUFNVNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 17:13:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18637 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264444AbUFNVNU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 17:13:20 -0400
To: Cesar Eduardo Barros <cesarb@nitnet.com.br>
Cc: linux-kernel@vger.kernel.org, Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] O_NOATIME support
References: <20040612011129.GD1967@flower.home.cesarb.net>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: Red Hat Global Engineering Services Compiler Team
Date: 14 Jun 2004 18:12:59 -0300
In-Reply-To: <20040612011129.GD1967@flower.home.cesarb.net>
Message-ID: <orpt81sv1g.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 11, 2004, Cesar Eduardo Barros <cesarb@nitnet.com.br> wrote:

> int O_NOATIME  	Macro
>   If this bit is set, read will not update the access time of the file.
>   See File Times. This is used by programs that do backups, so that
>   backing a file up does not count as reading it. Only the owner of the
>   file or the superuser may use this bit.

IMHO it's a bad idea to enable the owner of the file to avoid changing
the atime of their files.  I've heard more than once about the atime
bit being used to as proof that a user had actually seen the contents
of a file although s/he claimed s/he hadn't.  If it was root-only,
atime could still be used for the same purpose, and would enable
backups with tools that accessed the filesystem through the FS layer,
as opposed to though the block layer, to keep such proof unchanged.

-- 
Alexandre Oliva             http://www.ic.unicamp.br/~oliva/
Red Hat Compiler Engineer   aoliva@{redhat.com, gcc.gnu.org}
Free Software Evangelist  oliva@{lsd.ic.unicamp.br, gnu.org}
