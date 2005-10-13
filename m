Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVJMUK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVJMUK1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVJMUK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:10:27 -0400
Received: from qproxy.gmail.com ([72.14.204.198]:44681 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932446AbVJMUK0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:10:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b1yLedpoQj0vgs7Oa/DeWf5t5K60ZobAb11dku9dkaAsWPqcYj19GRhuYGHe6xbNRpIF2pBByQ8vD1MoZiPOhkAFZUFCMlVpYb60qdxcA+ntT2xM0hcs8iDuj3mEaeM1Ymgy7fvkNJhZX6bWcITyCzHnsXNt/T7/r7CU49DxfDU=
Message-ID: <9a8748490510131310y2c31ac04w4ea34ee2333f7ff7@mail.gmail.com>
Date: Thu, 13 Oct 2005 22:10:25 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: "Miller, Mike (OS Dev)" <Mike.Miller@hp.com>
Subject: Re: [PATCH 09/14] Big kfree NULL check cleanup - misc remaining drivers
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Len Brown <len.brown@intel.com>, ISS StorageDev <iss_storagedev@hp.com>,
       Jakub Jelinek <jj@ultra.linux.cz>, Frodo Looijaard <frodol@dds.nl>,
       Jean Delvare <khali@linux-fr.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>, Roland Dreier <rolandd@cisco.com>,
       Sergio Rozanski Filho <aris@cathedrallabs.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pierre Ossman <drzeus-wbsd@drzeus.cx>,
       Carsten Gross <carsten@sol.wh-hms.uni-ulm.de>,
       Greg Kroah-Hartman <greg@kroah.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Vinh Truong <vinh.truong@eng.sun.com>,
       Mark Douglas Corner <mcorner@umich.edu>,
       Michael Downey <downey@zymeta.com>, Antonino Daplas <adaplas@pol.net>,
       Ben Gardner <bgardner@wabtec.com>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF10AF98879@cceexc23.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <D4CFB69C345C394284E4B78B876C1CF10AF98879@cceexc23.americas.cpqcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/05, Miller, Mike (OS Dev) <Mike.Miller@hp.com> wrote:
> > From: Jesper Juhl [mailto:jesper.juhl@gmail.com]
> > This is the remaining misc drivers/ part of the big kfree
> > cleanup patch.
> >
> > Remove pointless checks for NULL prior to calling kfree() in
> > misc files in drivers/.
> >
> >
> > --- linux-2.6.14-rc4-orig/drivers/block/cciss.c
> > 2005-10-11 22:41:05.000000000 +0200
> > +++ linux-2.6.14-rc4/drivers/block/cciss.c    2005-10-12
> > 17:43:18.000000000 +0200
> > @@ -1096,14 +1096,11 @@ static int cciss_ioctl(struct inode *ino
> >  cleanup1:
> >               if (buff) {
> >                       for(i=0; i<sg_used; i++)
> > -                             if(buff[i] != NULL)
> > -                                     kfree(buff[i]);
>
> I'm not sure I agree that these are pointless checks. They're not in the
> main code path so nothing is lost by checking first. What if the pointer
> is NULL????
>

If the pointer is NULL then this bit of code in kfree takes care of things :

 void kfree(const void *objp)
 {
...

         if (unlikely(!objp))
                 return;
...

Runtime behaviour is exactely the same.
kfree checks if the pointer passed to it is NULL in any case and just
returns if it is.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
