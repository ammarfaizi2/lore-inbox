Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965274AbWGJWfx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965274AbWGJWfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965290AbWGJWfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:35:53 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:52825 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965274AbWGJWfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:35:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TxmAkzYxO1OJOY16djSFnAPel5sDUUsjlkTcbUT2EOPZiOM8BE4dLKISoNijNiPveXHIP2HTPEx4l2Wa6kUSiWmwvckRckp21xpb7wCfEpvef765mFzMWcq6VYth11cEhfHOGLEIoTTP/jHcXmLrxDvb5PpL2BsPWV4pHcMBHEg=
Message-ID: <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
Date: Mon, 10 Jul 2006 18:35:50 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty's use of file_list_lock and file_move
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152554708.27368.202.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> We hold file_list_lock because we have to find everyone using that tty
> and hang up their instance of it, then flip the file operations not
> because we need to protect against tty structs going away. It's needed
> in order to walk the file list and protects against the file list itself
> changing rather than the tty structs. It may well be possible to move
> that to a tty layer private lock with care, but it would need care to
> deal with VFS operations.

Assuming do_SAK has blocked anyone's ability to newly open the tty,
why does it need to search every file handle in the system instead of
just using tty->tty_files? tty->tty_files should contain a list of
everyone who has the tty open. Is this global search needed because of
duplicated handles?

-- 
Jon Smirl
jonsmirl@gmail.com
