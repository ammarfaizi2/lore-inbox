Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965052AbWGJXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWGJXtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965057AbWGJXtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:49:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:48833 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965052AbWGJXtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:49:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=j2yoOkZntPap2m7P7pVJo41fqOXYo/DeYKTpn/H3VrhqE5+VNkiZfLYHzhQvrY6P/WAcLDVWYa5hndwWfcT2HdiiLSRWW91uE8da4bm+7uTy+EwT13GOYlmRMMei4VLy/55R4Iqx5/RiPJDLkpWEXbquSP5T7y0hJjELWmgGUTo=
Message-ID: <9e4733910607101649m21579ae2p9372cced67283615@mail.gmail.com>
Date: Mon, 10 Jul 2006 19:49:31 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty's use of file_list_lock and file_move
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101535i7f395686p7450dc524d9b82ae@mail.gmail.com>
	 <1152573312.27368.212.camel@localhost.localdomain>
	 <9e4733910607101604j16c54ef0r966f72f3501cfd2b@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about the use of lock/unlock_kernel(). Is there some hidden global
synchronization going on? Every time lock/unlock_kernel() is used
there is a tty_struct available. My first thought would be to turn
this into a per tty spinlock. Looking at where it is used it looks
like it was added to protect all of the VFS calls. I see no obvious
coordination with other ttys that isn't handled by other locks.

-- 
Jon Smirl
jonsmirl@gmail.com
