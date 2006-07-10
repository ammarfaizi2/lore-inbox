Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422719AbWGJR15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422719AbWGJR15 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 13:27:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422720AbWGJR14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 13:27:56 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:34936 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1422719AbWGJR14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 13:27:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uQwBn23er/8N/d/I1M2e85Go/FC3SIw6ezh394CyM+xXo/HXyKbTe2KumMQYZ6EdRoGLCzBH0VROWg78VsglYJ4270LSrnOCVXjQpCsz9kzx2DzJkIO2+e9bJfUtjvpyNTU4BubAcI3cggJ0HEo8B+qJY5oiBlDP2t+FU8IXbr8=
Message-ID: <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
Date: Mon, 10 Jul 2006 13:27:54 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Subject: Re: tty's use of file_list_lock and file_move
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1152552806.27368.187.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/10/06, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> Ar Llu, 2006-07-10 am 11:10 -0400, ysgrifennodd Jon Smirl:
> > Since you want a new subject can you explain tty's use of file_lock to
> > me? Is there some non-obvious global coordination happening here or is
> > it work breaking down the big kernel lock that never got finished?
>
> Its explained in the comment in do_SAK.

This problem seems to be aggravated by reusing the tty_struct for that
tty. With the refcount patch it is now easy to disassociate an
existing tty (and the processes attached to it) from the array
tracking tty minors. A new clean tty_struct can be allocated and made
visible. Init will grab this new struct. Now there is no way to get to
the old one and it can be cleaned up and deleted.

Is this strategy worth coding up? It would really simplify the locking issues.

-- 
Jon Smirl
jonsmirl@gmail.com
