Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316662AbSE3Og1>; Thu, 30 May 2002 10:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSE3Og0>; Thu, 30 May 2002 10:36:26 -0400
Received: from c2ce9fba.adsl.oleane.fr ([194.206.159.186]:3449 "EHLO
	avalon.france.sdesigns.com") by vger.kernel.org with ESMTP
	id <S316662AbSE3OgX>; Thu, 30 May 2002 10:36:23 -0400
To: linux-kernel@vger.kernel.org
Subject: large copy_to_user fills only one page?
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 30 May 2002 16:36:22 +0200
Message-ID: <7wofexu2hl.fsf@avalon.france.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working with linux-2.4.18, and writing some
trivial code to get from kernel a grabbed image working this way:

#define IMSIZE 350000

user mode runs:
u_p=malloc(IMSIZE);
ioctl(grabberfd,DOGRAB,u_p);
write *u_p to disk
free(u_p);

kernelmode runs:
case DOGRAB:
        char *u_p,*k_p;
        copy_from_user(u_p,arg,sizeof(char *));
        k_p=vmalloc(IMSIZE);
        kernelgrabs(k_p);
        copy_to_user(u_p,k_p,IMSIZE);
        vfree(k_p);
        break;

What I get actually is only 4K filled in userland, but copy_to_user
returns IMSIZE!

If I memset the memory area *u_p to any value, the grab happens
properly.

I guess memset'ing faults the good pages in, I'm quite surprised
this does not happen smoothly by itself ;-( 

Any clue?

Sincerely yours,

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
