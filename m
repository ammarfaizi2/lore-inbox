Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161084AbWAHTTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161084AbWAHTTw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 14:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161101AbWAHTTw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 14:19:52 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:7241 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161086AbWAHTTu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 14:19:50 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e/O7xCaZvulBG3YPXEE5HsUtnLDn9LlKoO+ksT2Vb9QXvhiB7aIMIGTZ0VDB4ME8haKpLfXfe+ZXqt1f8yws6m86UaCDtXyO8wGcqYmQ6OINJWvQWSxvWkfX3cXpnNqSOKZ4JS3GSlwaqMZzLZyHoLBBmNs/PS7Owd3UxOwd4yc=
Message-ID: <46a038f90601081119r39014fbi995cc8b6e95774da@mail.gmail.com>
Date: Mon, 9 Jan 2006 08:19:50 +1300
From: Martin Langhoff <martin.langhoff@gmail.com>
To: "Brown, Len" <len.brown@intel.com>
Subject: Re: git pull on Linux/ACPI release tree
Cc: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org,
       linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org,
       git@vger.kernel.org
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13505@hdsmsx401.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/06, Brown, Len <len.brown@intel.com> wrote:
> Perhaps the tools should try to support what "a lot of people"
> expect, rather than making "a lot of people" do extra work
> because of the tools?

I think it does. All the tricky stuff that David and Junio have been
discussing is actually done very transparently by

    git-rebase <upstream>

Now, git-rebase uses git-format-patch <options> | git-am <options> so
it sometimes has problems merging. In that case, you can choose to
either resolve the problem (see the doco for how to signal to git-am
that you've resolved a conflict) or to cancel the rebase. If you
choose to cancel the rebase, do

   cp .git/refs/heads/{<headname>,<headnamebadrebase>}
   cat .git/HEAD_ORIG > .git/refs/heads/<headname>
   git-reset --hard
   rm -fr .dotest

and you'll be back to where you started. Perhaps this could be rolled
into something like git-rebase --cancel to make it easier, but that's
about it. The toolchain definitely supports it.

cheers,


martin
