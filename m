Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWFSJEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWFSJEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 05:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFSJEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 05:04:31 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:46978 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751253AbWFSJEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 05:04:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fz85qhe/wH9qsTIwMJmMu6cxVmOdRUWBLFNgSQJQloBmJpXstp107MnEancew5OX0jBf3xkE20nQKFJcns23pduUEEJ44aIXKcQ/zIw7SRctEBcNtgoSq26SZYFfLeKyGc1hX09z6QPludQIGDuxK1OdxpS+8cek1yxYxlHTzzU=
Message-ID: <9a8748490606190204n6e2ea0caua0015f4edd2fe7ac@mail.gmail.com>
Date: Mon, 19 Jun 2006 11:04:27 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Miklos Szeredi" <miklos@szeredi.hu>
Subject: Re: [PATCH 4/7] fuse: add POSIX file locking support
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <E1FsFGX-0002Pp-00@dorka.pomaz.szeredi.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <E1FplQT-0005yf-00@dorka.pomaz.szeredi.hu>
	 <E1FplXk-00062M-00@dorka.pomaz.szeredi.hu>
	 <9a8748490606190121u3c76c6bbif707835ec7e5873c@mail.gmail.com>
	 <E1FsFGX-0002Pp-00@dorka.pomaz.szeredi.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/06, Miklos Szeredi <miklos@szeredi.hu> wrote:
> > How about; on fuse startup, pick some semirandom number, store it
> > somewhere, then do an XOR of the pointer with the saved value to
> > scramble it, when you need to use it, simply XOR it again with the
> > stored value...  Not especially strong, but better than nothing and
> > better than just adding a constant that people can find out from the
> > source
>
> I think Andrew was suggesting a random key for the ADD function.
>
> > (and the scramble value would be differene each time fuse loads, so
> > at a minimum a different scramble key every boot) - also, XOR is a
> > quite fast operation so overhead should be low.
>
> I think XOR might be even weaker than ADD, because from gessing the
> difference between two values (easy) you might be able to guess the
> bits of the key.
>
> I'm actually looking for something stronger than XOR or ADD, but it's

How about using TEA (Tiny Encryption Algorithm), XTEA or XXTEA then?
They are quite simple algorithms, easy to implement and resonably fast
(with TEA being the simplest, but also weakest).
A hell of a lot better than just a simple XOR or ADD and probably more
than sufficient for this purpose.

  http://en.wikipedia.org/wiki/Tiny_Encryption_Algorithm
  http://www.simonshepherd.supanet.com/tea.htm
  http://www.ftp.cl.cam.ac.uk/ftp/papers/djw-rmn/djw-rmn-tea.html


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
